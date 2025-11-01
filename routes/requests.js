// routes/requests.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { protect, authorize } = require('../middleware/auth');


// Roles authorized to manage requests (approve, reject, issue, return)
const requestManagerRoles = ['staff', 'admin'];

// @route POST /api/requests
// @desc Create a new equipment request
// @access Private (All authenticated users)
router.post('/', protect, async (req, res) => {
    console.log('Request Body:', req.body); // Debugging line
    const user_id = req.user.id;
    const { equipment_id, quantity, admin_notes, return_date } = req.body;

    // if (!equipment_id || !quantity || !return_date || quantity <= 0) {
    //     debugger;
    //     return res.status(400).json({ message: 'Missing or invalid equipment_id, quantity, or return_date.' });
    // }

    if (!equipment_id ) {
        
        return res.status(400).json({ message: 'Missing or invalid equipment_id' });
    }
 if (!quantity ) {
        
        return res.status(400).json({ message: 'Missing or invalid quantity' });
    }
    if (!return_date ) {    
        return res.status(400).json({ message: 'Missing or invalid return_date' });
    }
    if (quantity <= 0) {
        return res.status(400).json({ message: 'Quantity must be greater than zero.' });
    }
    try {
        // 1. Check if equipment exists and is available
        const [equipment] = await db.execute('SELECT available_quantity FROM equipment_management.equipment_data WHERE equipment_id = ?', [equipment_id]);
        if (equipment.length === 0) {
            return res.status(404).json({ message: 'Equipment not found.' });
        }

        const available = equipment[0].available_quantity;

        if (quantity > available) {
            return res.status(400).json({ message: `Requested quantity (${quantity}) exceeds available stock (${available}).` });
        }

        // 2. Insert new request
        const [result] = await db.execute(
            'INSERT INTO equipment_management.request_data (user_id, equipment_id, quantity, return_date,admin_notes, status)VALUES (?, ?, ?, ?, ?,?)',
            [user_id, equipment_id, quantity, return_date,admin_notes, 'pending']
        );

        res.status(201).json({ 
            request_id: result.insertId, 
            message: 'Equipment request submitted successfully. Awaiting approval.' 
        });
    } catch (error) {
        console.error('Error creating request:', error);
        res.status(500).json({ message: 'Server error creating request.' });
    }
});

// @route GET /api/requests
// @desc List requests (filtered by role)
// @access Private (All authenticated users)
router.get('/', protect, async (req, res) => {
    const userId = req.user.id;
    const userRole = req.user.role;
    
    // Base SQL for all requests, joining Users and Equipment details
    let sql = `
        SELECT 
            r.*, 
            u.full_name AS requested_by, 
            e.name AS equipment_name, 
            c.name AS category_name
        FROM request_data r
        JOIN equipment_management.user_data u ON r.user_id = u.user_id
        JOIN equipment_management.equipment_data e ON r.equipment_id = e.equipment_id
        JOIN equipment_management.catagory_data c ON e.category_id = c.category_id
    `;
    const params = [];

    // Filter by role: Students only see their own requests
    if (userRole === 'student') {
        sql += ' WHERE r.user_id = ?';
        params.push(userId);
    } 
    // Staff/Admin see all requests (no WHERE clause needed if the base SQL is all-inclusive)
    sql += ' ORDER BY r.request_date DESC';

    try {
        const [requests] = await db.execute(sql, params);
        res.json(requests);
    } catch (error) {
        console.error('Error fetching requests:', error);
        res.status(500).json({ message: 'Server error fetching requests list' });
    }
});

// --- MANAGEMENT ACTIONS (Staff and Admin Only) ---

