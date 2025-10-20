import { useEffect, useState } from 'react';

function App() {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    fetch('http://localhost:5000/movies') // or your container port
      .then(res => res.json())
      .then(data => setMovies(data))
      .catch(err => console.error(err));
  }, []);

  return (
    <div style={{ padding: '2rem' }}>
      <h1>🎬 MovieExplorer</h1>
      {movies.map(movie => (
        <div key={movie.id} style={{ marginBottom: '1rem', border: '1px solid #ccc', padding: '1rem' }}>
          <h2>{movie.title}</h2>
          <p><strong>Genre:</strong> {movie.genre}</p>
          <p><strong>Year:</strong> {movie.releaseYear}</p>
          <p><strong>Rating:</strong> {movie.rating}</p>
        </div>
      ))}
    </div>
  );
}

export default App;
