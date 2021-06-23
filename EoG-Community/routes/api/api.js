const express = require("express");
const { body } = require('express-validator/check');


const User = require("../../models/user");
const apiController = require('../../controllers/api/api');
const isAuth = require('../../middlewares/isAuth');

const router = express.Router();

router.post("/v1/post", isAuth, apiController.postPublishPost);

router.post('/v1/deletePost', isAuth, apiController.postDeletePost);

router.post("/v1/comment", function (req, res, next) {
    db.comment(
        { username: req.body.author },
        { by: req.session.user, text: req.body.text },
        req.body._id,
        (err, result) => {
            if (result) {
                res.send(true);
            } else {
                res.send(false);
            }
        }
    );
});

router.post("/v1/like", apiController.postLike);
router.post("/v1/getLikes", apiController.postLikesCount);

router.post("/v1/addFriend", isAuth, apiController.postAddFriend);



router.get("/v1/search", function (req, res, next) {
    var regx = "^" + req.query.q + ".*";
    User.find({
        $or: [
            { username: { $regex: regx } },
            { firstname: { $regex: regx } },
            { lastname: { $regex: regx } }
        ]
    }).exec((err, all) => {
        return res.send(all);
    });
});



module.exports = router;
