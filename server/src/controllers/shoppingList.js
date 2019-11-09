'use strict';

const { Product, ShoppingList, User, Voucher } = require('../models');
const VOUCHER_DISCOUNT = 0.15;



const create = async (body) => {

    console.log(body);
    const {products,uuid,voucherId,discount} = body;
    if (!Array.isArray(products) || products.length === 0)
        throw new Error("You sent an empty array of products");


    //FIND USER
    let user = await User.findOne({ where: { uuid: uuid } });
    console.log(user.id);
    if (user === null || user === undefined)
        throw new Error("Not a valid uuid");
    

    //Create SHOPPING LIST
    let totalPrice = 0;
    
    let shoppingList = await ShoppingList.create({userId: user.id});
    
    
    products.forEach(product => {
        totalPrice += product.price;
        console.log(totalPrice);

        const price = product.price, uuid = product.uuid, shoppingListId = shoppingList.id;
        Product.create({ uuid: uuid, price: price, shoppingListId: shoppingListId});
    });
    
    shoppingList = await shoppingList.update({ totalCost: totalPrice });
    console.log(shoppingList);
    console.log("chego aqui");
    //VOUCHERS
    if (voucherId !== null) {
        voucher = await Voucher.findByPk(voucherId, { where: { uuid: uuid } });
        if (voucher !== null && voucher !== undefined) {
            const newBalance = totalPrice * VOUCHER_DISCOUNT
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
            user = await user.update({ balance: 0 });
            discounted = totalPrice - user.balance;
        }

        shoppingList.discounted = discounted;
        await shoppingList.update({ discounted: discounted });
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
