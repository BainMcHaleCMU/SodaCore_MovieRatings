CREATE TABLE ratings (
    id serial PRIMARY KEY,
    user_id VARCHAR(50)  NOT NULL,
    movie_id VARCHAR(100) NOT NULL,
    rating INT  NOT NULL,
    rating_time VARCHAR(50) NOT NULL,
    CONSTRAINT unique_rating_info UNIQUE (user_id, rating_time)
);
