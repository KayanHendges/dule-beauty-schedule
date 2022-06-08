import { Business } from "../../entities/Business/Business";

type FindParameter = { id?: string } | { email?: string }

export interface IBusinessRepository {
    find(FindParameter: FindParameter): Business;
    save(business: Business): { id: string };
}