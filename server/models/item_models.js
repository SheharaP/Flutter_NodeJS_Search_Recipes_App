const mongoose = require('mongoose');

const data = require('../databse/mongo');

const itemSchema = new mongoose.Schema({
    name: String,
    category: [String]
})

const itemModel = new mongoose.model('ingredients', itemSchema);

module.exports = itemModel;