// Helper function to update stock and request status (Used for approval/return)
async function updateStockAndRequest(requestId, equipmentId, quantity, newStatus, isReturn = false) {
    // Determine the stock change: -quantity for issue/approval, +quantity for return
    const stockChange = isReturn ? quantity : -quantity;
    const dbConnection = await db.getConnection(); // Get a connection for transaction

    try {
        await dbConnection.beginTransaction();

        // 1. Update Equipment Stock
        await dbConnection.execute(
            'UPDATE equipment_management.equipment_data SET available_quantity = available_quantity + ? WHERE equipment_id = ?',
            [stockChange, equipmentId]
        );

        // 2. Update Request Status
        await dbConnection.execute(
            'UPDATE equipment_management.request_data SET status = ? WHERE request_id = ?',
            [newStatus, requestId] // Use a real user ID here later
        );

        await dbConnection.commit();
        return true;
    } catch (error) {
        await dbConnection.rollback();
        console.error(`Transaction failed for Request ID ${requestId}:`, error);
        throw new Error(`Transaction failed: ${error.message}`);
    } finally {
        dbConnection.release();
    }
}


// @route PUT /api/requests/:id/approve
// @desc Approve a pending request (Staff/Admin) - Decrements available stock
// @access Private (Staff/Admin only)
router.put('/:id/approve', protect, authorize(requestManagerRoles), async (req, res) => {
    const { id } = req.params;
    
    try {
        const [request] = await db.execute('SELECT equipment_id, quantity, status FROM equipment_management.request_data WHERE request_id = ?', [id]);
        
        if (request.length === 0) return res.status(404).json({ message: 'Request not found.' });
        if (request[0].status !== 'pending') return res.status(400).json({ message: `Cannot approve request with status: ${request[0].status}.` });

        // Decrease stock and set status to 'approved'
        await updateStockAndRequest(id, request[0].equipment_id, request[0].quantity, 'approved', false);

        res.json({ message: 'Request approved and stock reserved/decremented.' });
    } catch (error) {
        res.status(500).json({ message: error.message || 'Server error during approval process.' });
    }
});

// @route PUT /api/requests/:id/reject
// @desc Reject a pending request (Staff/Admin)
// @access Private (Staff/Admin only)
router.put('/:id/reject', protect, authorize(requestManagerRoles), async (req, res) => {
    const { id } = req.params;

    try {
        const [result] = await db.execute(
            'UPDATE equipment_management.request_data SET status = ? WHERE request_id = ? AND status = ?',
            ['rejected', id, 'pending']
        );

        if (result.affectedRows === 0) {
            return res.status(400).json({ message: 'Request not found or not in pending status.' });
        }
        res.json({ message: 'Request rejected successfully.' });
    } catch (error) {
        console.error('Error rejecting request:', error);
        res.status(500).json({ message: 'Server error rejecting request.' });
    }
});

// @route PUT /api/requests/:id/issue
// @desc Issue equipment (Staff/Admin) - Changes status to 'issued'
// @access Private (Staff/Admin only)
router.put('/:id/issue', protect, authorize(requestManagerRoles), async (req, res) => {
    const { id } = req.params;

    try {
        const [result] = await db.execute(
            'UPDATE equipment_management.request_data SET status = ? WHERE request_id = ? AND status = ?',
            ['issued', id, 'approved']
        );

        if (result.affectedRows === 0) {
            return res.status(400).json({ message: 'Request not found or not in approved status.' });
        }
        res.json({ message: 'Equipment issued successfully.' });
    } catch (error) {
        console.error('Error issuing equipment:', error);
        res.status(500).json({ message: 'Server error issuing equipment.' });
    }
});

// @route PUT /api/requests/:id/return
// @desc Process return (Staff/Admin) - Increments available stock
// @access Private (Staff/Admin only)
router.put('/:id/return', protect, authorize(requestManagerRoles), async (req, res) => {
    const { id } = req.params;

    try {
        const [request] = await db.execute('SELECT equipment_id, quantity, status FROM equipment_management.request_data WHERE request_id = ?', [id]);
        
        if (request.length === 0) return res.status(404).json({ message: 'Request not found.' });
        if (request[0].status !== 'issued') return res.status(400).json({ message: `Cannot return request with status: ${request[0].status}.` });

        // Increase stock and set status to 'returned'
        await updateStockAndRequest(id, request[0].equipment_id, request[0].quantity, 'returned', true);

        res.json({ message: 'Equipment return processed successfully, stock incremented.' });
    } catch (error) {
        res.status(500).json({ message: error.message || 'Server error during return process.' });
    }
});

module.exports = router;
