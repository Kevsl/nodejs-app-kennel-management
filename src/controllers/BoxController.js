const { pool } = require('../services/mysql')

const getAllBoxs = async (req, res) => {
  try {
    const sql = `SELECT * FROM  box`
    const [result] = await pool.query(sql)

    res.status(200).json({ result })
    return
  } catch (error) {
    console.log(error.stack)
    res.status(500).json({ message: 'Erreur serveur' })
  }
}

module.exports = { getAllBoxs }
