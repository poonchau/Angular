import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import {ApiCallService} from './api-call.service';

@Injectable({
  providedIn: 'root'
})
export class PageguardGuard implements CanActivate {
  
  constructor(private apiCall:ApiCallService,private pageroute:Router) { }

  canActivate():boolean
  {
   if(this.apiCall.isloggedIn())
   {
      return true;
   }
   else
   {
     this.pageroute.navigate(['']);
     return false;
   } 

  }
    
}
  

