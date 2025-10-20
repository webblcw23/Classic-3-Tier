const sql = require('mssql');

const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER, // e.g., 'your-server.database.windows.net'
    database: process.env.DB_NAME,
    options: {
        encrypt: true, // for Azure
        enableArithAbort: true
    }
};

const pool = new sql.ConnectionPool(config);
const poolConnect = pool.connect();

const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 5050;

app.use(cors());
app.use(express.json());

const movies = [
    { id: 1, title: 'Inception', genre: 'Sci-Fi', releaseYear: 2010, rating: 'PG-13' },
    { id: 2, title: 'The Godfather', genre: 'Crime', releaseYear: 1972, rating: 'R' },
    { id: 3, title: 'Interstellar', genre: 'Sci-Fi', releaseYear: 2014, rating: 'PG-13' },
];

app.get('/ping', (req, res) => {
    res.send('pong');
});

app.get('/movies', (req, res) => {
    res.json(movies);
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);

});
