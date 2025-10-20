using Microsoft.AspNetCore.Mvc;
using MovieExplorer.API.Models;

namespace MovieExplorer.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MoviesController : ControllerBase
    {
        private static readonly List<Movie> Movies = new()
        {
            new Movie { Id = 1, Title = "Inception", Genre = "Sci-Fi", ReleaseYear = 2010, Rating = 8.8 },
            new Movie { Id = 2, Title = "The Dark Knight", Genre = "Action", ReleaseYear = 2008, Rating = 9.0 },
            new Movie { Id = 3, Title = "Interstellar", Genre = "Sci-Fi", ReleaseYear = 2014, Rating = 8.6 }
        };

        [HttpGet("ping")]
        public IActionResult Ping() => Ok("pong");

        [HttpGet]
        public IActionResult GetAll() => Ok(Movies);

        [HttpPost("rate")]
        public IActionResult RateMovie([FromBody] Movie updated)
        {
            var movie = Movies.FirstOrDefault(m => m.Id == updated.Id);
            if (movie == null) return NotFound();
            movie.Rating = updated.Rating;
            return Ok(movie);
        }

        [HttpGet("top")]
        public IActionResult GetTopRated() =>
            Ok(Movies.OrderByDescending(m => m.Rating).Take(2));
    }
}
