'use strict';

const router = require('express').Router();
const jwt = require('jsonwebtoken');
const passport = require('passport');
const { User } = require('../models');
const { JWT_SECRET } = require('../config/configs');
const supermarketPublicKey = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAMFIO7hof0lI57WrB071vXXaBlR21AvpNIRgs5Ej0l8Y4He7zqzz9Yr9eHqgEsBGA5UAe5F23jOWs8zoNTWCnRECAwEAAQ==";



router.post('/signup', async (req, res) => {
  console.log(req.body);
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
        id: user.id, email: user.email, name: user.name, uuid: user.uuid, balance: user.balance, username: user.username, totalSpent: user.totalSpent
      };
      const token = jwt.sign({ user: body }, JWT_SECRET);

      return res.json({
        message: 'Signup successful',
        user,
        token,
        supermarketPublicKey,
      });
    });
  })(req, res);
});


router.post('/login', async (req, res, next) => {
  const {publickey,username,password} = req.body;
  let user = await User.findOne({
    where: { username },
  });
  user = await user.update({ publickey: publickey });
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
          id: user.id, email: user.email, name: user.name, uuid: user.uuid, balance: user.balance, username: user.username, totalSpent: user.totalSpent, supermarketPublicKey: supermarketPublicKey
        };
        const token = jwt.sign({ user: body }, JWT_SECRET);

        return res.json({
          message: 'Login successful',
          user,
          token,
          supermarketPublicKey,
        });
      });
      return next();
    } catch (error) {
      return next(error);
    }
  })(req, res, next);
});


module.exports = router;