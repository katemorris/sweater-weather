# Sweater Weather

## Table of Contents

  - [What it does](#what-it-does)
  - [Technology](#technology)
  - [How to Install](#how-to-install)
  - [Schema](#schema)
  - [Endpoints](#endpoints)
  - [Contributors](#contributors)
  - [Acknowledgments](#acknowledgments)

## What It Does

An API that serves the Sweater Weather App, which allows users to plan a road trip and show what kind of weather to expect at a specific location.

## Technology

This app is built on Rails 5.2 with support from:
- Faraday
- Fastjsonapi
- Figaro
- BCrypt
- Email validator
- and a host of testing gems

External APIs used include MapQuest, Flickr, and OpenWeather.

## How to Install

To install and run this application locally:

1. To setup the repository locally, clone it down and run the following commands:
```
$ bundle install
$ rails db:{create,migrate,seed}
```

2. Next, startup your server with the `$ rails server` command

3. You should now be able to open your web browser, navigate to `http://localhost:3000/` and see the Rails default information page.

4. From here, you are free to hit any of the api endpoints listed below. The URL should be prefixed with your localhost port like this `GET http://localhost:3000/api/v1/forecast?location=denver,co`

5. To run our test suite, run `bundle exec rspec` in your terminal. **As of 1/15/2021, this app is at 100% test coverage.**

## Schema

The only data stored is user data. There are no relational tables.

## Endpoints:

### Forecast
```
Given a city state, this returns the current weather, 5 day, and 8 hour forecast data.

GET /api/v1/forecast?location=city,st
```
```json
Default response

{
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-01-18T13:16:20.000-07:00",
                "sunrise": "2021-01-18T07:49:34.000-07:00",
                "sunset": "2021-01-18T17:52:15.000-07:00",
                "temperature": 66.34,
                "feels_like": 50.61,
                "humidity": 14,
                "uvi": 2.52,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01d"
            },
            "daily_weather": [
                {
                    "date": "2021-01-18",
                    "sunrise": "2021-01-18T07:49:34.000-07:00",
                    "sunset": "2021-01-18T17:52:15.000-07:00",
                    "max_temp": 66.63,
                    "min_temp": 47.28,
                    "conditions": "clear sky",
                    "icon": "01d"
                }],
                "hourly_weather": [
                {
                    "time": "13:00",
                    "temperature": 66.34,
                    "wind_speed": "15.57",
                    "wind_direction": "N",
                    "conditions": "clear sky",
                    "icon": "01d"
                }
              ]
            }
          }
        }  
```

[See an image of this live in Postman](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/forecast-response.png)
[Close to full response from Postman](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/forecast-full.png)

### Background Image
```
Given a city, state input, returns an image to be used as a background.

GET /api/v1/backgrounds?location=denver,co
```

```json
Default response

{
    "data": {
        "id": "null",
        "type": "image",
        "attributes": {
            "image": {
                "image_url": "https://live.staticflickr.com/65535/50848470373_347662d90d.jpg",
                "location": "las vegas, nv",
                "credit": {
                    "author": "dougsandquist",
                    "url": "https://www.flickr.com/photos/dougandmisti/"
                }
            }
        }
    }
}
```

[See this on Postman](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/background.png)


### User Creation
```
List all games for a specific user.

POST /api/v1/users/
```
```json
Raw JSON request body

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
```json
Default response

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
[See an image of this live in Postman](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/users-new.png)
[Duplicate warning example](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/users-duplicate.png)

### Create Session
```
Authorize a session for a user

POST /api/v1/sessions
```
```json
Raw JSON request body

{
  "email": "whatever@example.com",
  "password": "password"
}
```
```json
Default response

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
[See this on Postman](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/sessions.png)

### Road Tip
```
Returns weather and time to destination from a starting point.

POST /api/v1/road_trip
```
```json
Raw JSON request body

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
```json
Default response

{
  "data": {
    "id": "null",
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes",
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```
[See this on Postman](https://raw.githubusercontent.com/katemorris/sweater-weather/main/images/road-trip.png)

## Contributors
- Kate Tester - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/katemorris/) - [![GitHub][github-shield]](https://github.com/katemorris)

## Acknowledgments

This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.

<!-- MARKDOWN LINKS & IMAGES -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[github-shield]: https://img.shields.io/badge/-GitHub-black.svg?style=flat-square&logo=github&colorB=555
