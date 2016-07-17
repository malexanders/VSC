# Ruby version
ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin13]

# Rails version
rails 4.2.6

# Running the Code Locally

## Install postgresql
If you do not already have postgresql installed and configured, follow this link:

For Mac
http://www.postgresql.org/download/macosx/

For Linux
https://wiki.postgresql.org/wiki/Detailed_installation_guides

## Clone the repo from github

From console:
`git clone https://github.com/malexanders/VSC.git`

then cd into VSC directory.

## Install gems and set up database
### Run these commands in the terminal, inside the app directory
1. `bundle install`
2. `rake db:create`
3. `rake db:migrate`
4. `rake db:seed`

Now all the sample data should exist locally inside a postgresql db.

## Running Test Suite
Run `rspec --format documentation` in terminal from inside the app directory.

## Local API Requests
You can view all the required data in your browser by making the following get requests to the rails API.

_TIP: JSONview is a great chrome extension that pretty prints the json to the browser window. Much nicer than a json blob._

a list of all items

http://localhost:3000/items.json

details of one item

http://localhost:3000/items/1.json

a list of all sold items for a particular seller

http://localhost:3000/users/1/sold_items.json

a list of available items for a particular category

http://localhost:3000/categories/1/available_items.json


# Production Server API Requests

I deployed the application to Heroku. You can view all the required data by making requests directly to the rails api, running on a heroku production server. I have seeded the production db with all the same sample data you have access to locally.

To make API requests to the production server please use the following urls:

a list of all items

https://aqueous-lowlands-69853.herokuapp.com/items.json

details of one item

http://localhost:3000/items/1.json

a list of all sold items for a particular seller

http://localhost:3000/users/1/sold_items.json

a list of available items for a particular category

http://localhost:3000/categories/1/available_items.json

# Design Rationale

## Associations
many-to-many relationship for items and categories association:
* has_many through
	* more flexible than has_and_belongs_to_many
	* can add more data than just the foreign_keys in the join table
		* created 'categorizations' model to join items and categories
			* belongs_to items
			* belongs_to categories
			* contains both foreign keys
* allows for multiple categories to be added to an item in the future.
	* I noticed on the varage sale website there are categories and sub-categories for items. This could be implemented using a has_many through association.

one-to-many relationship for items to user(as seller) relationship
* seller has_many items
	* seller can sell many items
* item belongs_to seller
	* typically an item can only be sold by one person or entity
* I chose to alias the foreign key as seller_id because:
	* highly likely to add other personas to the user model, like buyer for example.

## Data Types
### User Model
| column | type | reason |
| ------ | ---- |------- |
| name   | string | TODO __limit characters__ |
| latitude | decimal{9,6} | I chose the decimal type because it is more accurate than float. I chose this degree of accuracy because every decimal instance in ruby that has a precision of 1-9 takes up 5 bytes. Therefore, you might as well chose the maximum precision of 9. A scale of 6 is probably over kill as it should provide a precision of < 1m, at the equator. You will never need more than 3 digits left of the decimal in a lat/long value |
| longtitude | decimal{9,6} | see latitude |


### Item Model
| column | type | reason |
| ------ | ---- |------- |
| title | string | TODO __limit characters__ |
| description | text | Text has more characters than string. Allows users to add a long description about an item. |
| price | bigint | Save price in cents; Integers perform faster than numeric or float in math operations|
| status | integer | Allows me to apply ActiveRecord Enum to this column. Status options are a static list and are unlikely to change much in the future, therefore, ActiveRecord Enum is an elegant solution for getting and setting values. |
| published_date | datetime | standard type for date columns |
| seller_id | integer | standard type for foreign_keys; seller_id is a foreign_key that references the primary key in the user table. An item will only have one seller (belongs_to :seller), therefore, the seller_id should exist in the item table |

### Category Model
| column | type | reason |
| ------ | ---- |------- |
| name | string | standard type for title column |

### Categorizations Model
| column | type | reason |
| ------ | ---- |------- |
| item_id | integer | standard type for foreign_keys |
| category_id | integer | standard type for foreign_key |




* Database creation

* Database initialization

* How to run the test suite
