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
