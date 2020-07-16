# Rails Engine: Back End Mod 3 Solo Project

## Introduction

*Rails Engine* is an API that exposes data about merchants, items, and revenue to be consumed by a a partner front end application called *Rails Driver*. This service-oriented architecture was our first foray as Turing students into creating and exposing an API. I completed it single handedly over the course of 6 long days.  

The project first required us to create a Rake Task to seed our database using data from 6 CSV files provided. Once that was accomplished, including setting up our models and migrations along with unit tests, we dove into creating API Endpoints. Though we were provided with the required URIs, it was our responsibility to create ReSTful routes. This proved to be a fun challenge, as well as creating services to support controller actions and carry out the bulk of the database calls.

All endpoints return JSON data which is compliant with the JSON API spec through the use of serializers. Furthermore, all endpoints are exposed under an `api` and `v1` namespace, and tested at the feature and unit level.

In addition to `index`, `show`, `create`, `update`,  and `destroy`, both Merchant and Item also have `find_all` and `find` endpoints which are namespaced in the appropriate SearchController with `index` and `show` functions corresponding to the aforementioned endpoints. There are also 2 relationship endpoints showing a particualar merchant's items and a specified item's merchant. Finally there are 4 "business intelligence" endpoints. These were the most challenging and most interesting to complete, from the required ActiveRecord to the decision on how to organize and name controllers and services.

## Tech Stack

 - Ruby 5.1.7
 - Rails 5.2.4.3
 - PostgreSQL
 - Gems
   * [Fast JSON API](https://github.com/Netflix/fast_jsonapi)(Thanks Netflix!)
   * [Money](https://github.com/RubyMoney/money)
   * [Rack CORS Middleware](https://github.com/cyu/rack-cors)
   * [Factory Bot](https://github.com/thoughtbot/factory_bot_rails)
   * [Faker](https://github.com/faker-ruby/faker)

## Schema

![Schema](/public/rails_engine_schema.png)

## Routes + Results

### Merchants Endpoints
`GET /api/v1/merchants`
returns all merchants

`POST /api/v1/merchants`
create a new merchant by passing required params

`GET /api/v1/merchants/:id`
returns a specified merchant

`PATCH /api/v1/merchants/:id`
updates a merchant by passing required params 

`PUT /api/v1/merchants/:id`
updates a merchant by passing required params 

`DELETE /api/v1/merchants/:id`
deletes a merchant

`GET /api/v1/merchants/find?{attribute}={value}`
finds a single merchant based on query params
can search with multiple query params by adding `&{attribute}={value}`

`GET /api/v1/merchants/find_all?{attribute}={value}`
finds all merchants matching query params
can search with multiple query params by adding `&{attribute}={value}`

### Items Endpoints
`GET /api/v1/items` - all items

`POST /api/v1/items` - create a new item

`GET /api/v1/items/:id` - returns a specified item

`PATCH /api/v1/items/:id` - updates an item

`PUT /api/v1/items/:id` - updates an item

`DELETE /api/v1/items/:id` - deletes a merchant

`GET /api/v1/items/find?{attribute}={value}` - finds a single item based on query params. Can search with multiple query params by adding `&{attribute}={value}`

`GET /api/v1/items/find_all?{attribute}={value}` - finds all items matching query params. Can search with multiple query params by adding `&{attribute}={value}`

### Relationship Endpoints
`GET /api/v1/merchants/:merchant_id/items` - returns a list of all the items sold by the specified merchant

`GET /api/v1/items/:item_id/merchant` - returns the merchant that sells the specified item

### Business Intelligence Endpoints
`GET /api/v1/merchants/most_revenue?quantity={number}` - returns the specified number of merchants ranked by their total revenue

`GET /api/v1/merchants/most_items?quantity={number}` - returns the specified number of merchants ranked by how many items they have sold total

`GET /api/v1/revenue?start={yyyy-mm-dd}&end={yyyy-mm-dd}` - returns the collective revenue for all merchants between the dates given

`GET /api/v1/merchants/:merchant_id/revenue` - returns the total revenue for the specified merchant
