import { Business } from "../../entities/Business/Business";

export type FindBusinessParameter = { id?: string } | { name?: string }

export interface IBusinessRepository {
    find(findBusinessParameter: FindBusinessParameter): Promise<Business>;
    save(business: Business): { id: string };
}