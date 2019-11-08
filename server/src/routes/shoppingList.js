'use strict';

const router = require("express").Router();
const {shoppingListController} = require('../controllers');

router.post('/shoppingList', async (req, res) => {

    try {
        const shoppingList = await shoppingListController.create(req);
        res.status(201).send(todo);
    } catch (error) {
        res.status(400).send(error)
    }
});

router.get('/shoppingList', async (req , res) => {
    try {
        const shoppingLists = await shoppingListController.list(req.user.id);
        res.status(201).send(shoppingLists);
    } catch (error) {
        res.status(400).send(error.message)
    }
});

router.get('/shoppingList/:shoppingListId', async (req, res) => {
    const shoppingListId = req.params.shoppingListId;
    try {
        const userShoppingList = await shoppingListController.retrieve(shoppingListId,req.user.id);
        res.status(201).send(userShoppingList);
    } catch (error) {
        res.status(400).send(error.message)
    }
});

module.exports = router;
