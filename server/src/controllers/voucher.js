'use strict';

const { Voucher, User } = require('../models');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;
const list = async (userId) => {
    const vouchers = await Voucher
        .findAll({
            where: { [Op.and]: [{ userId: userId }, { used: false }] },
        });
    const user = await User.findByPk(userId);
    return { vouchers, user };
};


module.exports = {
    list,
};