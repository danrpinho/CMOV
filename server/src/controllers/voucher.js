'use strict';

const { Voucher, User } = require('../models');

const list = async (userId) => {
    const vouchers =  await Voucher
        .findAll({
            where: { userId: userId },
        });
    const user = await User.findByPk(userId);
    return {vouchers, user};
};


module.exports = {
    list,
};