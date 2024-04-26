const { pool } = require('../services/mysql')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
require('dotenv').config()

const register = async (req, res) => {
  if (
    !req.body.email ||
    !req.body.password ||
    !req.body.name ||
    !req.body.adress ||
    !req.body.phone
  ) {
    res.status(400).json({ error: 'missing fields' })
    return
  }
  let email = req.body.email
  let password = req.body.password
  let name = req.body.name
  let phone = req.body.phone
  let adress = req.body.adress

  try {
    const values = [email]
    const sql = `SELECT email_client FROM client WHERE email_client =  ?`
    const [result] = await pool.execute(sql, values)
    if (result.length !== 0) {
      res.status(400).json({ error: 'Invalid credentials' })
      return
    } else {
      const hash = await bcrypt.hash(password, 10)

      const sqlInsertRequest =
        'INSERT INTO `client` VALUES (NULL, ?, ?, ?,?, ?)'

      const insertValues = [name, phone, adress, email, hash]

      const [rows] = await pool.execute(sqlInsertRequest, insertValues)

      if (rows.affectedRows > 0) {
        res.status(201).json({ success: 'registration successfull' })
        return
      } else {
        res.status(500).json({ error: 'registration failed.' })
        return
      }
    }
  } catch (error) {
    console.log(error.stack)
    res.status(500).json({ message: 'Erreur serveur' })
    return
  }
}

const login = async (req, res) => {
  if (!req.body.identifier || !req.body.password) {
    res.status(400).json({ error: 'missing fields' })
    return
  }
  let identifier = req.body.identifier
  let password = req.body.password

  try {
    const values = [identifier, identifier]
    const sql = `SELECT * FROM client INNER JOIN role ON client.id_role = role.id_role WHERE email_client =  ? OR name_client = ?`
    const [result] = await pool.query(sql, values)

    if (result.length === 0) {
      res.status(401).json({ error: 'Invalid credentials' })
      return
    } else {
      await bcrypt.compare(
        password,
        result[0].password_client,
        function (err, bcyrptresult) {
          if (err) {
            res.status(401).json({ error: 'Invalid credentials' })
            return
          }

          const token = jwt.sign(
            {
              email: result[0].email_client,
              id: result[0].id_client,
            },
            process.env.MY_SUPER_SECRET_KEY,
            { expiresIn: '20d' }
          )
          console.log()
          res.status(200).json({ jwt: token, role: result[0].name_role })
          return
        }
      )
    }
  } catch (error) {
    console.log(error.stack)
    res.status(500).json({ message: 'Erreur serveur' })
  }
}

const getAllUsers = async (req, res) => {
  try {
    const sql = `SELECT id_client,name_client  FROM  client`
    const [result] = await pool.query(sql)

    res.status(200).json({ result })
    return
  } catch (error) {
    console.log(error.stack)
    res.status(500).json({ message: 'Erreur serveur' })
  }
}

module.exports = { register, login, getAllUsers }
