CREATE TABLE IF NOT EXISTS "patrons" (
	"id" INTEGER,
	"first_name" TEXT NOT NULL,
	"last_name" TEXT NOT NULL,
	"full_name" TEXT,
	"can_checkout" INTEGER NOT NULL DEFAULT 1,
	"can_place_holds" INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "books" (
	"id" INTEGER,
	"title" TEXT NOT NULL,
	"barcode" TEXT NOT NULL UNIQUE,
	"authors" TEXT,
	"series" INTEGER,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "series" (
	"id" INTEGER,
	"title" TEXT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "holds" (
	"placed_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"expires_at" TEXT NOT NULL DEFAULT datetime('now', '+14 days'),
	"book_id" INTEGER NOT NULL,
	"patron_id" INTEGER NOT NULL,
	"id" INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY ("book_id") REFERENCES "books"("id")
	ON UPDATE NO ACTION ON DELETE CASCADE,
	FOREIGN KEY ("patron_id") REFERENCES "patrons"("id")
	ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "checkouts" (
	"placed_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"expires_at" TEXT NOT NULL DEFAULT datetime('now', '+45 days'),
	"returned_at" TEXT,
	"id" INTEGER,
	"book_id" INTEGER NOT NULL,
	"patron_id" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("book_id") REFERENCES "books"("id")
	ON UPDATE NO ACTION ON DELETE CASCADE,
	FOREIGN KEY ("patron_id") REFERENCES "patrons"("id")
	ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "collections" (
	"id" INTEGER NOT NULL UNIQUE,
	"name" TEXT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "books_collections" (
	"book" INTEGER,
	"collection" INTEGER,
	PRIMARY KEY("book", "collection"),
	FOREIGN KEY ("book") REFERENCES "books"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("collection") REFERENCES "collections"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "tags" (
	"id" INTEGER NOT NULL,
	"name" TEXT,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "tags_books" (
	"tag" INTEGER,
	"book" INTEGER,
	PRIMARY KEY("tag", "book"),
	FOREIGN KEY ("tag") REFERENCES "tags"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("book") REFERENCES "books"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "book_series" (
	"book" INTEGER NOT NULL,
	"series" INTEGER NOT NULL,
	-- Series number on join record incase book has a different series number in each series
	"series_number" INTEGER,
	PRIMARY KEY("book", "series"),
	FOREIGN KEY ("book") REFERENCES "books"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("series") REFERENCES "series"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);
