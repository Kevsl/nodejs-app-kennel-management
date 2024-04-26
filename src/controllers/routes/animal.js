const express = require('express')
const { insertAnimal, insertAnimalPicture } = require('../AnimalController')
const router = express.Router()

router.post('/insert/picture', insertAnimalPicture)
router.post('/insert', insertAnimal)

module.exports = router
