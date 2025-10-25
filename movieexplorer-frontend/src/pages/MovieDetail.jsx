
import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';


function MovieDetail() {
    const { id } = useParams();
    const [movie, setMovie] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        fetch(`${import.meta.env.VITE_API_URL}/movies/${id}`)
            .then(res => res.json())
            .then(data => setMovie(data))
            .catch(err => console.error('Error fetching movie:', err));
    }, [id]);

    if (!movie) return <p>Loading...</p>;

    return (
        <div className="max-w-xl mx-auto p-6 bg-white rounded shadow">
            <h1 className="text-2xl font-bold mb-4">{movie.title}</h1>
            <p><strong>Genre:</strong> {movie.genre}</p>
            <p><strong>Year:</strong> {movie.year}</p>
            <p><strong>Rating:</strong> {movie.rating}</p>
            <p className="mt-4"><strong>Description:</strong> {movie.description}</p>

            <button
                onClick={() => navigate('/')}
                className="mt-6 px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded"
            >
                ← Back to Movie List
            </button>
        </div>
    );
}
export default MovieDetail;