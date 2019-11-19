'use strict';

const router = require("express").Router();
const { shoppingListController } = require('../controllers');

router.post('/shoppingList', async (req, res) => {
    try {
        const shoppingList = await shoppingListController.create(req.body);
        res.status(201).send(shoppingList);
    } catch (error) {
        console.log(error.message);
        res.status(400).send(error);
    }
});

router.get('/shoppingList', async (req, res) => {
    try {
        const shoppingLists = await shoppingListController.list(req.user.id);
        res.status(200).send(shoppingLists);
    } catch (error) {
        res.status(400).send(error.message);
    }
});

router.get('/shoppingList/:shoppingListId', async (req, res) => {
    const shoppingListId = req.params.shoppingListId;
    try {
        const userShoppingList = await shoppingListController.retrieve(shoppingListId, req.user.id);
        res.status(200).send(userShoppingList);
    } catch (error) {
        console.log(error.message);
        res.status(400).send(error.message);
    }
});

module.exports = router;
