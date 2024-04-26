const express = require('express')
const userRouter = require('./controllers/routes/user')
const categoryRouter = require('./controllers/routes/category')
const boxRouter = require('./controllers/routes/box')
const animalRouter = require('./controllers/routes/animal')

const app = express()
const cors = require('cors')
require('dotenv').config()

app.use(cors())
app.use(express.json())

app.use('/user', userRouter)
app.use('/category', categoryRouter)
app.use('/box', boxRouter)
app.use('/animal', animalRouter)

app.listen(process.env.PORT, () => {
  console.log('im listening on port', process.env.PORT)
})
