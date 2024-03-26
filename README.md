# Using Soda Core to Check Movie Data

## Setting Up Movie Rating Database
Go ahead and start the postgres database in a docker environment.

`docker build -t postgresdb .`

`docker run -d --name my-postgres-container -p 5432:5432 postgresdb`

At this point, you'll have the database made. You may want to run the following command to query database manually:

`docker run   -it --rm   --link my-postgres-container:postgres postgres psql -h postgres -U user recommender_db`

It will prompt you for a password. The default password is "password".

The details of how to populate a database are out of the scope of this project, given that it focuses only on using Soda Core to validate data in a database. Example data is provided in ratings.csv for your reference.

If you ever want to pull the ratings table from the dockerized container to a csv file in this folder, run `sudo docker exec -u postgres  my-postgres-container psql -U user -d recommender_db -c "COPY ratings TO STDOUT WITH CSV HEADER " > ratings.csv`. This is the command I executed to yield the ratings.csv file included in the repository. Feel free to use this csv file to populate your database for testing.

## Connect Soda Core to Database
### Installing Soda Core

Start by creating an environment

`python3 -m venv .venv`

`source .venv/bin/activate`

Whenever you want to leave this environment, simply type `deactivate`

Within this environment, install soda core:

`pip install -i https://pypi.cloud.soda.io soda-postgres`

### Soda Configuration

We now need to configure soda to connect to the ratings database. This will be done in the `configuration.yml` file. The default file is already set up to interface with the recommender database, but you will need to add your own  `api_key_id` and `api_key_secret` in order to have it interface with your account. These are available at https://cloud.us.soda.io/account once you've signed in. If you've configured everything correctly, you can test the connection to the database:

`soda test-connection -d postgresdb -c configuration.yml`

If successful, you will get a message verifying that:

`Successfully connected to 'postgresdb'.`
`Connection 'postgresdb' is valid.`

## Running Soda Core Checks

Now all we have left to do is run some checks on the database! You can outline all the checks you want in `checks.yml`. There are already default checks in the file right now, but any additional checks would be added here.

Now we run a scan to execute all the checks:

`soda scan -d postgresdb -c configuration.yml checks.yml`

You're all done! Feel free to go to https://cloud.us.soda.io/ and see the results!