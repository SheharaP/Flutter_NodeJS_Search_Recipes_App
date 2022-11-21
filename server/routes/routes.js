const express = require('express');

const router = express.Router();

const fetchController = require('../controller/fetch_controller');

const itemModel = require('../models/item_models');
const recipeModel = require('../models/recipe_models');

const items = new fetchController({
    item: itemModel,
});

const recipes = new fetchController({
    item: recipeModel,
});

router.get("/items", items.data);

router.get("/recipes", recipes.data);



module.exports = router;
