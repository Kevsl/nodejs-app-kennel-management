const express = require('express')
const { register, login, getAllUsers, testEmail } = require('../UserController')
const router = express.Router()

router.post('/register', register)
router.post('/login', login)
router.get('/all', getAllUsers)
router.get('/email', testEmail)

module.exports = router
