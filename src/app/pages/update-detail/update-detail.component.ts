import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ApiCallService } from 'src/app/api-call.service';
import { ToastrService } from 'ngx-toastr';
//import { UpdateRecords } from 'src/app/models/update-records';
import { userRecords } from 'src/app/models/customer-detail';

import { EditRecord } from 'src/app/models/customer-detail';

@Component({
  selector: 'app-update-detail',
  templateUrl: './update-detail.component.html',
  styleUrls: ['./update-detail.component.css']
})
export class UpdateDetailComponent implements OnInit {

  

  public editdetail: EditRecord = {
                                    initiatedUser:"localStorage.getItem('username')", 
                                    pkey:"", 
                                    customer:"", 
                                    user:"",  
                                    phonenumber:"" ,
                                    key:"",
                                    operationSite:"COSMO"
                                  }                                     


  constructor(private apicall: ApiCallService, private toast: ToastrService,private router: Router) { }

  ngOnInit(): void {
  //this.apicall.getDetailById(keydata: String).subscribe(result => {
  //this.editdetail = result;
  //this.cont = result.Connectivity;
//})



  }

  onSave(){
   // this.updateEmployee.Connectivity = this.cont;

    // this.editdetail.pkey=
    this.apicall.updateDetails(this.editdetail).subscribe((apidata:userRecords)=>{
      console.log("Status: " + apidata.status);
      if (apidata.status == 'OK') {
        this.toast.warning("Data updated Sucessfuly");
        this.router.navigateByUrl('/main/customer-list');
       }
      else{
       this.toast.error("Sorry! update failed");
       this.router.navigateByUrl('/main/customer-list');
      }
    })

    

  }

  onCancel() {
    this.router.navigateByUrl('/main/customer-list');
  }

}
