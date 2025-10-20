CREATE TABLE Movies (
  id INT PRIMARY KEY,
  title NVARCHAR(255),
  genre NVARCHAR(100),
  year INT,
  description TEXT
);

INSERT INTO Movies (id, title, genre, year, description) VALUES
(1, 'Inception', 'Sci-Fi', 2010, 'A thief who steals corporate secrets through dream-sharing technology.'),
(2, 'The Godfather', 'Crime', 1972, 'The aging patriarch of an organized crime dynasty transfers control to his reluctant son.'),
(3, 'Interstellar', 'Sci-Fi', 2014, 'A team of explorers travel through a wormhole in space in an attempt to ensure humanitys survival.'),
(4, 'Parasite', 'Thriller', 2019, 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy and the poor.'),
(5, 'The Dark Knight', 'Action', 2008, 'Batman faces the Joker, a criminal mastermind who plunges Gotham into chaos.');
(6, 'Pulp Fiction', 'Crime', 1994, 'The lives of two mob hitmen, a boxer, and others intertwine in a series of violent events.'),
(7, 'The Shawshank Redemption', 'Drama', 1994, 'Two imprisoned men bond over years, finding solace and eventual redemption through acts of decency.'),
(8, 'Fight Club', 'Drama', 1999, 'An insomniac office worker and a soap salesman form an underground fight club that evolves into chaos.'),
(9, 'Forrest Gump', 'Drama', 1994, 'The life journey of a slow-witted but kind-hearted man who witnesses and influences historical events.'),
(10, 'The Matrix', 'Sci-Fi', 1999, 'A computer hacker discovers reality is a simulation and joins a rebellion against its controllers.'),
(11, 'Gladiator', 'Action', 2000, 'A betrayed Roman general fights his way back to seek vengeance and restore honor.'),
(12, 'Titanic', 'Romance', 1997, 'A young couple from different social classes fall in love aboard the ill-fated RMS Titanic.'),
(13, 'The Silence of the Lambs', 'Thriller', 1991, 'A young FBI cadet seeks help from a cannibalistic killer to catch another serial murderer.'),
(14, 'Saving Private Ryan', 'War', 1998, 'During WWII, a group of soldiers are sent to rescue a paratrooper whose brothers have been killed.'),
(15, 'Whiplash', 'Drama', 2014, 'A young drummer faces psychological warfare from his ruthless music instructor in pursuit of greatness.');