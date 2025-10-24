// server.js
console.log('Running from:', __filename);
require('dotenv').config({ path: './.env' }); // Load .env file
const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3001;


const db = require('./config/db');
// Middleware
app.use(cors()); // Allow React on a different port (e.g., 3000)
app.use(express.json()); // Parses incoming JSON requests

// Basic Test Route
app.get('/', (req, res) => {
    res.send('Equipment Lending Portal API is running!');
});

// Health Check Route for Database Connection
// app.get('/api/health/db', async (req, res) => {
//     try {
//         // Use a simple query that requires the connection to work
//         // SELECT 1 + 1 is a common simple test query
//         await db.execute('SELECT 1 + 1 AS solution');
        
//         res.status(200).json({
//             status: 'ok',
//             database: 'connected',
//             message: 'Successfully connected to MySQL database.'
//         });
//     } catch (error) {
//         console.error('Database connection error:', error.message);
//         res.status(500).json({
//             status: 'error',
//             database: 'disconnected',
//             message: 'Failed to connect to MySQL database. Check DB credentials in .env file.',
//             error: error.message
//         });
//     }
// });

// Routes
const authRoutes = require('./routes/auth');
//const equipmentRoutes = require('./routes/equipment');
//const requestRoutes = require('./routes/requests');

app.use('/api/auth', authRoutes);
//app.use('/api/equipment', equipmentRoutes);
//app.use('/api/requests', requestRoutes);

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});

