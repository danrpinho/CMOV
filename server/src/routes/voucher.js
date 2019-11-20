'use strict';

const router = require("express").Router();
const { voucherController } = require('../controllers');


router.get('/voucher', async (req, res) => {
    try {
        const vouchers = await voucherController.list(req.user.id);
        res.status(200).send(vouchers);
    } catch (error) {
        console.log(error.message);
        res.status(400).send(error.message);
    }
});

module.exports = router;