const mongoose = require('mongoose');

const data = require('../databse/mongo');

const itemSchema = new mongoose.Schema({
    name: String,
    category: [String]
})

const itemModel = new mongoose.model('ingredients', itemSchema);

// const data = new itemModel({name : 'Mango', category : ['Fruit']});
// data.save();

// const data2= async() => {
//   const result = await itemModel.insertMany([
//     {name : 'Tomato', category : ['Fruit', 'Vegetable']},
//     {name : 'Chicken', category : ['Poultry']},
// ])
// }
// data2();

module.exports = itemModel;