'use strict';

const router = require("express").Router();
const { voucherController } = require('../controllers');


router.get('/vouchers', async (req, res) => {
    try {
        const vouchers = await voucherController.list(req.user.id);
        res.status(201).send(vouchers);
    } catch (error) {
        res.status(400).send(error.message)
    }
});

module.exports = router;