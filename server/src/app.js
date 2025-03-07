const forceUpdate = true;
const port = process.env.PORT || 3000;


const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const passport = require('passport');


// Set up the express app
const app = express();
const routes = require('./routes/index');

// Log requests to the console.
app.use(logger('dev'));

// Parse incoming requests data (https://github.com/expressjs/body-parser)
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Authentication
require('./auth/passport');

app.use(passport.initialize());

// Require our routes into the application.
app.use('/', routes);

// Setup a default catch-all route that sends back a welcome message in JSON format.
app.get('*', (_, res) => res.status(200).send({
  message: 'Welcome to the beginning of nothingness.',
}));


const db = require('./models/index');

// Database update and connection
if (forceUpdate) {
  db.sequelize.sync({ force: true }).then(() => {
    app.listen(port, () => {
      // eslint-disable-next-line
      console.log(`Server running at http://localhost:${port}/`);
    });
  });
} else {
  app.listen(port, () => {
    // eslint-disable-next-line
    console.log(`Server running at http://localhost:${port}/`);
  });
}

module.exports = app;


