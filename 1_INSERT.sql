-- Заполнение БД (Задание 1)

-- Жанры
INSERT INTO genre (genre_id, name) VALUES
  (1, 'Rock'),
  (2, 'Pop'),
  (3, 'Rap'),
  (4, 'Jazz');

-- Исполнители
INSERT INTO artist (artist_id, name) VALUES
  (1, 'Metallica'),
  (2, 'Adele'),
  (3, 'Eminem'),
  (4, 'Би-2'),
  (5, 'Zemfira'),
  (6, 'DuaLipa'),
  (7, 'Eagles');

-- Альбомы
INSERT INTO album (album_id, title, release_year) VALUES
  (1, 'Master of Puppets', 1986),
  (2, '25', 2015),
  (3, 'Kamikaze', 2018),
  (4, 'Горизонт событий', 2017),
  (5, 'Future Nostalgia', 2020),
  (6, 'Hotel California Live', 2019),
  (7, 'Pop & Rap Collab', 2020);

-- Треки
INSERT INTO track (track_id, title, duration_seconds, album_id) VALUES
  (1, 'Battery', 312, 1),
  (2, 'Master of Puppets', 515, 1),
  (3, 'Hello', 295, 2),
  (4, 'My Way', 240, 2),
  (5, 'Lucky You', 244, 3),
  (6, 'Venom', 269, 3),
  (7, 'Мой рок-н-ролл', 250, 4),
  (8, 'Short Intro', 120, 5),
  (9, 'Levitating', 203, 5),
  (10,'One of These Nights', 255, 6),
  (11,'Collab Track 1', 215, 7),
  (12,'Collab Track 2', 205, 7);

-- Сборники
INSERT INTO collection (collection_id, title, release_year) VALUES
  (1, 'Best of 2018', 2018),
  (2, 'Road Trip 2019', 2019),
  (3, 'Hits 2020', 2020),
  (4, 'New Year 2021', 2021);

-- Исполнители ↔ жанры
INSERT INTO artist_genre (artist_id, genre_id) VALUES
  (1, 1),  -- Metallica - Rock
  (2, 2),  -- Adele - Pop
  (3, 3),  -- Eminem - Rap
  (4, 1),  -- Би-2 - Rock
  (5, 1),  -- Zemfira - Rock
  (5, 2),  -- Zemfira - Pop (чтобы был >1 жанр)
  (6, 2),  -- DuaLipa - Pop
  (7, 1);  -- Eagles - Rock

-- Исполнители ↔ альбомы
INSERT INTO artist_album (artist_id, album_id) VALUES
  (1, 1),  -- Metallica -> Master of Puppets
  (2, 2),  -- Adele -> 25
  (3, 3),  -- Eminem -> Kamikaze
  (4, 4),  -- Би-2 -> Горизонт событий
  (6, 5),  -- DuaLipa -> Future Nostalgia (2020)
  (7, 6),  -- Eagles -> Hotel California Live (2019)
  (2, 7),  -- Collab album (2020): Adele
  (3, 7);  -- Collab album (2020): Eminem

-- Сборник ↔ трек
INSERT INTO collection_track (collection_id, track_id) VALUES
  (1, 5), (1, 6),
  (2, 2), (2, 7),
  (3, 3), (3, 4), (3, 11),
  (4, 1), (4, 10);