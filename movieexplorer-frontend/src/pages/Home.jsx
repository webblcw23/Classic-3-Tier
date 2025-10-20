import { Link } from 'react-router-dom';

function Home() {
    return (
        <div className="min-h-screen flex items-center justify-center bg-gray-100 px-4">
            <div className="text-center max-w-xl">
                <h1 className="text-4xl font-bold text-blue-600 mb-4">🎬 MovieExplorer</h1>
                <p className="text-lg text-gray-700 mb-6">
                    Explore a curated list of movies stored in Azure SQL — built with cloud-native architecture.
                </p>
                <Link to="/movies">
                    <button className="bg-blue-500 text-white px-6 py-2 rounded hover:bg-blue-600 transition">
                        See Movies
                    </button>
                </Link>
            </div>
        </div>
    );
}

export default Home;
