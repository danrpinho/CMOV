'use strict';

const {Product, ShoppingList} = require('../models');

const create = async (totalCost) => {
    return await ShoppingList
        .create({
            totalCost,
        });
        
};

const list = async () => {
    return await ShoppingList
        .findAll({
            include: [{
                model: Product,
                as: 'products',
            }],
        });
};

const retrieve = async (shoppingListID) => {
    return await ShoppingList
        .findByPk(shoppingListID, {
            include: [{
                model: Product,
                as: 'products',
            }],
        });
};


module.exports = {
    create,
    list,
    retrieve,
};
