import mysql from 'mysql'

const Connect = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user: 'beauty_schedule',
    password: 'db264080db', 
    database: 'mundial-hub'
})

export default Connect