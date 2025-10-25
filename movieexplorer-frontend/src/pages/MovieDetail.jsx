import { Link, useParams } from 'react-router-dom';
import { useEffect, useState } from 'react';

function MovieDetail() {
    const { id } = useParams();
    const [movie, setMovie] = useState(null);

    useEffect(() => {
        fetch(`${import.meta.env.VITE_API_URL}/movies/${id}`)
            .then(res => res.json())
            .then(data => setMovie(data))
            .catch(err => console.error(err));
    }, [id]);

    return (
        <div className="min-h-screen bg-gray-100 px-4 py-8">
            <div className="max-w-4xl mx-auto">
                <Link to="/movies">
                    <button className="mb-6 bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded transition">
                        ← Back to Movies
                    </button>
                </Link>

                {movie ? (
                    <div className="bg-white p-6 rounded shadow">
                        <h1 className="text-3xl font-bold mb-4">{movie.title}</h1>
                        <p className="text-gray-700 mb-2">Genre: {movie.genre}</p>
                        <p className="text-gray-700 mb-2">Year: {movie.year}</p>
                        <p className="text-gray-700">{movie.description}</p>
                    </div>
                ) : (
                    <p>Loading...</p>
                )}
            </div>
        </div>
    );
}

export default MovieDetail;
