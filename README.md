# MySMS Messenger

MySMS Messenger is a web application that allows users to send and receive SMS messages. 
The frontend of the app is built using AngularJS, and the backend API is developed with Ruby on Rails. 

You can access the live demo of MySMS Messenge [here.](https://mysms-messenger-demo-b638be784944.herokuapp.com/)

## Features

- Send SMS messages through the app.
- Messages are stored in a database managed by the backend.
- View previously sent messages through a dedicated API endpoint.
- Authentication for user sessions (Bonus 1).
- Deployment of the app to a live demo (Bonus 3).

## Getting Started

### Prerequisites

- Ruby version: ruby 3.0.6
- Database: PostgreSQL

### Installation

# Install Ruby gems
bundle install

# Create and migrate the database
rails db:create

rails db:migrate

rails server
