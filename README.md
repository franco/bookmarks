
# README

Bookmarks is an assessment task for a developer position. This README 
contains some remarks and discusses some decisions made in this project.

### Implementation notes

* In order to save time I used scaffold to generate code and worked from 
there. This leads sometimes to code excess. Especially the views don't 
look very nice. E.g. for the forms I would use SimpleForm.

* UI is kept simplistic. 

* I choose bootstrap v4-alpha. Obviously I wouldn’t use alpha software in 
production, but I was curious to see what is new.

* Tag support: There are many ways to implement tagging and many different 
Rails gems.  As I am not supposed to use unnecessary gems I decided to go 
simply with a Postgres array. This also makes search fairly easy. A 
disadvantage is that gathering all tags on large datasets (e.g. for tag cloud, 
typeahead) is very inefficient. Furthermore I kept the UI simple and I didn’t 
implement a tag input-tokenizer as this would be out of scope for the time 
available (there are drop-in solutions which didn’t work together with 
bootstrap 4 out of the box). 

* Search: well, there one could get fancy with elasticsearch but this would 
be completely out of scope. It simply uses a SQL query. 

* To keep the Bookmark and Site model in sync I could have used AR callbacks, 
AR Observers, or Service Objects. I usually use AR callbacks only to maintain 
attributes on its own class. Therefore I went with a Service Object. Services 
facilitates also testing in isolation. Although in this case AR callbacks 
would have been fine too as Bookmark is strongly dependent on a Site. 

* I haven’t used rspec in a while (used minitest lately), therefore the specs 
might be written not very idiomatic. And I couldn’t get `rake test` to run the 
specs instead of the tests. So to run all tests use `bin/rspec`.

