# Sinatra PostgreSQL Example Application on Clever Cloud

[![Clever Cloud - PaaS](https://img.shields.io/badge/Clever%20Cloud-PaaS-orange)](https://clever-cloud.com)

This is a minimal Sinatra application that demonstrates how to connect to a PostgreSQL database on Clever Cloud.

## About the Application

This application provides a simple REST API:
- `GET /:name` - Returns the user with the given name (JSON)
- `POST /` - Creates a new user with the name provided in the request body

## Technology Stack

- [Sinatra](https://github.com/sinatra/sinatra) 4.0 - A DSL for quickly creating web applications in Ruby
- [ActiveRecord](https://github.com/rails/rails/tree/main/activerecord) 7.2 - Object-Relational Mapping (ORM) for Ruby
- [PostgreSQL](https://www.postgresql.org/) - The world's most advanced open source relational database
- [Puma](https://puma.io) 7.2 - A fast, concurrent web server for Ruby
- Ruby 4.0+

## Prerequisites

- Ruby 4.0+
- Bundler
- PostgreSQL (for local development)

## Running the Application Locally

### 1. Set up the local PostgreSQL database

Create a `.env` file (which is `.gitignore`'d) with your PostgreSQL connection details:

```bash
export POSTGRESQL_ADDON_HOST=localhost
export POSTGRESQL_ADDON_PORT=5432
export POSTGRESQL_ADDON_USER=user
export POSTGRESQL_ADDON_PASSWORD=secret
export POSTGRESQL_ADDON_DB=demo
export DB_POOL=5
```

### 2. Install dependencies and run migrations

```bash
source .env
bundle install
bundle exec rake db:migrate
bundle exec rackup
```

The application will be accessible at http://localhost:9292.

## Deploying on Clever Cloud

You have two options to deploy your Sinatra application on Clever Cloud: using the Web Console or using the Clever Tools CLI.

### Option 1: Deploy using the Web Console

#### 1. Create an account on Clever Cloud

If you don't already have an account, go to the [Clever Cloud console](https://console.clever-cloud.com/) and follow the registration instructions.

#### 2. Set up your application on Clever Cloud

1. Log in to the [Clever Cloud console](https://console.clever-cloud.com/)
2. Click on "Create" and select "An application"
3. Choose "Ruby" as the runtime environment
4. Configure your application settings (name, region, etc.)

#### 3. Add a PostgreSQL addon

1. In your application dashboard, click on "Add an addon"
2. Select "PostgreSQL" and choose a plan
3. The database will be automatically linked to your application

#### 4. Configure Environment Variables

Add the following environment variables in the Clever Cloud console:

| Variable | Value | Description |
|----------|-------|-------------|
| `CC_RACKUP_SERVER` | `puma` | Rack server to use |
| `CC_PRE_RUN_HOOK` | `bundle exec rake db:migrate` | Run database migrations on deploy |
| `DB_POOL` | `5` | Maximum number of database connections |

### Option 2: Deploy using Clever Tools CLI

#### 1. Install Clever Tools

Install the Clever Tools CLI following the [official documentation](https://www.clever-cloud.com/doc/clever-tools/getting_started/):

```bash
# Using npm
npm install -g clever-tools

# Or using Homebrew (macOS)
brew install clever-tools
```

#### 2. Log in to your Clever Cloud account

```bash
clever login
```

#### 3. Create a new application

```bash
# Step 1: Initialize the current directory as a Clever Cloud application
clever create --type ruby <YOUR_APP_NAME>

# Step 2: Add a PostgreSQL addon
clever addon create postgresql-addon <ADDON_NAME> -l <YOUR_APP_NAME>

# Step 3: Set the required environment variables
clever env set CC_RACKUP_SERVER puma
clever env set CC_PRE_RUN_HOOK "bundle exec rake db:migrate"
clever env set DB_POOL 5
```

#### 4. Deploy your application

```bash
clever deploy
```

## API Examples

### Create a user

```bash
curl -X POST https://<YOUR_DOMAIN_NAME>/ -d "john"
```

### Get a user

```bash
curl https://<YOUR_DOMAIN_NAME>/john
```

## Monitoring Your Application

Once deployed, you can monitor your application through:

- **Web Console**: The Clever Cloud console provides logs, metrics, and other tools to help you manage your application.
- **CLI**: Use `clever logs` to view application logs and `clever status` to check the status of your application.

## Additional Resources

- [Sinatra Documentation](https://sinatrarb.com/)
- [ActiveRecord Documentation](https://guides.rubyonrails.org/active_record_basics.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Puma Documentation](https://puma.io)
- [Clever Cloud Ruby Documentation](https://www.clever-cloud.com/developers/doc/applications/ruby/)
- [Clever Cloud PostgreSQL Addon](https://www.clever-cloud.com/doc/addons/postgresql/)
