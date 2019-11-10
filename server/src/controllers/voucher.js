'use strict';

const { Voucher } = require('../models');

const list = async (userId) => {
    return await Voucher
        .findAll({
            where: { userId: userId },
        });
};


module.exports = {
    list,
};