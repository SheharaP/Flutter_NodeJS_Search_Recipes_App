const mongoose = require('mongoose');

const data = require('../databse/mongo');

const recipeSchema = new mongoose.Schema({
    name: String,
    ingredients: [String]
})

const recipeModel = new mongoose.model('recipes', recipeSchema);

module.exports = recipeModel;