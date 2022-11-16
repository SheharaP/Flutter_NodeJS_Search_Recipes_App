const express = require('express');

const router = express.Router();

const fetchController = require('../controller/fetch_controller');

router.get("/items", fetchController.data);

// router.get("/", async (req, res) => {

//     const result = await data;

//     console.log('this is data parsed', result);
    
//     res.status(200).json({
//         message:  await data,
//     });
// });

router.post("/", async (req, res) => {
    const {name, email} = req.body;

    console.log(name);
    console.log(email);

    res.json({
        message: {
            name,
            email
        },
    });
});

router.get("/about", async (req, res) => {
    res.json({
        message: "This is the about page!",
    });
});

router.get("/profile", async (req, res) => {
    res.json({
        message: "This is the amazing profile page!",
    });
});

module.exports = router;
