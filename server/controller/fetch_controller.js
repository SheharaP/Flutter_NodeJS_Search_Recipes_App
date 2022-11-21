
class fetchController {

    constructor(p){
        this.item  = (p && p.item);
    }

    data = async (req, res) => {

        try{
            console.log(this.item);
            const result = await (this.item).find({});
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
