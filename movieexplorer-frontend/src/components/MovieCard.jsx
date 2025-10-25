import { Link } from 'react-router-dom';

function MovieCard({ movie }) {
    console.log('MovieCard props:', movie);
    return (
        <Link to={`/movies/${movie.id}`}>
            <div className="bg-white rounded-lg shadow-md hover:shadow-lg p-6 transition duration-200 mx-auto w-full max-w-sm border border-gray-300 hover:border-gray-500">
                <h2 className="text-xl font-bold mb-2 text-center">{movie.title}</h2>
                <p className="mb-1 text-center"><strong>Genre:</strong> {movie.genre}</p>
                <p className="mb-1 text-center"><strong>Year Released:</strong> {movie.year}</p>
                <p className="text-center"><strong>Rating:</strong> {movie.rating}</p>
            </div>
        </Link>
    );
}

export default MovieCard;
