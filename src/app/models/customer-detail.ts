//To know the status result from API
export class userRecords {
    status: string;
    message: string;
    
}


//Create/Insert & Read/View  Model
export class CustomerDetail {
    
    initiatedUser: string;
    customer: string;
    user: string;
    phonenumber: string;
    key: string;
    operationSite: string;
    //pkey: string;
}
// update Parameters
export class EditRecord{
    
    initiatedUser: string;
    
    pkey: string;
    
    customer: string;
    
    user:string ;
    
    phonenumber:string  
    
    key:string;
   
    operationSite:string;

}


//Delete Parameters
export class DeleteRecord {

    initiatedUser: string;
    pkey: string;
    operationSite: string;

}


export class LoginData{
    userName: string;
    userPassword: string;

}
