module.exports = (req, res, next) => {
    req.user.getSecurityInfo()
        .then(securityInfo => {
            if(securityInfo.recoveryEmail === null){
                res.redirect('/profilo/info-account');
            }
        })
        .then(result => {
            if(req.user.name === null || req.user.surname === null){
                res.redirect('/profilo/info-profilo');
            }
        })
        .catch(err => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            next(error);
        });

    next();
}