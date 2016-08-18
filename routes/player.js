var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/:boardId/player/:playerId', function(req, res, next) {
    res.render('player', req.params);
});

module.exports = router;