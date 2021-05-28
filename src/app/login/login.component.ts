import { Component, OnInit } from '@angular/core';
import {ApiCallService} from '../api-call.service';
import { FormGroup,FormControl } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Router, ActivatedRoute } from '@angular/router';
import { UserData } from '../models/usermodel';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {

  userData = new FormGroup({
     userName: new FormControl(''),
      userPassword: new FormControl(''),
  })

  constructor(private callApi:ApiCallService,private toast:ToastrService,private callPage:Router) { }

  ngOnInit(): void {
     localStorage.removeItem('username');
     localStorage.removeItem('role');
     localStorage.removeItem('userToken');
  }

  onSubmit()
  {
    this.callApi.validateUser(this.userData.value).subscribe((apidata:UserData)=>{
      //console.log("STATUS" + apidata.status);
     // console.log("MESSAGE " + apidata.message);
      //console.log("PKEY " + apidata.pkey);
      console.log("LoginUser " + apidata.userName);
      if(apidata.status == 'OK')
      {
        //localStorage.removeItem("userdata");
        //localStorage.setItem('userName',apidata.UserName);
        localStorage.setItem('role',apidata.Role);
        localStorage.setItem('userToken',apidata.token);
        
        localStorage.setItem('username',apidata.userName);
        //localStorage.setItem('initiatedBy',apidata.initiatedUser);
        localStorage.setItem('PrimaryKey',apidata.pkey);
        //localStorage.setItem('operation',apidata.operationSite);


        this.toast.success("Successfully logged Into Portal");
        this.callPage.navigateByUrl("/main/addcustomer");

      }
      else
      {
        this.toast.error("Opps! Login Failed", "Login");
      }    
    })
  
  }
}
