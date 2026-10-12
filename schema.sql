CREATE TABLE IF NOT EXISTS patrons (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name  TEXT NOT NULL,
    full_name  TEXT GENERATED ALWAYS AS (first_name || ' ' || last_name) VIRTUAL,
    can_checkout INTEGER NOT NULL DEFAULT 1,
    can_place_holds INTEGER NO NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS books
(
    id      INTEGER PRIMARY KEY,
    title   TEXT    NOT NULL,
    barcode TEXT    NOT NULL UNIQUE,
    authors TEXT,
    series  INTEGER REFERENCES series (id) ON DELETE SET NULL -- Deleting the series just sets the book's series to null.
);

CREATE TABLE IF NOT EXISTS series
(
    id  INTEGER PRIMARY KEY,
    title   TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS holds
(
    placed_at  TEXT DEFAULT CURRENT_TIMESTAMP             NOT NULL,
    expires_at TEXT DEFAULT (datetime('now', '+14 days')) NOT NULL,                                           -- default expiration date 2 weeks from now
    book_id    INTEGER                                    NOT NULL REFERENCES books (id) ON DELETE CASCADE,   -- If the book is deleted, clear the hold
    patron_id  INTEGER                                    NOT NULL REFERENCES patrons (id) ON DELETE CASCADE, -- If the patron is deleted, clear the hold
    id         INTEGER PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS checkouts
(
    placed_at   TEXT DEFAULT CURRENT_TIMESTAMP             NOT NULL,
    expires_at  TEXT DEFAULT (datetime('now', '+45 days')) NOT NULL,                                          -- default expiration date 45 days from now
    returned_at TEXT,
    id          INTEGER PRIMARY KEY,
    book_id     INTEGER                                    NOT NULL REFERENCES books (id) ON DELETE CASCADE,  -- Delete the checkout if there is no book tied to it
    patron_id   INTEGER                                    NOT NULL REFERENCES patrons (id) ON DELETE CASCADE -- Delete the checkout if there is no patron tied to it
);
