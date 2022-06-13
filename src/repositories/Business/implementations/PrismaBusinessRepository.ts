import { prismaClient } from "../../../database/prismaClient";
import { Business } from "../../../entities/Business/Business";
import { FindBusinessParameter, IBusinessRepository } from "../IBusinessRepository";

export class PrismaBusinessRepository implements IBusinessRepository {

    async find(findBusinessParameter: FindBusinessParameter): Promise<Business> {
     
        const business = await prismaClient.business.findFirst({
            where: findBusinessParameter
        })
        .catch(err => { throw new Error(err) })

        return business
    }

    async save(business: Business): { id: string; } {
        
        const { id } = await prismaClient.business.create({
            data: business
        })

    }

}