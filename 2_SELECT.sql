-- SELECT-запросы (Задания 2, 3, 4)

-- 2.1 Название и продолжительность самого длительного трека
SELECT title, duration_seconds
FROM track
WHERE duration_seconds = (SELECT MAX(duration_seconds) FROM track);

-- 2.2 Название треков, продолжительность которых не менее 3,5 минут (210 сек)
SELECT title, duration_seconds
FROM track
WHERE duration_seconds >= 210
ORDER BY duration_seconds DESC;

-- 2.3 Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title, release_year
FROM collection
WHERE release_year BETWEEN 2018 AND 2020
ORDER BY release_year, title;

-- 2.4 Исполнители, чьё имя состоит из одного слова
SELECT name
FROM artist
WHERE name NOT LIKE '% %'
ORDER BY name;

-- 2.5 Название треков, которые содержат слово «мой» или «my» (регистр не важен)
SELECT title
FROM track
WHERE title ILIKE '%мой%'
   OR title ILIKE '%my%'
ORDER BY title;

-- ======================
-- Задание 3
-- ======================

-- 3.1 Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(ag.artist_id) AS artist_count
FROM genre g
LEFT JOIN artist_genre ag ON ag.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY artist_count DESC, g.name;

-- 3.2 Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.track_id) AS tracks_2019_2020
FROM track t
JOIN album a ON a.album_id = t.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3.3 Средняя продолжительность треков по каждому альбому
SELECT a.title AS album, ROUND(AVG(t.duration_seconds)) AS avg_duration_seconds
FROM album a
JOIN track t ON t.album_id = a.album_id
GROUP BY a.album_id, a.title
ORDER BY avg_duration_seconds DESC, a.title;

-- 3.4 Все исполнители, которые не выпустили альбомы в 2020 году
SELECT ar.name
FROM artist ar
WHERE ar.artist_id NOT IN (
    SELECT aa.artist_id
    FROM artist_album aa
    JOIN album a ON a.album_id = aa.album_id
    WHERE a.release_year = 2020
)
ORDER BY ar.name;

-- 3.5 Названия сборников, в которых присутствует конкретный исполнитель (выберем Eminem)
SELECT DISTINCT c.title AS collection
FROM collection c
JOIN collection_track ct ON ct.collection_id = c.collection_id
JOIN track t ON t.track_id = ct.track_id
JOIN album a ON a.album_id = t.album_id
JOIN artist_album aa ON aa.album_id = a.album_id
JOIN artist ar ON ar.artist_id = aa.artist_id
WHERE ar.name = 'Eminem'
ORDER BY c.title;

-- ======================
-- Задание 4
-- ======================

-- 4.1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT a.title AS album
FROM album a
JOIN artist_album aa ON aa.album_id = a.album_id
JOIN artist_genre ag ON ag.artist_id = aa.artist_id
GROUP BY a.album_id, a.title
HAVING COUNT(DISTINCT ag.genre_id) > 1
ORDER BY a.title;

-- 4.2 Наименования треков, которые не входят в сборники
SELECT t.title
FROM track t
LEFT JOIN collection_track ct ON ct.track_id = t.track_id
WHERE ct.track_id IS NULL
ORDER BY t.title;

-- 4.3 Исполнитель(и), написавшие самый короткий по продолжительности трек
SELECT DISTINCT ar.name AS artist, t.title AS track, t.duration_seconds
FROM track t
JOIN album a ON a.album_id = t.album_id
JOIN artist_album aa ON aa.album_id = a.album_id
JOIN artist ar ON ar.artist_id = aa.artist_id
WHERE t.duration_seconds = (SELECT MIN(duration_seconds) FROM track)
ORDER BY ar.name, t.title;

-- 4.4 Названия альбомов, содержащих наименьшее количество треков
WITH album_track_counts AS (
  SELECT a.album_id, a.title, COUNT(t.track_id) AS track_count
  FROM album a
  LEFT JOIN track t ON t.album_id = a.album_id
  GROUP BY a.album_id, a.title
),
min_count AS (
  SELECT MIN(track_count) AS m
  FROM album_track_counts
)
SELECT atc.title AS album, atc.track_count
FROM album_track_counts atc
JOIN min_count mc ON mc.m = atc.track_count
ORDER BY atc.title;
