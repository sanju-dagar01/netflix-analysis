CREATE DATABASE MovieLensDB;

USE MovieLensDB;

# Total records 
SELECT COUNT(*) AS Total_Records
FROM movie_ratings;

# Total Users
SELECT COUNT(DISTINCT userId) AS Total_Users
FROM movie_ratings;

# Total movies
SELECT COUNT(DISTINCT title) AS Total_Movies
FROM movie_ratings;
 
 # Average rating
 SELECT AVG(rating) AS Average_Rating
FROM movie_ratings;

# Top 10 Most Rated Movies
SELECT
    title,
    COUNT(rating) AS Total_Ratings
FROM movie_ratings
GROUP BY title
ORDER BY Total_Ratings DESC
LIMIT 10;

# Top 10 Active Users
SELECT
    userId,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY userId
ORDER BY Total_Ratings DESC
LIMIT 10;

# Average rating of each movie
SELECT
    title,
    ROUND(AVG(rating),2) AS Average_Rating
FROM movie_ratings
GROUP BY title
ORDER BY Average_Rating DESC;

# Movies Having More Than 100 Ratings
SELECT
    title,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY title
HAVING COUNT(*) > 100
ORDER BY Total_Ratings DESC;

# Top 10 Highest Rated Movies (Minimum 50 Ratings)
SELECT
    title,
    ROUND(AVG(rating),2) AS Average_Rating,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY title
HAVING COUNT(*) >= 50
ORDER BY Average_Rating DESC
LIMIT 10;

# Numbers of movies in each Genres
SELECT
    genres,
    COUNT(*) AS Total_Movies
FROM movie_ratings
GROUP BY genres
ORDER BY Total_Movies DESC
LIMIT 10;

# Top 5 Users by Average Rating Given
SELECT
    userId,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY userId
ORDER BY Avg_Rating DESC
LIMIT 5;

# Total rating by genre
SELECT
    genres,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY genres
ORDER BY Total_Ratings DESC
LIMIT 10;

# Movies Rated 5 Stars Most Frequently
SELECT
    title,
    COUNT(*) AS Five_Star_Ratings
FROM movie_ratings
WHERE rating = 5
GROUP BY title
ORDER BY Five_Star_Ratings DESC
LIMIT 10;

# Number of Movies Rated by Each User
SELECT
    userId,
    COUNT(DISTINCT movieId) AS Movies_Watched
FROM movie_ratings
GROUP BY userId
ORDER BY Movies_Watched DESC
LIMIT 10;

# Users Who Rated More Than 200 Movies
SELECT
    userId,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY userId
HAVING COUNT(*) > 200
ORDER BY Total_Ratings DESC;

# Highest rated genre
SELECT
    genres,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY genres
ORDER BY Avg_Rating DESC
LIMIT 10;

# Movies with Lowest average rating
SELECT
    title,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY title
HAVING COUNT(*) >= 20
ORDER BY Avg_Rating ASC
LIMIT 10;

# Rating Distribution
SELECT
    rating,
    COUNT(*) AS Total
FROM movie_ratings
GROUP BY rating
ORDER BY rating;

# Total movies released Dataset
SELECT
    COUNT(DISTINCT movieId) AS Total_Movies
FROM movie_ratings;

# Most Popular movie Genre
SELECT
    genres,
    COUNT(*) AS Total
FROM movie_ratings
GROUP BY genres
ORDER BY Total DESC
LIMIT 1;

# Rank Movies by Average Rating (Window Function)
SELECT
    title,
    ROUND(AVG(rating),2) AS Avg_Rating,
    RANK() OVER(ORDER BY AVG(rating) DESC) AS Movie_Rank
FROM movie_ratings
GROUP BY title;

# Dense rank
SELECT
    title,
    ROUND(AVG(rating),2) AS Avg_Rating,
    DENSE_RANK() OVER(ORDER BY AVG(rating) DESC) AS Dense_Rank
FROM movie_ratings
GROUP BY title;

# Row Number
SELECT
    title,
    AVG(rating) AS Avg_Rating,
    ROW_NUMBER() OVER(ORDER BY AVG(rating) DESC) AS Row_Num
FROM movie_ratings
GROUP BY title;

# Top rated movie in each genre
SELECT
    genres,
    title,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY genres, title
ORDER BY genres, Avg_Rating DESC;

# Movies Above Overall Average Rating (Subquery)
SELECT
    title,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY title
HAVING AVG(rating) >
(SELECT AVG(rating)
    FROM movie_ratings);

# Users Who Rated More Than Average Number of Movies
SELECT
    userId,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY userId
HAVING COUNT(*) >
(SELECT AVG(Total_Count)
    FROM
    (SELECT COUNT(*) AS Total_Count
        FROM movie_ratings
        GROUP BY userId) t);

# Genre-wise Average rating
SELECT
    genres,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY genres
ORDER BY Avg_Rating DESC;

# Rating Category 
SELECT
    title,
    rating,
    CASE
        WHEN rating >= 4.5 THEN 'Excellent'
        WHEN rating >= 3.5 THEN 'Good'
        WHEN rating >= 2.5 THEN 'Average'
        ELSE 'Poor'
    END AS Rating_Category
FROM movie_ratings;

# Average Rating by year
SELECT
    YEAR(timestamp) AS Rating_Year,
    ROUND(AVG(rating),2) AS Avg_Rating
FROM movie_ratings
GROUP BY YEAR(timestamp)
ORDER BY Rating_Year;

# Top 10 Movies with Highest Average Rating (Minimum 50 Ratings)
SELECT
    title,
    ROUND(AVG(rating),2) AS Avg_Rating,
    COUNT(*) AS Total_Ratings
FROM movie_ratings
GROUP BY title
HAVING COUNT(*) >= 50
ORDER BY Avg_Rating DESC
LIMIT 10;
