CREATE TABLE films (
	id 			INT 	PRIMARY KEY 	NOT NULL,
	name 		VARCHAR(100),
	descripton 	VARCHAR(200)
);

CREATE TABLE reviews (
	review_id 		INT 	PRIMARY KEY 	NOT NULL,
	film_id 		INT,
	rating 			NUMERIC,
	CONSTRAINT fk_film
		FOREIGN KEY(film_id)
			REFERENCES films(id)
);

INSERT INTO films
	VALUES
		(1, 'The Shawshank Redemption', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'),
		(2, 'The Godfather', 'The Godfather follows Vito Corleone, Don of the Corleone family, as he passes the mantel to his unwilling son, Michael.'),
		(3, 'The Dark Knight', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.'),
		(4, 'The Lord of the Rings: The Return of the King', 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.'),
		(5, 'Fight Club', 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into much more.');

INSERT INTO reviews
	VALUES
		(1, 1, 9.5),
		(2, 5, 8),
		(3, 4, 9),
		(4, 2, 6),
		(5, 3, 7),
		(6, 3, 9),
		(7, 2, 8.5),
		(8, 1, 7.5),
		(9, 4, 7),
		(10, 5, 8),
		(11, 4, 9);