VIDEO TRACKER

Runs on Ruby version 2.5.1

To Run in Docker Container:
  
  run the following commands:

  $ docker-compose build 
      builds app from dockerfile

  $ docker-compose run web rails db:create db:structure:load
      creates the database and loads the schema from the db/structure.sql ( which is symlinked to create.sql )

  $docker-compose up
      runs the container
      the tests are run on startup
