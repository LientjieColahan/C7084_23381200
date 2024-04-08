# Design Document for the GreenGive Database

By Susan Helene Colahan, 23381200

Video overview: <URL [https://youtu.be/ey39eeWjqR8]>

## Scope

### What is the purpose of GreenGive.db

The purpose of this database is to give like-minded people the ability to easily exchange or give away produce they have grown themselves that is in surplus of their own requirements.
Since the pandemic, where many people attempted baking their own bread using a home grown yeast starter, and many tried their hand at growing tomatoes, there is a growing community of windowsill, back garden and allotment fruit and veg growers who would benefit from having a means to share the produce they don't need and connect with one another.

### Who will benefit from this database and what information will they find or need to add

The database is designed to be used by the general public who will need to supply their basic information including name, surname, address where they grow produce, and a short biography to create a user profile. The users would also benefit from being able to include a profile picture of their choosing in the database, which is beyond the scope of this assignment but would be a valuable addition.

There will also be information about the different types of produce in the database including the general name of the item, for example `strawberry` with the weight or amount available as well as a description which may contain further information about the item for example `Benihoppe strawberries`. Being able to add a picture of the fruit or vegetable on offer would also be a valuable functionality in this database but is beyond the scope of this assignment.

Wih a growing concern around the use of synthetic inputs when producing food and the potential health effects, the database includes general information about the inputs used during the growing season.If all different product names for inputs were included there would be a large number of entries that would be used by a small number of users, resulting in a masses of redundant information and increasing the computational load with no real benefit to the user. Since most users would be concerted with organic vs. non-organic products in most instances a shortlist of generalised inputs is created which will answer the question sufficiently.

Users will be able to find the location where the produce can be picked up or dropped off for collection in the database.

This database has not been designed as a commerce platform and as such any e-commerce functionality/ the storage of payment information is outside the scope of this database as well as any food safety testing or tracing information.

Due to the risks associated with food safety any products of animal origin are out of the scope of this database.

## Functional Requirements

### What will and won't people be able to do with the database

This database has been designed to satisfy the need of so called "backyard farmers" to distribute the excess vegetables or fruits they have grown. The database should allow a user to create a profile for themselves containing their basic information and a short bio if they wish. Users should be able to create their own, and browse other "listings" which detail the type and amount of produce available and where this produce can be collected from.

The database will support creating, reading/retrieving, updating and deleting/destroying operations (CRUD operations)
All users and listings in this database will be tracked to maintain data integrity and audit changes.

Users will not be able to sell their produce with this database
Users will not be able to chat to each other or make comments on listings in this database

## Representation

Entities are captured in SQLite tables with the following schema

### Entities

The database includes the following entities:

#### Users

The `users` table includes:

* `id`, which specifies the unique ID for the student as an `INTEGER`, this column has the `PRIMARY KEY` constraint applied.
* `first_name`, specifying the user's first name as `TEXT` given that `TEXT` is appropriate for name fields
* `last_name`, which specifies the user's last name as `TEXT` which is used for the same reason as in `first_name`
* `user_name`, which specifies the chosen username as `TEXT` which is used for the same reason as in `first_name`. A `UNIQUE` constraint ensures no two users have the same user name
* `bio`, which contains the user's description of themselves as `TEXT` given that `TEXT` is commonly used to store descriptions

All columns except `bio` in the `users` table have the `NOT NULL` constraint applied to ensure all user profiles contain the necessary information.

If this database were to be used as backing to a real world mobile application or website additional info such as:

* `picture`, containing a profile picture uploaded by the user as `BLOB` since `BLOB` is most appropriate for storing images.
* `contact_number`, containing the user's contact number stored as `NUMERIC`
* `email`, containing the user's email stored as `TEXT`
Could also be added as columns in the `users` table, but that is beyond the scope of this project.

#### Produce

The `produce` table includes:

* `id`, specifying the unique ID for the type of produce as an `INTEGER`, this column has the `PRIMARY KEY` constraint applied.
* `type`, which names different types of produce as `TEXT` given that `TEXT`is appropriate for storing name fields.There is an `UNIQUE` constraint applied to ensure no produce types are duplicated

#### Inputs

The `inputs` table includes:

* `id`, which specifies the unique ID for the type of product/ substance used as an `INTEGER`, this column has the `PRIMARY KEY` constraint applied
* `type`, containing a predetermined general list of inputs as `TEXT` considering that `TEXT` is appropriate for storing categories.There is a `DEFAULT` value applied of `none` and a `CHECK` is in place to ensure the values are only from the generalised list of inputs to prevent the `inputs` table from containing many entries that are used by only a few users.

#### Locations

The `locations` table includes:

* `id`, which specifies the unique ID of the location as an `INTEGER`, this column has the `PRIMARY KEY` constraint applied
* `address`, which specifies the address of the location in the format first line, second line, county, post code as `TEXT` because `TEXT` is appropriate for storing alphanumerical information
* `latitude` which contains the latitude of each unique location as `REAL` given that `REAL` is used when storing decimal numbers
* `longitude` which contains the longitude of each unique location as `REAL` which is used for the same reason as `latitude`

As with the `users` table there are enhancement that could be made if this database were used as a backing to a real world mobile application or website.  The latitude and longitude could be linked to a geographical database such as Google Maps, Waze or What3Words to improve the user experience. For the purposes of this assignment the address and coordinates are sufficient.

#### Listings

The `listings` table includes:

* `id`, which specifies the unique ID of the produce listing as an `INTEGER`, this column has the `PRIMARY KEY` constraint applied
* `title` which contains the title of the listing chosen by the user as `TEXT` as this is appropriate for storing names
* `user_id` which specifies the user that owns the listing as an `INTEGER`, this column has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integrity
* `type_id` which specifies the type of produce as an `INTEGER`, this column has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `produce` table to ensure data integrity
* `quantity`, which specifies the number of the produce there is available as an `INTEGER` because `INTEGER` is appropriate for storing whole numbers
* `weight`, which specifies the weight of produce available in kilograms as `REAL` which is appropriate for storing decimal numbers
* `input_id`, which specifies the inputs used during the production as an `INTEGER`, this column has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `inputs` table for data integrity
* `location_id` which specifies where the produce can be collected from as an `INTEGER`, this column has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `locations` table to ensure data integrity
* `date_listed` which specifies the date the listing was created as `NUMERIC` as this is appropriate for storing dates. Users input the date in the YYYY-MM-DD format. If they forget a default value is assigned to pick the current timestamp.
* `description` which contains a short description of the listing by the user that has created it as `TEXT` because `TEXT` is appropriate for storing descriptions

In the same way as in the `users` and `locations` tables if this database were used to back a real world smartphone app or website there are useful additions that could be made to improve the database. A `picture` column could be included, which specifies an image of the produce in the listing as `BLOB` since `BLOB` is most appropriate for storing images. This is beyond the scope of this project.

All the users of this database are very fastidious about their listings and delete listings as soon as they have given the produce to a lucky recipient, or worst case, the produce has gone off.

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

Mermaid code chunk used to generate ER diagram:

![GreenGive_ER_diagram](<GreenGive_ER_diagram.png>)

#### As detailed by the diagram

* One user can create 0 or many listings. 0, if the user is yet to harvest any produce and many if there are different types of produce or multiple harvests. Listings can only be created by a single user.
* Each user must be associated with one location but can be associated with many if there is more than one place they grow produce. Each location must be associated with a user, and can be associated with multiple users for example when an allotment is used as the location.
* Listings can have 0 or many inputs associated with them. 0 if none were used or the user does not specify, and many if any combination of inputs were used or the user specifies `none`. Inputs can be associated with 0 or many listings. 0 if no current listing used that input and many if multiple listings used that input to grow produce.
* A listing can only be associated with one location as for simplicity it is assumed the produce is only supplied from where it is grown. 0 or many listings can be associated with a location. 0 if no listings are available from that location or many if multiple listings are available from one location such as an allotment.
* A listing can only be associated with a single produce category, it is assumed no mixed fruit and veg boxes are part of this database. The different produce categories can be associated with one or many listings for example when there is more than one listing containing runner beans.

## Optimizations

### Indexes

Considering the common queries in `GreenGive_queries.sql` users will likely want to find all listings associated with a particular location, as such an index is created on the `address` column in the `locations` table to speed up searches. Users will also want to easily see all the listings for a specific fruit or vegetable of interest so an index is created on `type` in the `produce` table to speed up searches.

There may also be users who are concerned about the use of synthetic chemicals and would prefer to only see the listings where organic inputs or no inputs were used at all. To facilitate this an index is created on the `type` column in the `inputs` table.

### Views

* As it would make it more convenient to collect fruit or vegetables users might want to easily view all the produce available from a location close to their home, work or gym. Or a user might really want a specific type of produce and they are willing to travel to get it. To accomplish this easily a view showing all the produce types and locations would be useful

## Limitations

This database design is limited in that it assumes that all listings will be from one user and made up of one produce type. If multiple users wanted to join up to create listings that contain more of one type of produce or to create listings with a mix of produce the relationship between listings and users would need to change from a one-to-one relationship to a one-to-many relationship. The relationship between listings and produce would also need to change from a one-to-one relationship to a one-to-many relationship.

This means the database does not lend itself to showcasing collaboration very well in its current iteration but has a sufficient level of basic functionality to start the exchange of excess fruit or vegetables a person has grown.

Another limitation of the database is that it relies on users to signal to the database that a listing has become redundant by running a soft deletion trigger when the DELETE clause is used. In the real world the users would most likely not remember to do this and creating a trigger to capture the timestamp when data is added to the `listings` table and then creating a scheduled event/job to run daily checking which rows are one month old and updating the `deleted` column's value to 1 for those rows would help overcome this limitation but is beyond the scope of this assignment.

Because there is no chat functionality built into this database it relies on an idea of clearly marked *collection areas* at each location where each listing is clearly identified and the database user knows the unique ID of the listing to collect it. This would not work in a real world situation, a solution to this limitation would be the use of a locker system where the produce from a listing is placed in a locker and a QR code linked to that listing is used to open the locker. This would also prevent people from stealing produce from a different listing that looks more enticing than the listing they are collecting.