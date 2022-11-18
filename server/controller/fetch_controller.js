const itemModel = require('../models/item_models');


class fetchController {

    static data = async (req, res) => {

        try{
            const result = await itemModel.find();
            //console.log(...result);
            console.log(result);
            res.send(result);
        }
        catch (error){
            console.log(error);
        }
    }
}


module.exports = fetchController;
