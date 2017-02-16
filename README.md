# Project Organizer

Project Oganizer is a Web App, built on Sinatra, to help you manage your projects and their associated tasks.  A video walkthrough is listed below.  After signing up you can:

  - Create projects automatically sorted by due date
  - Create tasks automatically associated to their projects
  - View all of your projects
  - View individual projects and all of the project's tasks
  - Mark Tasks complete
    * Once all of a project's tasks are completed, the project will be marked completed with the date it was completed
  - Delete Tasks
  - Delete Projects with their associated tasks


  NOTE: *Whenever deleting something you will be prompted to confirm your action.*

You can also:
  - Change your username or delete account

## Installation
Clone the repository, then execute:
```
$ bundle
```

## Usage
Clean then migrate the database:
```
$ rake db:reset db:migrate
```
To start the server, run:
```
$ shotgun
```
Then navigate to ```localhost:9393``` or run:
```
$ open http://localhost:9393
```
Note: *You can also use ```rackup``` then go to ```localhost:9292``` as an alternative to ```shotgun```*

### Tech

Project Organizer uses a number of open source projects to work properly:
* [Sinatra] - A DSL for quickly creating web applications in Ruby with minimal effort.
* [Active Record] - Connects classes to relational database tables.
* [Twitter Bootstrap] - great UI boilerplate for modern web apps.
* [Bcrypt] - A sophisticated and secure hash algorithm designed by The OpenBSD project.


And of course Project Organizer itself is open source with a [public repository][prjorg]
 on GitHub.


### Todos

 - Allow changing of password
 - Adding group project functionality

## Contributing

Bug reports and pull requests are welcome on GitHub at [this project's repository][prjorg]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

This Web Application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


   [prjorg]: <https://github.com/jilustrisimo/project-organizer>
   [bcrypt]: <https://rubygems.org/gems/bcrypt/versions/3.1.11>
   [Active Record]: <https://github.com/rails/rails/tree/master/activerecord>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [Sinatra]: <https://github.com/sinatra/sinatra>

