-- FIRST: The tables that will form the database GreenGive.db

--Represent users that are growing produce
CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "user_name" TEXT NOT NULL UNIQUE, 
    "bio" TEXT,
    PRIMARY KEY("id")
);

-- Represents the produce grown which may be added to a listing
CREATE TABLE "produce"(
    "id" INTEGER,
    "type" TEXT UNIQUE,
    PRIMARY KEY("id")
);

-- Represents the inputs used when growing the produce
CREATE TABLE "inputs"(
    "id" INTEGER, 
    "type" TEXT DEFAULT `none` 
            CHECK("type" 
                IN(`none`,
                    `Synthetic mineral fertilisers`,
                    `Organic mineral fertilisers`,
                    `Organic soil conditioner`,
                    `Synthetic soil conditioner`,
                    `Organic rooting aid`,
                    `Synthetic rooting aid`,
                    `Organic herbicide fungicide pesticide insecticide`,
                    `Synthetic herbicide fungicide pesticide insecticide`,
                    `Compost`
                    )
                ),
    PRIMARY KEY ("id")
);

-- Represents the locations the produce is available from
CREATE TABLE "locations"(
    "id" INTEGER,
    "address" TEXT NOT NULL,
    "latitude" REAL NOT NULL,
    "longitude" REAL NOT NULL,
    PRIMARY KEY("id");
);

-- Represents the listings of available produce
CREATE TABLE "listings"(
    "id" INTEGER,
    "user_id" INTEGER,
    "type_id" INTEGER,
    "quantity" INTEGER,
    "weight" REAL,
    "input_id" INTEGER,
    "location_id" INTEGER,
    "date_listed" NUMERIC NOT NULL DEFAULT CURRENT_DATE,
    "description" TEXT,
    "delete", INTEGER DEFAULT 0
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("type_id") REFERENCES "produce"("id"),
    FOREIGN KEY("input_id") REFERENCES "inputs"("id"),
    FOREIGN KEY("location_id") REFERENCES "locations"("id")
);

-- SECOND: The indexes to speed up common searches in GreenGive.db

CREATE INDEX "location_search" ON "locations" ("address");
CREATE INDEX "produce_search" ON "produce" ("type");
CREATE INDEX "organic_search" ON "inputs" ("type");

--THIRD: View of the produce and the locations they are listed at

CREATE VIEW "location_listings" AS
SELECT "address", "type" FROM "locations"
JOIN "listing" ON "locations"."id" = "listings"."location_id"
JOIN "produce" ON "type"."id" = "listings"."type_id";

-- FOURTH: To keep the view of all the listings at a location clean set up a trigger to remove items from a view by doing a soft delete in GreenGive.db
-- where a row in the `listings` table is flagged as deleted by updating the value in the `deleted` column from 0 to 1 for that listing

CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "location_listings"
FOR EACH ROW
BEGIN
    UPDATE "listings" SET "deleted" = 1 WHERE  "id" = OLD."id";
END;


