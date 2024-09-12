# Enterprise Forecast App

## Pre-requisites

- Docker

**You will need an API Key to use the third-party weather API**

`https://home.openweathermap.org/api_keys`

**You will also need to a free subscription to get the weather data**

`https://openweathermap.org/price`

## Getting Started

You will need to create a `.env` file for both the `/api` and `/frontend` directories. Please reference the sample .env files inside of `/documents`.

1. Inside of the `/frontend` directory copy and paste the contents of `/documents/.example.frontend.env` and paste them into the new `.env` file.
2. Inside of the `/api` directory copy and paste the contents of `/documents/.example.api.env` and paste them into the new `.env` file.

Build and start the docker services.

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

## Objects

`Forecast`

Used as the core representation of the forecast data.

It contains the following fields

- current
- daily

The `current` field is a jsonb column used to hold json data of the current weather forecast with fields like

- temp
- weather

The `weather` field holds the type/kind of weather like cloudy or sunny.

A similar pattern is used for the `daily` column. Except it provides high/low temperature data.