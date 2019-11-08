'use strict';

const {Product, ShoppingList} = require('../models');

const create = async (totalCost) => {
    return await ShoppingList
        .create({
            totalCost,
        });
        
};

const list = async (userId) => {
    return await ShoppingList
        .findAll({
            where: { userId: userId },
        });
};

const retrieve = async (shoppingListID, userId) => {
    const shoppingList = await ShoppingList
        .findByPk(shoppingListID, {
            include: [{
                model: Product,
                as: 'productItems',
            }],
        });
    
    if(shoppingList.userId!==userId) throw new Error("You're not the user who made this purchase");
    
    return shoppingList
};


module.exports = {
    create,
    list,
    retrieve,
};
