// routes/equipment.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { protect, authorize } = require('../middleware/auth');

// @route GET /api/equipment
// @desc List all equipment with category name (Publicly browsable)
// @access Public (No authentication required to view inventory)
router.get('/', async (req, res) => {
    const { category_id, search } = req.query; // Allow filtering by category or search
    
    let sql = `
        SELECT e.*, c.name AS category_name
        FROM equipment_management.equipment_data e
        JOIN equipment_management.catagory_data c ON e.category_id = c.category_id
        WHERE 1=1
    `;
    const params = [];

    // Filter by Category ID
    if (category_id) {
        sql += ' AND e.category_id = ?';
        params.push(category_id);
    }
    
    // Search by Equipment Name
    if (search) {
        sql += ' AND e.name LIKE ?';
        params.push(`%${search}%`);
    }

    try {
        const [equipment] = await db.execute(sql, params);
        res.json(equipment);
    } catch (error) {
        console.error('Error fetching equipment:', error);
        res.status(500).json({ message: 'Server error fetching equipment list' });
    }
});

// @route POST /api/equipment
// @desc Add new equipment (Only Admin can add inventory)
// @access Private (Admin only)
router.post('/', protect, authorize('admin'), async (req, res) => {
    // Note: available_quantity is set automatically to total_quantity on creation
    const { name, category_id, total_quantity, condition } = req.body;
    
    if (!name || !category_id || total_quantity === undefined || total_quantity < 0 || !condition) {
        return res.status(400).json({ message: 'Please provide valid name, category_id, positive total_quantity, and condition.' });
    }

    const available_quantity = total_quantity;

    try {
        const [result] = await db.execute(
    'INSERT INTO equipment_management.equipment_data (name, category_id, total_quantity, available_quantity, `condition`) VALUES (?, ?, ?, ?, ?)',
    [name, category_id, total_quantity, available_quantity, condition]
);

        res.status(201).json({ 
            equipment_id: result.insertId, 
            message: 'Equipment added successfully.',
            name, category_id, total_quantity, available_quantity, condition
        });
    } catch (error) {
        console.error('Error adding equipment:', error);
        res.status(500).json({ message: 'Server error adding equipment' });
    }
});

// @route PUT /api/equipment/:id
// @desc Update equipment details (Admin can change total quantity, name, etc.)
// @access Private (Admin only)
router.put('/:id', protect, authorize('admin'), async (req, res) => {
    const { name, category_id, total_quantity, condition } = req.body;
    const { id } = req.params;

    if (!name || !category_id || total_quantity === undefined || total_quantity < 0 || !condition) {
        return res.status(400).json({ message: 'Please provide valid name, category_id, total_quantity, and condition.' });
    }

    // Advanced: Update available_quantity based on change in total_quantity 
    // We fetch the current quantities and calculate the difference.
    try {
        const [currentEquipment] = await db.execute('SELECT total_quantity, available_quantity FROM equipment_management.equipment_data WHERE equipment_id = ?', [id]);
        if (currentEquipment.length === 0) {
            return res.status(404).json({ message: 'Equipment not found' });
        }
        
        const currentTotal = currentEquipment[0].total_quantity;
        const currentAvailable = currentEquipment[0].available_quantity;
        const totalDelta = total_quantity - currentTotal; // Change in total inventory

        let newAvailableQuantity = currentAvailable + totalDelta;
        
        // Safety check: Cannot reduce total quantity below currently available count
        if (newAvailableQuantity < 0) {
             return res.status(400).json({ 
                 message: `Cannot reduce total quantity to ${total_quantity}. You currently have ${currentTotal - currentAvailable} items issued.` 
             });
        }
        
        // Update the item
        const [result] = await db.execute(
            'UPDATE equipment_management.equipment_data SET name = ?, category_id = ?, total_quantity = ?, available_quantity = ?, `condition` = ? WHERE equipment_id = ?',
            [name, category_id, total_quantity, newAvailableQuantity, condition, id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Equipment not found or no change made' });
        }

        res.json({ message: 'Equipment updated successfully.', equipment_id: id });
    } catch (error) {
        console.error('Error updating equipment:', error);
        res.status(500).json({ message: 'Server error updating equipment' });
    }
});

// @route DELETE /api/equipment/:id
// @desc Delete equipment
// @access Private (Admin only)
router.delete('/:id', protect, authorize('admin'), async (req, res) => {
    const { id } = req.params;

    // IMPORTANT: In a real app, you would check for active loans (status='issued') first.
    // For this phase, we allow direct deletion for simplicity.
    try {
        const [result] = await db.execute('DELETE FROM equipment_management.equipment_data WHERE `equipment_id` = ?', [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Equipment not found' });
        }

        res.json({ message: 'Equipment deleted successfully.' });
    } catch (error) {
        console.error('Error deleting equipment:', error);
        res.status(500).json({ message: 'Server error deleting equipment' });
    }
});

module.exports = router;
