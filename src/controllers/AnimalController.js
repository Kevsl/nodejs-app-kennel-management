const { pool } = require('../services/mysql')
const express = require('express')
const path = require('path')
const multer = require('multer')
const app = express()
const uploadDirectory = path.join(__dirname, 'uploads')

app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')

const insertAnimal = async (req, res) => {
  let storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, uploadDirectory)
    },
    filename: function (req, file, cb) {
      cb(null, `${file.fieldname}-${Date.now()}.jpg`)
    },
  })

  const maxSize = 3 * 1000 * 1000

  let upload = multer({
    storage: storage,
    limits: { fileSize: maxSize },
    fileFilter: function (req, file, cb) {
      var filetypes = /jpeg|jpg|png/
      var mimetype = filetypes.test(file.mimetype)

      var extname = filetypes.test(
        path.extname(file.originalname).toLowerCase()
      )

      if (mimetype && extname) {
        return cb(null, true)
      }

      cb(
        'Error: File upload only supports the ' +
          'following filetypes - ' +
          filetypes
      )
    },
  }).single('image')

  upload(req, res, function (err) {
    if (err) {
      res.send(err)
    } else {
      res.send('Success, Image uploaded!')
    }
  })

  //   try {
  //     const sql = `SELECT * FROM category`
  //     const [result] = await pool.query(sql)

  //     res.status(200).json({ result })
  //     return
  //   } catch (error) {
  //     console.log(error.stack)
  //     res.status(500).json({ message: 'Erreur serveur' })
  //   }
}

module.exports = { insertAnimal }
