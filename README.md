* Ruby/Rails versions
ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin13]
rails 4.2.6

# Design Rationale



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
| seller_id | integer | foreign_key referencing the primary key of the user table. An item will only one seller (belongs_to :seller), therefore, the seller_id should exist in the item table |

### Category
| column | type | reason |
| ------ | ---- |------- |
| name | string | standard type for title column |




* Database creation

* Database initialization

* How to run the test suite
