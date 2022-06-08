import { format } from "date-fns"
import { app } from "./app"
import { prismaClient } from "./database/prismaClient"


const port = 5001
const startDate = format(new Date(), 'hh:mm:ss dd/MM/yyyy')

async function main(){

    try {
        
        const database = await prismaClient.$connect()
        .then(() => console.log('Prisma conectado'))
        app.listen(port, () => {
            console.log(`${startDate} - servidor iniciando na porta ${port}`)
        })
        
    } catch (err) {
        
        throw new Error('erro ao iniciar o servidor')
    }

}