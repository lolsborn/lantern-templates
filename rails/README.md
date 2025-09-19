# {{project_name}}

A modern Ruby on Rails 7 API application with authentication, testing, and deployment ready configuration.

## Features

- **Rails 7**: Latest Rails framework with modern Ruby practices
- **API-first**: JSON API with comprehensive error handling
- **Authentication**: Devise with JWT token authentication
- **Database**: PostgreSQL with optimized configurations
- **Background Jobs**: Sidekiq with Redis
- **Testing**: RSpec with FactoryBot and comprehensive test suite
- **Code Quality**: RuboCop with Rails, RSpec, and Performance cops
- **Security**: Brakeman for security scanning
- **Containerization**: Docker and Docker Compose setup
- **Monitoring**: Structured logging and error tracking ready

## Quick Start

1. **Copy environment configuration:**
   ```bash
   cp .env.example .env
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Setup database:**
   ```bash
   rails db:create db:migrate db:seed
   ```

4. **Start the server:**
   ```bash
   rails server
   ```

## Docker Development

1. **Start all services:**
   ```bash
   docker-compose up
   ```

2. **Setup database in container:**
   ```bash
   docker-compose exec web rails db:create db:migrate db:seed
   ```

## API Endpoints

### Authentication
- `POST /api/v1/auth/sign_in` - User login
- `POST /api/v1/auth/sign_up` - User registration
- `DELETE /api/v1/auth/sign_out` - User logout

### Users
- `GET /api/v1/users` - List all users (paginated)
- `POST /api/v1/users` - Create new user
- `GET /api/v1/users/:id` - Get user details
- `PATCH /api/v1/users/:id` - Update user
- `DELETE /api/v1/users/:id` - Delete user
- `GET /api/v1/me` - Get current user profile

### Health Check
- `GET /health` - Application health status

## Authentication

This API uses JWT tokens for authentication. Include the token in the `Authorization` header:

```
Authorization: Bearer <your_jwt_token>
```

## Testing

**Run the full test suite:**
```bash
rspec
```

**Run tests with coverage:**
```bash
COVERAGE=true rspec
```

**Run specific test files:**
```bash
rspec spec/models/user_spec.rb
rspec spec/requests/api/v1/users_spec.rb
```

## Code Quality

**Run RuboCop:**
```bash
bundle exec rubocop
```

**Auto-fix RuboCop violations:**
```bash
bundle exec rubocop -A
```

**Run security scan:**
```bash
bundle exec brakeman
```

## Database

**Run migrations:**
```bash
rails db:migrate
```

**Rollback migration:**
```bash
rails db:rollback
```

**Reset database:**
```bash
rails db:reset
```

## Background Jobs

**Start Sidekiq worker:**
```bash
bundle exec sidekiq
```

**Monitor Sidekiq (in development):**
```bash
# Add to routes.rb for development:
# require 'sidekiq/web'
# mount Sidekiq::Web => '/sidekiq'
```

## Project Structure

```
app/
├── controllers/
│   ├── api/v1/           # API controllers
│   │   ├── auth/         # Authentication controllers
│   │   └── base_controller.rb
│   ├── application_controller.rb
│   ├── health_controller.rb
│   └── errors_controller.rb
├── models/
│   └── user.rb
├── serializers/          # JSON API serializers
│   └── user_serializer.rb
└── jobs/                 # Background jobs

config/
├── environments/         # Environment-specific configs
├── initializers/         # App initialization
├── application.rb
├── database.yml
├── routes.rb
└── puma.rb

spec/
├── factories/            # Test data factories
├── models/               # Model tests
├── requests/            # Request/integration tests
└── support/             # Test helpers

db/
└── migrate/             # Database migrations
```

## Environment Variables

Key environment variables (see `.env.example` for complete list):

- `DATABASE_URL` - PostgreSQL connection string
- `REDIS_URL` - Redis connection string
- `DEVISE_JWT_SECRET_KEY` - JWT signing secret
- `CORS_ORIGINS` - Allowed CORS origins
- `SENTRY_DSN` - Error tracking (optional)

## Deployment

### Heroku

1. Create Heroku app
2. Add PostgreSQL and Redis addons
3. Set environment variables
4. Deploy:

```bash
git push heroku main
heroku run rails db:migrate
```

### Docker Production

```bash
docker build -t {{project_name}} .
docker run -p 3000:3000 {{project_name}}
```

## Development Tools

- **Rails Console**: `rails console`
- **Database Console**: `rails db:console`
- **Routes**: `rails routes`
- **Annotations**: `bundle exec annotate` (adds schema info to models)

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Write tests for your changes
4. Ensure all tests pass: `rspec`
5. Run code quality checks: `rubocop`
6. Create a pull request

## License

This project is licensed under the MIT License.