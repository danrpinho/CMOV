'use strict';

const {Voucher} = require('../models');

const list = async (userId) => {
    return await Voucher
        .findAll({
            where: { userId: userId },
        });
};

/*const create = async (content, todoId) => {
    return await TodoItem
        .create({
            content,
            todoId
        })
};

const update = async (id, todoId, content, complete) => {
    let todoItem = await TodoItem
        .findOne({
            where: {
                id,
                todoId,
            },
        });

    if (!todoItem) {
        throw new Error("TodoItem not found");
    }

    return await todoItem
        .update({
            content,
            complete,
        })
};
*/
module.exports = {
    //create,
    list,
    //update
};