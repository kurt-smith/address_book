Companies House Search Project
=========

*Note: This project is a work in progress*

Live demo available at https://companies-house-search.herokuapp.com/

---

This project is a Ruby on Rails demo of interacting with a the Companies House API.  The following features have been implemented:

- Create an address book that can record two types of entities - people (first name, last name) and companies (get company name, company number).  the address book can relate people to companies.  The address book can record addresses for people and companies.

- Set up a simple search box that lets me search companies in the Companies House database (search by name is fine)

- Present search results in a simple table listing the company names as hyperlinks

- Clicking on the company name hyperlinks should pull the full company record (get company name, company number, address and officers)

- Enable me to import the full record into the address book (save company name, company number, address and officers).

#### Ruby 2.4.4
#### Rails 5.1.6

### Dependencies

This service has dependencies on the following services:

1. Ruby `2.4.4`
1. MongoDB
1. Redis
1. Sidekiq

### Docker
Follow the Docker [Getting Started](https://docs.docker.com/get-started/) guide to get `docker` and `docker-compose`.  This project contains helper scripts to build and test services.

1. Run the test suite: `$ script/test`

#### Local development
To start the application using docker compose locally:

1. Start the services: `$ docker-compose up --build`
1. Access via browser: `$ open http://localhost:3000`

### Local development (without Docker)
To start the application from project folder:

1. Start Redis: `$ redis-server`
1. Start Sidekiq: `$ bundle exec sidekiq`
1. Start App: `$ rails s`
1. Access via browser: `$ open http://localhost:3000`

### Database

1. MongoDB

#### Setup

1. `docker-compose run app rake db:mongoid:create_indexes` (Docker)
1. `db:mongoid:create_indexes` (Local)

### Environment Variables

| Variable       |  Description   | Default                 |
| ---------------|:---------------|:-----------------------:|
| `MONGODB_URI`  | MongoDB URI   | mongodb://localhost:27017/companies_house_development |
| `REDIS_CACHE_URL`  | Redis Cache URL | redis://localhost:6379/0 |
| `REDIS_WORKER_URL`  | Redis Worker URL | redis://localhost:6379/1 |
| `DB_MAX_CONNECTIONS`  | Mongo Max Connections  | 16 |
| `DB_MIN_CONNECTIONS`  | Mongo Min Connections | 5 |
| `DB_WAIT_QUEUE_TIMEOUT`  | DB Queue Timeout  | 5 |
| `DB_CONNECT_TIMEOUT`  | DB Connection Timeout  | 10 |
| `DB_SOCKET_TIMEOUT`  | DB Socket Timeout | 5 |
| `COMPANIES_HOUSE_API_KEY`  | Companies House Api Key | - |

### Future Considerations

1. TBD

### Tradeoffs

1. TBD
