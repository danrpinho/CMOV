'use strict';

const router = require("express").Router();

/*+++++++++++++++++++++++++++++++++++++++++++++
 Routes
 ++++++++++++++++++++++++++++++++++++++++++++++*/

const auth = require("./auth");
const shoppingList = require("./shoppingList");
const voucher = require("./voucher");
const passport = require('passport');


router.use("/", auth);

//shopping list create won't need authentication
router.get('/api/shoppingList', passport.authenticate('jwt', { session: false }));
router.get('/api/shoppingList/*', passport.authenticate('jwt', { session: false }));
router.use("/api/", shoppingList);


router.use("/api/voucher", passport.authenticate('jwt', { session: false }));
router.use("/api/", voucher);

router.get('/api', (req, res) => res.status(200).send({
    message: 'Welcome to the Supermarket API!',
}));


module.exports = router;
