-- The typical SQL queries users will run on GreenGive.db

-- Find all listings from one location
-- For example if the most convenient collection point for a user is at an allotment on 27 Old Gloucester Rd Cheltenham GL51 0WS
-- This query makes use of the view `location_listings`
SELECT "type" 
FROM "location_listings"
WHERE "address" = `27 Old Gloucester Rd Cheltenham GL51 0WS`;

-- Find all listings of a particular fruit or vegetable
-- For example a user only wants to see listings that contain strawberries
-- This query also makes use of the `location_listings` view

SELECT "address" 
FROM "location_listings"
WHERE "type" = `Strawberries`;

-- Find all listings that used no inputs
-- This needs a compound query as there is no view of the listings and input types

SELECT "title"
FROM "listings"
WHERE "id" IN (
    SELECT "id" 
    FROM "inputs"
    WHERE "type" = `none`
) AND "input_id" = NULL;

-- Find all listings using only organic inputs
-- This needs a compound query or the same reason as above

SELECT "title"
FROM "listings"
WHERE "id" IN (
    SELECT "id" 
    FROM "inputs"
    WHERE "type" LIKE 'Organic %'
);

-- Add a new user
INSERT INTO "users" ("first_name", "last_name", "user_name", "bio")
VALUES (`Molly`, `Chester`, `Apricot lane`, `An aspiring farmer with a particular talent for growing strawberries`);

-- Add new types of produce
INSERT INTO "produce" ("type")
VALUES (`Strawberries`),
VALUES (`Potatoes`),
VALUES (`Courgettes`);

-- Add inputs used when growing the crop from the predetermined list
INSERT INTO "inputs" ("type")
VALUES (`Compost`),
VALUES (`Organic mineral fertilisers`);

-- Add a location where the produce is available from
INSERT INTO "locations" ("address", "latitude", "longitude")
VALUES (`27 Old Gloucester Rd Cheltenham GL51 0WS`, `51.917`, `-2.1172`);

-- Add a new listing
INSERT INTO "listings" ("title", "user_id", "type_id", "quantity", "weight", "input_id", "location_id", "date_listed", "description")
VALUES ("Super-sweet strawberries", 1, 1, NULL, 0.5, 1, 1, 2024-04-11, `Benihoppe strawberries, with their radiant red hue and delectable flavor, are a delight. These elongated, conical berries offer a melt-in-your-mouth experience. They boast a perfect balance of sweetness and tartness, coupled with a rose-like fragrance`);

