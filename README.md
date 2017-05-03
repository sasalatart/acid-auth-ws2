# Web Service 2: Validation

[![Code Climate](https://codeclimate.com/github/sasalatart/acid-auth-ws2/badges/gpa.svg)](https://codeclimate.com/github/sasalatart/acid-auth-ws2)

> https://acid-auth-ws2.herokuapp.com/

## About

This application validates the match between an Acid user's login email and biometric picture.

## Technologies Used

- Application Framework: [Ruby on Rails 5.1](http://rubyonrails.org/)
- Database: [PostgreSQL](https://www.postgresql.org/)
- e-mail API: [Mailgun](https://www.mailgun.com/)
- Testing: [RSpec](http://rspec.info/)

## API

#### Verify A User's Credentials

Verifies if the submitted email and base64 encoded image match (10% failure chance simulated).

- **URL:**

  `POST /verify_user/:email`

- **URL Params**
  - **email**: The user's email.

- **Data Params**
  - **image**: The user's base64 encoded image.

- **Success Response:**
  - **Status:** 200
  - **Example content:**
  ```javascript
    {
      message: 'OK'
    }
  ```

- **Error Response:**
  - **Status:** 401
  - **Content:**
  ```javascript
    {
      message: 'No Autorizado'
    }
  ```

- **Sample Call:**

  ```javascript
    $.post({
      url: '/verify_user/an-email',
      data: { image: 'base64-image' }
    }).done(function(response) {
      console.log(response);
    }).fail(function(response) {
      console.log(response);
    });
  });
  ```

#### Users Index Page

Shows the paginated list of users.

- **URL:** `GET /`

- **Query String**

  - **page=[integer]**, user pagination index

#### New User Page

Shows the form for submitting new users.

- **URL:** `GET /users/new`

#### Create User

Creates a new user.

- **URL:** `POST /users`

- **Data Params**
  - **email**: The user's email.
  - **image**: The user's base64 encoded image.

#### Edit User Page

Shows the form for editing a specific user.

- **URL:** `GET /users/:id/edit`

- **URL Params**
  - **id:** The `id` of the user to edit.

#### Update User

Updates a user's base64 image.

- **URL:** `PUT /users/:id`

- **URL Params**
  - **id:** The `id` of the user to update.

- **Data Params**
  - **image**: The user's new base64 encoded image.

#### Delete User

Deletes a user from the database.

- **URL:** `DELETE /users/:id`

- **URL Params**
  - **id:** The `id` of the user to update.

## Development Setup

1. Clone and cd into this repository.
2. Make sure to have the following environment variables set up:

  - `MAILGUN_API_KEY`: your-mailgun-api-key
  - `MAILGUN_DOMAIN`: your-mailgun-domain

  For example:

  ```sh
  $ export MAILGUN_API_KEY=your-mailgun-api-key
  $ export MAILGUN_DOMAIN=your-mailgun-domain
  ```

3. Run `bundle install`
4. Turn on your PostgreSQL server
5. Run rake db:reset
6. Run `rails s`
7. The application should now be listening on `localhost:3000`.

## Run Test Suite

1. Make sure to prepare the database by running `rake db:test:prepare`
2. Run `rspec spec`
