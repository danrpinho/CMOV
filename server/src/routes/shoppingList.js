'use strict';

const router = require("express").Router();
const { shoppingListController } = require('../controllers');

router.post('/shoppingList', async (req, res) => {
    try {
        const message = await shoppingListController.create(req.body);
        res.status(201).json({ message: message });
    } catch (error) {
        res.status(400).send(error);
    }
});

router.get('/shoppingList', async (req, res) => {
    try {
        const shoppingLists = await shoppingListController.list(req.user.id);
        console.log(shoppingLists);
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
        res.status(400).send(error.message);
    }
});

module.exports = router;
