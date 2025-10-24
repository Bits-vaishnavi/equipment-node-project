// middleware/auth.js
const jwt = require('jsonwebtoken');

// Helper function to generate JWT (used in auth.js)
const generateToken = (id, role) => {
    return jwt.sign({ id, role }, process.env.JWT_SECRET, {
        expiresIn: '30d', // Token expires in 30 days
    });
};

// Middleware to protect routes (checks if user is logged in)
const protect = (req, res, next) => {
    let token;

    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
        try {
            // Get token from header (Format: "Bearer TOKEN")
            token = req.headers.authorization.split(' ')[1];

            // Verify token
            const decoded = jwt.verify(token, process.env.JWT_SECRET);

            // Attach user info (id and role) to the request object for later use
            req.user = { id: decoded.id, role: decoded.role };

            next();
        } catch (error) {
            console.error(error);
            // 401: Unauthorized
            res.status(401).json({ message: 'Not authorized, token failed or expired' });
        }
    }

    if (!token) {
        // 401: Unauthorized
        res.status(401).json({ message: 'Not authorized, no token provided' });
    }
};

// Middleware for Role-Based Access Control (RBAC)
const authorize = (roles = []) => {
    // Convert single role string to array if necessary
    if (typeof roles === 'string') {
        roles = [roles];
    }

    return (req, res, next) => {
        if (!req.user || !roles.includes(req.user.role)) {
            // 403: Forbidden
            return res.status(403).json({ message: 'Forbidden: Access denied for this role' });
        }
        next();
    };
};

module.exports = { protect, authorize, generateToken }; // Export generateToken for use in routes/auth.js