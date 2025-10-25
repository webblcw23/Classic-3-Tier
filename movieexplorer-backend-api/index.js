const express = require('express');
const cors = require('cors');
const sql = require('mssql');

const app = express();
const port = process.env.PORT || 5050;

app.use(cors());
app.use(express.json());

// SQL config
const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_NAME,
    options: {
        encrypt: true,
        enableArithAbort: true,
    },
};

// Movies route — fetch from Azure SQL
app.get('/movies', async (req, res) => {
    try {
        const pool = await sql.connect(config);
        const result = await pool.request().query('SELECT * FROM Movies');
        res.json(result.recordset);
    } catch (err) {
        console.error('Database error:', err);
        res.status(500).send('Database error');
    }
});

// Health check
app.get('/ping', (req, res) => {
    res.send('pong');
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
