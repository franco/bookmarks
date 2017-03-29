# README

Bookmarks is an assessment task for a developer position. This README contains some
remarks and discusses some decisions made in this project.

## PROJECT OUTLINE AND TODO


### Outline

* Bookmark (*title:str, *url:Url<str>, shortening:str, site:site_ref)
* Site(*url:Url<str> [top-level url])
* Operations: CRUD and search bookmarks
* Optional:
** Tags for bookmarks
** search any field or tag

#### Needs clarification

- shortening? This is a short url?
- Each bookmark belongs to a Site. Is there a UI for listening the sites? 


### Tech Stack

- Bootstrap over Foundation
- RSpec over minitest
- No React (in first stage)


### Before submitting

- [ ] All tests are green?
- [ ] Check documentation
- [ ] Lint project

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
