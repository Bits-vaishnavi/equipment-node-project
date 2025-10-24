// routes/auth.js
const express = require('express');
const router = express.Router(); // CRITICAL: Initialize the router here
const bcrypt = require('bcryptjs');
const db = require('../config/db');
// Import generateToken from the middleware file
const { generateToken } = require('../middleware/auth');

// @route POST /api/auth/signup
// @desc Register a new user (default role: student)
// @access Public
router.post('/signup', async (req, res) => {
    // Note: This endpoint should be secured/removed in a real production app 
    // to prevent unauthorized role assignment.
    const { username, password, full_name, role = 'student' } = req.body; 

    if (!username || !password || !full_name) {
        return res.status(400).json({ message: 'Please enter all required fields: username, password, and full name.' });
    }

    try {
        // 1. Check if user already exists
        const [users] = await db.execute('SELECT user_id FROM user_data WHERE username = ?', [username]);
        if (users.length > 0) {
            return res.status(400).json({ message: 'User with this username already exists.' });
        }

        // 2. Hash Password 
        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(password, salt);

        // 3. Insert New User into DB
        const [result] = await db.execute(
            'INSERT INTO user_data (username, password_hash, full_name, role) VALUES (?, ?, ?, ?)',
            [username, password_hash, full_name, role]
        );
        const userId = result.insertId;

        // 4. Respond with token and user data
        res.status(201).json({
            user_id: userId,
            username,
            role,
            message: 'User registered successfully.',
            token: generateToken(userId, role) // Generate token immediately upon registration
        });

    } catch (error) {
        console.error('Registration error:', error);
        // Use 400 for errors related to user input/database constraints, 500 for server issues
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
        // NOTE: If you are testing with your sample data which had dummy hashes, you MUST register a user 
        // via the /signup endpoint first to create a REAL bcrypt hash. bcrypt.compare will FAIL on dummy values 
        // or on the original plain text password.
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
