import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import MovieCard from '../components/MovieCard';

function Movies() {
    const [movies, setMovies] = useState([]);
    const [search, setSearch] = useState('');

    useEffect(() => {
        fetch('http://localhost:5050/movies')
            .then(res => res.json())
            .then(data => setMovies(data))
            .catch(err => console.error(err));
    }, []);

    const filtered = movies.filter(movie =>
        movie.title.toLowerCase().includes(search.toLowerCase())
    );

    return (
        <div className="min-h-screen bg-gray-100 px-4 py-8">
            <div className="max-w-6xl mx-auto">
                {/* Back Button */}
                <Link to="/">
                    <button className="mb-4 bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded transition">
                        ← Back to Main Menu
                    </button>
                </Link>

                {/* Page Title */}
                <h1 className="text-3xl font-bold mb-6 text-center">All Movies</h1>

                {/* Search Input */}
                <input
                    type="text"
                    placeholder="Search by title..."
                    value={search}
                    onChange={e => setSearch(e.target.value)}
                    className="border border-gray-300 rounded px-4 py-2 mb-6 w-full max-w-md mx-auto block"
                />

                {/* Movie Grid */}
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                    {filtered.map(movie => (
                        <MovieCard key={movie.id} movie={movie} />
                    ))}
                </div>
            </div>
        </div>
    );

}

export default Movies;
