const express = require('express')
const { getAllCategories } = require('../CategoryController')
const router = express.Router()

router.get('/all', getAllCategories)

module.exports = router
