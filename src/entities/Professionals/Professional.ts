import { uuid } from "uuidv4"

export class Professional {

    public readonly id: string

    name: string
    email: string
    password: string
    profession?: string
    modified: Date
    created: Date

    constructor(props: Omit< Professional, 'id'>, id?: string){

        Object.assign(this, props)

        if(!id){
            this.id = uuid()
        }

    }
}