# Enterprise Forecast App

## Pre-requisites

You will need to create a `.env` file for both the `/api` and `/frontend` directories. Please reference the sample .env files inside of `/documents`.

- Docker

## Getting Started

You will need to build and start the docker services.

1. Build services
```bash
docker-compose build
```

2. Run services in bg
```bash
docker-compose up -d
```

## Usage

The project is separated into two main parts:
- Frontend
- API

Head to `http://localhost:4000` on your machine to access the local frontend.

The API lives in `http://localhost:3000`.

You can make networks requests to the API from the frontend or through an API testing tool like Postman.
