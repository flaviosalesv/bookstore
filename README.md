# Bookstore

Bookstore APP from Backend Python course from EBAC

## Prerequisites

Python 3.5>
Poetry
Docker && docker-compose


## Quickstart

1. Clone this project

   ```shell
   git clone git@github.com:drsantos20/bookstore.git

Install dependencies:
cd bookstore
poetry install

Run local dev server:
poetry run manage.py migrate
poetry run python manage.py runserver

Run docker dev server environment:
docker-compose up -d --build 
docker-compose exec web python manage.py migrate

Run tests inside of docker:
docker-compose exec web python manage.py test
