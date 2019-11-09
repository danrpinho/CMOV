'use strict';

const { Product, ShoppingList, User, Voucher } = require('../models');
const VOUCHER_DISCOUNT = 0.15;



const create = async ({ products, uuid, voucherId, discount }) => {
    if (!Array.isArray(products) || products.length === 0)
        throw new Error("You sent an empty array of products");


    //FIND USER
    const user = User.findOne({ where: { uuid: uuid } });

    if (user === null || user === undefined)
        throw new Error("Not a valid uuid");


    //Create SHOPPING LIST
    let totalPrice = 0;
    shoppingList = await ShoppingList.create({});


    products.forEach(product => {
        totalPrice += product.price;
        const price = product.price, uuid = product.uuid, shoppingListId = shoppingList.id;
        Product.create({ uuid, price, shoppingListId });
    });

    shoppingList = shoppingList.update({ totalCost: totalPrice });

    //VOUCHERS
    if (voucherId !== null) {
        voucher = await Voucher.findByPk(voucherId, { where: { uuid: uuid } });
        if (voucher !== null && voucher !== undefined) {
            const newBalance = totalPrice * VOUCHER_DISCOUNT
            user = user.update({ balance: newBalance });
            voucher = voucher.update({ used: true });
        }

    }

    //DISCOUNT
    
    if (discount) {
        let discounted = 0;
        if (user.balance > totalPrice) {
            const newBalance = user.balance - totalPrice;
            user = user.update({ balance: newBalance });
            discounted = totalPrice;
        } else {
            user = user.update({ balance: 0 });
            discounted = totalPrice - user.balance;
        }

        shoppingList.discounted = discounted;
        shoppingList.update({ discounted: discounted });
    }

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

    if (shoppingList.userId !== userId) throw new Error("You're not the user who made this purchase");

    return shoppingList
};


module.exports = {
    create,
    list,
    retrieve,
};
