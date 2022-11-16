const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/recipedb',
    { 
        useNewUrlParser: true, 
        useUnifiedTopology: true 
    }
).then(() => {
    console.log('DB connected');
}).catch((error)=> {
    console.log('Error connecting to database', error);
})



// const data = async () => {
//     const result = await itemModel.find();
//     console.log(...result);
// }

// module.exports = data();

