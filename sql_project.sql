-- spotify project
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);


--EDA
select count(*) from spotify;
--20594

select count(distinct(artist)) from spotify;
-- 2074 different artists
/* unique is a constraint
whereas distinct is a keyword */

select count(distinct(album)) from spotify;
--11854
select distinct(album_type) from spotify;
/* album
compilation
single*/


select max(duration_min) from spotify;--77.9343
select min(duration_min) from spotify;--0

select * from spotify
where duration_min = 0;-- 2 rows has 0 duration so delete them

delete from spotify
where duration_min = 0; -- deleted 2 rows

select count(*) from spotify; -- 20592
select min(duration_min) from spotify;--0.516...


select count(distinct(channel)) from spotify;--6673 diff channels are there

select distinct(most_played_on) from spotify;-- youtube and spotify


select max(views) from spotify; 
select title from spotify
where views =8079649362;-- Luis Fonsi-Despacito


-- -------------------------------------
-- Business Problems
-- -------------------------------------
--Retrieve the names of all tracks that have more than 1 billion streams.
SELECT track FROM SPOTIFY
WHERE STREAM >1000000000; -- 385 such tracks

--List all albums along with their respective artists.
SELECT distinct album , ARTIST FROM SPOTIFY
order by 1; --14178 unique

--Get the total number of comments for tracks where licensed = TRUE.
SELECT sum(COMMENTS) as total_comments
FROM SPOTIFY
WHERE LICENSED = TRUE;--497015695 such comments

--Find all tracks that belong to the album type single.
SELECT TRACK FROM SPOTIFY WHERE ALBUM_TYPE = 'single';-- there are 4973 such tracks

-- Count the total number of tracks by each artist.
select artist,count(track) from spotify 
group by artist
order by 2 ;



--Calculate the average danceability of tracks in each album.
select album ,avg(danceability) from spotify
group by album
order by 2 desc;

--Find the top 5 tracks with the highest energy values.
select track, avg(energy) from spotify 
group by 1
order by 2 desc
limit 5;

--List all tracks along with their views and likes where official_video = TRUE.
select track, sum(views) as total_views, sum(likes) as total_likes from spotify
where official_video = 'true'
group by 1
order by 2 desc;-- there are 15634 such tracks with true value


--For each album, calculate the total views of all associated tracks.
select album , tr sum(views)from spotify 
group by album;

--Retrieve the track names that have been streamed on Spotify more than YouTube.
select track from spotify 
where most_played_on = 'Spotify';--there are 15692 tracks which are streamed more on spotify


--Find the top 3 most-viewed tracks for each artist using window functions.
with func
as
(
select artist , track , sum(views) as total_views,
dense_rank() over(partition by artist order by sum(views) desc) as rank
from spotify
group by 1,2
order by 1,3 desc
)
select * from func 
where rank <= 3

--Write a query to find tracks where the liveness score is above the average.
select artist, track , liveness from spotify
where liveness > (select avg(liveness) from spotify);

--Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
with cte
as ( 
select album,
max(energy) as max_energy,
min(energy) as min_energy
from spotify 
group by 1
) select album, max_energy - min_energy as energy_diff from cte
order by 2 desc;

--Find tracks where the energy-to-liveness ratio is greater than 1.2.
select artist, track from spotify
where energy_liveness > 1.2

--Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
select artist, track, views, likes,
sum(likes) over(partition by artist order by views desc) as cumulative_likes
from spotify;






-- query optimization
-- without index
explain analyse --et= 5.113ms pt=0.216ms
select  artist,track,views from spotify
where artist = 'Gorillaz'
order by 3 desc;





-- with index

create index artist_index on spotify(artist);

explain analyse --et= 0.127ms pt=0.189ms
select  artist,track,views from spotify
where artist = 'Gorillaz'
order by 3 desc;

