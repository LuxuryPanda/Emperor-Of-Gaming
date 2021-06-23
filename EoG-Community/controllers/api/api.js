const crypto = require('crypto');

const bcrypt = require('bcryptjs');
const nodemailer = require('nodemailer');
const { validationResult } = require('express-validator/check');
const { Op } = require('sequelize');

const Post = require('../../models/post');

exports.postPublishPost = (req, res, next) => {
  const postText = req.body.postText;

  req.user.createPost().then(post => {
    post.body = postText;
    post.publicationDate = Date.now();
    post.save();

    return res.redirect('/');
  });
};

exports.postLike = (req, res, next) => {
  var likeType = req.body.likeType;
  var postID = req.body.postID;

  Post.findByPk(postID)
  .then(post => {
    if(!post){
      return res.send({ event: false, msg: "Liked!" });
    }

    post.createLike()
    .then(like => {
      like.type = likeType;
      like.UserUsername = req.user.username;

      like.save()
        .then(result => {
          return res.send({ event: true, msg: "Liked!" });
        });
    });
  })
};

exports.postLikesCount = (req, res, next) => {
  var postID = req.body.postID;

  Post.findByPk(postID)
  .then(post => {
    if(!post){
      return res.send({ event: false, msg: "Liked!" });
    }

    post.countLikes()
    .then(likes => {
        return res.send({ event: true, likes: likes });
    });
  })
};

exports.postDeletePost = (req, res, next) => {
  const postID = req.body.postID;

  Post.findByPk(postID).then(post => {
    if (post.UserUsername !== req.user.username) {
      res.redirect('/');
    }

    return post.destroy();
  })
    .then(result => {
      res.redirect('/');
    })
    .catch(err => {
      const error = new Error(err);
      error.httpStatusCode = 500;
      next(error);
    });
};



exports.postAddFriend = (req, res, next) => {

};