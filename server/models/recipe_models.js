const mongoose = require('mongoose');

const data = require('../databse/mongo');

const recipeSchema = new mongoose.Schema({
    name: String,
    ingredients: [String]
})

const recipeModel = new mongoose.model('recipes', recipeSchema);

// const data = new itemModel({name : 'Mango', category : ['Fruit']});
// data.save();

// const data2= async() => {
//   const result = await itemModel.insertMany([
//     {name : 'Tomato', category : ['Fruit', 'Vegetable']},
//     {name : 'Chicken', category : ['Poultry']},
// ])
// }
// data2();

module.exports = recipeModel;