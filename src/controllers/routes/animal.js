const express = require('express')
const { insertAnimal } = require('../AnimalController')
const router = express.Router()

router.post('/insert', insertAnimal)

module.exports = router
