'use strict';

const { Product, ShoppingList, User, Voucher } = require('../models');
const VOUCHER_DISCOUNT = 0.15;



const create = async (body) => {

    const { products, uuid, voucherId, discount } = body;

    if (!Array.isArray(products) || products.length === 0)
        throw new Error("You sent an empty array of products");


    //FIND USER
    let user = await User.findOne({ where: { uuid: uuid } });
    if (user === null || user === undefined)
        throw new Error("Not a valid uuid");


    //Create SHOPPING LIST
    let totalPrice = 0;

    let shoppingList = await ShoppingList.create({ userId: user.id });


    products.forEach(product => {
        totalPrice += product.price;
        const price = product.price, uuid = product.uuid, shoppingListId = shoppingList.id;
        Product.create({ uuid: uuid, price: price, shoppingListId: shoppingListId });
    });

    shoppingList = await shoppingList.update({ totalCost: totalPrice });


    //VOUCHERS
    if (voucherId !== null && voucherId !==0) {
        let voucher = await Voucher.findByPk(voucherId);
        if (voucher !== null && voucher !== undefined && !voucher.used && voucher.userId === user.id) {
            let newBalance = totalPrice * VOUCHER_DISCOUNT;
            user = await user.update({ balance: newBalance });
            voucher = await voucher.update({ used: true });
        }

    }

    //DISCOUNT

    if (discount) {
        let discounted = 0;
        if (user.balance > totalPrice) {
            const newBalance = user.balance - totalPrice;
            user = await user.update({ balance: newBalance });
            discounted = totalPrice;
        } else {
            discounted = user.balance;
            user = await user.update({ balance: 0 });
        }

        shoppingList.discounted = discounted;
        await shoppingList.update({ discounted: discounted });
    }

    //CREATE VOUCHERS

    let oldSpent = user.totalSpent;
    let totalSpent = user.totalSpent + totalPrice;
    user = await user.update({ totalSpent: totalSpent });
    let totalMinusOldpercent = Math.floor(totalSpent / 100.0) - Math.floor(oldSpent / 100.0);
    console.log(Math.floor(oldSpent / 100.0))
    console.log(totalMinusOldpercent);

    if (totalMinusOldpercent > 0)
        for (let i = 0; i < totalMinusOldpercent; i++)
            Voucher.create({ userId: user.id });
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
