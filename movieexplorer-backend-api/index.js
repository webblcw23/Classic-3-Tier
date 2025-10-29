const express = require('express');
const cors = require('cors');
const sql = require('mssql');

const app = express();
const port = process.env.PORT || 80;


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
        const result = await pool.request().query(`
  SELECT id, title, genre, year, rating
  FROM Movies
`);

        res.json(result.recordset);
    } catch (err) {
        console.error('Database error:', err);
        res.status(500).send('Database error');
    }
});

app.get('/movies/:id', async (req, res) => {
    try {
        const pool = await sql.connect(config);
        const result = await pool
            .request()
            .input('id', sql.Int, req.params.id)
            .query('SELECT id, title, genre, year, rating, description FROM Movies WHERE id = @id');

        if (result.recordset.length === 0) {
            return res.status(404).send('Movie not found');
        }

        res.json(result.recordset[0]);
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