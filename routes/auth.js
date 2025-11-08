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
    // Modified to include role selection and staff email
    const { 
        username, 
        password, 
        full_name, 
        prn_number, 
        email,
        user_type // 'student' or 'staff'
    } = req.body; 

    // Basic validation
    if (!username || !password || !full_name || !user_type) {
        return res.status(400).json({ 
            message: 'Please enter all required fields: username, password, full name, and user type.' 
        });
    }

    // Additional validation based on user type
    if (user_type === 'student' && !prn_number) {
        return res.status(400).json({ 
            message: 'PRN number is required for student registration.' 
        });
    }

    if (user_type === 'staff' && !email) {
        return res.status(400).json({ 
            message: 'Email is required for staff registration.' 
        });
    }

    try {
        // Validation based on user type
        if (user_type === 'student') {
            // Student validation
            const [registered] = await db.execute(
                'SELECT prn_number FROM RegisteredStudents WHERE prn_number = ?',
                [prn_number]
            );

            if (registered.length === 0) {
                return res.status(401).json({ 
                    message: 'Invalid PRN Number. Registration is restricted to verified students.' 
                });
            }

            // Check if PRN is already claimed
            const [existingUserByPrn] = await db.execute(
                'SELECT user_id FROM user_data WHERE prn_number = ?',
                [prn_number]
            );

            if (existingUserByPrn.length > 0) {
                return res.status(409).json({ 
                    message: 'This PRN number has already been registered.' 
                });
            }
        } else if (user_type === 'staff') {
            // Staff validation
            const [registered] = await db.execute(
                'SELECT email FROM registeredstaff WHERE email = ?',
                [email]
            );

            if (registered.length === 0) {
                return res.status(401).json({ 
                    message: 'Invalid email. Registration is restricted to verified staff members.' 
                });
            }

            // Check if email is already claimed
            const [existingUserByEmail] = await db.execute(
                'SELECT user_id FROM user_data WHERE email = ?',
                [email]
            );

            if (existingUserByEmail.length > 0) {
                return res.status(409).json({ 
                    message: 'This email has already been registered.' 
                });
            }
        }

        // Check for existing username
        const [users] = await db.execute(
            'SELECT user_id FROM user_data WHERE username = ?', 
            [username]
        );
        
        if (users.length > 0) {
            return res.status(400).json({ 
                message: 'Username already exists.' 
            });
        }

        // Hash Password
        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(password, salt);

        // Insert new user with conditional fields
        let query, params;
        if (user_type === 'student') {
            query = 'INSERT INTO user_data (username, password_hash, full_name, role, prn_number) VALUES (?, ?, ?, ?, ?)';
            params = [username, password_hash, full_name, 'student', prn_number];
        } else {
            query = 'INSERT INTO user_data (username, password_hash, full_name, role, email) VALUES (?, ?, ?, ?, ?)';
            params = [username, password_hash, full_name, 'staff', email];
        }

        const [result] = await db.execute(query, params);
        const userId = result.insertId;

        // Response
        res.status(201).json({
            user_id: userId,
            username,
            role: user_type,
            message: `User registered successfully as ${user_type}.`,
            token: generateToken(userId, user_type)
        });

    } catch (error) {
        console.error('Registration error:', error);
        res.status(500).json({ 
            message: 'Server error during registration.' 
        });
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
