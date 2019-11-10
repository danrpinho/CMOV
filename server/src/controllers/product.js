'use strict';

const { Product } = require('../models');

const create = async (price, uuid, shoppingListId) => {
    return await Product
        .create({
            price,
            uuid,
            shoppingListId
        })
};

module.exports = {
    create,
};