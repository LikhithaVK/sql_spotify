
🎵 Spotify SQL Project

This project demonstrates SQL-based data exploration, analysis, and optimization on a dataset containing Spotify and YouTube music statistics. The goal is to perform exploratory data analysis (EDA), answer business-related queries, and showcase query optimization techniques.

📂 Project Structure

sql_project.sql → Main SQL script containing:

Table creation

Data cleaning queries

Exploratory Data Analysis (EDA)

Business problem-solving queries

Query optimization (with and without indexes)

#🔎 Exploratory Data Analysis (EDA)

Some example EDA queries include:

Counting total tracks, artists, and albums

Checking track durations and removing invalid values

Identifying most viewed songs and popular platforms

Exploring distinct album types and channels

#💡 Business Problem Queries

The project answers multiple business-driven queries, such as:

Tracks with more than 1B streams

Albums with respective artists

Total comments for licensed tracks

Top 5 tracks with highest energy values

Average danceability per album

Most-viewed tracks per artist (using window functions)

Tracks streamed more on Spotify vs YouTube

Energy-to-liveness ratio analysis

#⚡ Query Optimization

To demonstrate performance improvements, queries are compared:

Without Index: Slower execution

With Index (artist_index): Optimized execution

Example:

-- Without index
SELECT artist, track, views 
FROM spotify
WHERE artist = 'Gorillaz'
ORDER BY views DESC;

-- With index
CREATE INDEX artist_index ON spotify(artist);

🚀# How to Use

Import the sql_project.sql file into your SQL environment (PostgreSQL/MySQL).

Execute the table creation script to set up the schema.

Load the dataset (not included in this repo, placeholder table created).

Run EDA queries to explore the dataset.

Test business problem queries for insights.

Compare query performance with and without indexes.

📊# Key Insights

Dataset contains 20,592 tracks after cleaning.

2,074 unique artists and 11,854 albums.

Luis Fonsi’s Despacito is the most viewed track.

Over 385 tracks have 1B+ streams.

Spotify dominates streaming for 15,692 tracks.

🛠️ #Technologies Used

SQL (PostgreSQL)

Window Functions

Indexing for Optimization
