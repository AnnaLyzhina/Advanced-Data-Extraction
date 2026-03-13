-- Задание 1

-- Справочник жанров
CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Исполнители
CREATE TABLE artist (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Альбомы
CREATE TABLE album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year BETWEEN 1900 AND 2100)
);

-- Треки (каждый трек строго в одном альбоме)
CREATE TABLE track (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration_seconds INTEGER NOT NULL CHECK (duration_seconds > 0),
    album_id INTEGER NOT NULL REFERENCES album(album_id) ON DELETE CASCADE
);

-- Сборники
CREATE TABLE collection (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year BETWEEN 1900 AND 2100)
);

-- Связь исполнители ↔ жанры (M:N)
CREATE TABLE artist_genre (
    artist_id INTEGER NOT NULL REFERENCES artist(artist_id) ON DELETE CASCADE,
    genre_id  INTEGER NOT NULL REFERENCES genre(genre_id)  ON DELETE CASCADE,
    PRIMARY KEY (artist_id, genre_id)
);

-- Связь исполнители ↔ альбомы (M:N)
CREATE TABLE artist_album (
    artist_id INTEGER NOT NULL REFERENCES artist(artist_id) ON DELETE CASCADE,
    album_id  INTEGER NOT NULL REFERENCES album(album_id)  ON DELETE CASCADE,
    PRIMARY KEY (artist_id, album_id)
);

-- Связь сборники ↔ треки (M:N)
CREATE TABLE collection_track (
    collection_id INTEGER NOT NULL REFERENCES collection(collection_id) ON DELETE CASCADE,
    track_id      INTEGER NOT NULL REFERENCES track(track_id)          ON DELETE CASCADE,
    PRIMARY KEY (collection_id, track_id)
);
