'use strict';

const router = require('express').Router();
const jwt = require('jsonwebtoken');
const passport = require('passport');
const {JWT_SECRET} = require('../config/configs');


router.post('/signup', async (req, res) => {
  passport.authenticate('signup', { session: false }, async (err, user, info) => {
    if (!user && info) {
      return res.status(400).json({ message: info.message });
    }

    if (!user) return res.status(400).send();

    // eslint-disable-next-line
    delete user.dataValues.password;
    // eslint-disable-next-line
    delete user._previousDataValues.password;

    return req.login(user, { session: false }, async () => {
      const body = {
        id: user.id, email: user.email, name: user.name, uuid: user.useruuid, balance: user.balance, username: user.username, totalspent: user.totalspent
      };
      const token = jwt.sign({ user: body }, JWT_SECRET);

      return res.json({
        message: 'Signup successful',
        user,
        token,
      });
    });
  })(req, res);
});


router.post('/login', async (req, res, next) => {
  const { password } = req.body;
  passport.authenticate('login', async (err, user, info) => {
    try {
      if (!user && info) {
        return res.status(400).json({ message: info.message });
      }

      if (!user) return res.status(400).send();

      req.login(user, { session: false }, async (error) => {
        if (error) return next(error);

        const body = {
          // eslint-disable-next-line
          id: user.id, email: user.email, name: user.name, uuid: user.useruuid, balance: user.balance, username: user.username, totalspent: user.totalspent
        };
        const token = jwt.sign({ user: body }, JWT_SECRET);

        return res.json({ token });
      });
      return next();
    } catch (error) {
      return next(error);
    }
  })(req, res, next);
});


module.exports = router;