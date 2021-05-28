import { Injectable } from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders,HttpParams } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { Observable, throwError  } from 'rxjs';
import {UserData} from './models/usermodel'
// import { Upload, Status } from './models/Emeamodel';
import { CustomerDetail,userRecords,DeleteRecord } from 'src/app/models/customer-detail';
import { Recordmodel } from './models/recordmodel';


@Injectable({
  providedIn: 'root'
})
export class ApiCallService {  

 
 private loginURL : string = "https://localhost:44357/api/user/login";
 private commoURL  : string = "https://localhost:44357/api/customer/";
  //private url:"";

  //private deleteURL : string = "https://localhost:44357/api/customer/delete";

 // private loginURL : string = "http://59.164.127.75/itcbmi/api/login/validate";
  //private commoURL  : string = "http://59.164.127.75/itcbmi/api/";
  
  constructor(private httpcall:HttpClient) { }

  validateUser(data):Observable<UserData>
  {
    return this.httpcall.post<UserData>(this.loginURL,data);
  }

  isloggedIn()
  {
    return !!localStorage.getItem('userToken');
  }

  addDetails(records:CustomerDetail){
    return this.httpcall.post<any>(this.commoURL + 'create', records);
  }

  getDetails():Observable<CustomerDetail[]>
  {
    return this.httpcall.get<CustomerDetail[]>(this.commoURL+ 'getrecords');
  }

   getDetailById(pid:any):Observable<any> {
     
     return this.httpcall.get<any>(this.commoURL + 'getrecord/',pid );
   }

  
  updateDetails(editdata:any):Observable<any>
  {
    return this.httpcall.post<any>(this.commoURL + 'edit', editdata);
  }

  
 
 
  deleteDetails(data:any):Observable<any>
  { 
    return this.httpcall.post<any>(this.commoURL + 'delete', data);
  }
  

}



