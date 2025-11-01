// routes/auth.js
const express = require('express');
const router = express.Router(); // CRITICAL: Initialize the router here
const bcrypt = require('bcryptjs');
const db = require('../config/db');
// Import generateToken from the middleware file
const { generateToken } = require ('../middleware/auth'); // Corrected typo in require()

// @route POST /api/auth/signup
// @desc Register a new user (default role: student) with PRN validation
// @access Public
router.post('/signup', async (req, res) => {
    // ❗ CHANGE 1: Destructure prn_number from req.body
    const { username, password, full_name, prn_number, role = 'student' } = req.body; 

    // ❗ CHANGE 2: Enforce PRN is required for student signups
    if (!username || !password || !full_name || !prn_number) {
        return res.status(400).json({ message: 'Please enter all required fields: username, password, full name, and PRN number.' });
    }

    // Role is hardcoded to 'student' to prevent self-assigned elevated roles via this public endpoint.
    const finalRole = 'student';

    try {
        // --- PRN VALIDATION CHECKS (New Logic) ---

        // 1. Check if PRN exists in the RegisteredStudents table
        const [registered] = await db.execute(
            'SELECT prn_number FROM RegisteredStudents WHERE prn_number = ?',
            [prn_number]
        );

        if (registered.length === 0) {
            // Unregistered PRN
            return res.status(401).json({ message: 'Invalid PRN Number. Registration is restricted to verified students.' });
        }

        // 2. Check if PRN is already claimed by an existing user
        const [existingUserByPrn] = await db.execute(
            'SELECT user_id FROM user_data WHERE prn_number = ?',
            [prn_number]
        );

        if (existingUserByPrn.length > 0) {
            return res.status(409).json({ message: 'This PRN number has already been registered and claimed.' });
        }

        // --- EXISTING USERNAME CHECK ---

        // 3. Check if username already exists
        const [users] = await db.execute('SELECT user_id FROM user_data WHERE username = ?', [username]);
        if (users.length > 0) {
            return res.status(400).json({ message: 'User with this username already exists.' });
        }

        // --- USER CREATION ---

        // 4. Hash Password 
        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(password, salt);

        // ❗ CHANGE 3: Include prn_number in the INSERT query
        // 5. Insert New User into DB
        const [result] = await db.execute(
            'INSERT INTO user_data (username, password_hash, full_name, role, prn_number) VALUES (?, ?, ?, ?, ?)',
            [username, password_hash, full_name, finalRole, prn_number]
        );
        const userId = result.insertId;

        // 6. Respond with token and user data
        res.status(201).json({
            user_id: userId,
            username,
            role: finalRole,
            message: 'User registered successfully with PRN validation.',
            token: generateToken(userId, finalRole) 
        });

    } catch (error) {
        console.error('Registration error:', error);
        // Note: Catch database constraint errors (e.g., duplicate PRN if FOREIGN KEY was set to UNIQUE)
        res.status(500).json({ message: 'Server error during registration.' }); 
    }
});

// @route POST /api/auth/login
// @desc Authenticate user and return token
// @access Public
router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        // 1. Find User by username
        const [users] = await db.execute('SELECT user_id, password_hash, role FROM user_data WHERE username = ?', [username]);
        const user = users[0];

        if (!user) {
            return res.status(401).json({ message: 'Invalid credentials: User not found.' });
        }

        // 2. Compare Password 
        const isMatch = await bcrypt.compare(password, user.password_hash);

        if (isMatch) {
            // 3. Passwords match - generate token and send response
            res.json({
                user_id: user.user_id,
                username,
                role: user.role,
                message: 'Login successful.',
                token: generateToken(user.user_id, user.role),
            });
        } else {
            // 401: Unauthorized
            res.status(401).json({ message: 'Invalid credentials: Password incorrect.' });
        }
    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ message: 'Server error during login.' });
    }
});

module.exports = router; // CRITICAL: Export the initialized router
