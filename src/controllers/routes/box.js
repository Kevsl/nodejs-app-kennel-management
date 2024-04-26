const express = require('express')
const { getAllBoxs } = require('../BoxController')
const router = express.Router()

router.get('/all', getAllBoxs)

module.exports = router
