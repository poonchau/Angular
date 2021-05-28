import { Component, OnInit } from '@angular/core';
import{ NgForm} from '@angular/forms';
import { CustomerDetail,userRecords } from 'src/app/models/customer-detail';
import { Router } from '@angular/router';
import { ApiCallService } from 'src/app/api-call.service';
import { ToastrService } from 'ngx-toastr';
//import { UserData } from 'src/app/models/customer-detail';
  



@Component({
  selector: 'app-customer-record',
  templateUrl: './customer-record.component.html',
  styleUrls: ['./customer-record.component.css']
})
export class CustomerRecordComponent implements OnInit {

  public ddata:any = [];
  //public initiatedUser: string;

  //public pkey: string;

  public details: CustomerDetail = 
                                    { 
                                        initiatedUser: localStorage.getItem('username'),
                                        customer:"",
                                        user:"",
                                        phonenumber: "",
                                        key:"",
                                        operationSite:"COSMO",
                                        //pkey: ""
                                        
                                    }

  constructor(private apicall: ApiCallService, private toast: ToastrService,private router: Router) { }

  ngOnInit(): void {
    //console.log("Modified by :",this.details.initiatedUser);
    //console.log("operationSite :",this.details.operationSite);
    //console.log("login_userName:",localStorage.getItem('username'));
    
    this.loadData();


  }

   loadData() {
    this.apicall.getDetails().subscribe((result) => {
      //console.log('Calling API  to get the : BDX Data');
      this.ddata= result;
      console.log(this.ddata);
    },
      (error) => {
        console.log("Could not refresh Data --> " + error);
      }
    );
  }
  

  //  onSubmit(form:NgForm){
  //    console.log(form); 

  


   onSave()
   {
    this.apicall.addDetails(this.details).subscribe((apidata:userRecords)=>{

      
      console.log("status " + apidata.status);
      if(apidata.status == 'OK')
      {
        this.toast.success("Data Added sucessfuly!", "Added!");
        this.router.navigateByUrl('/main/customer-list');
      }
      else
      {
        this.toast.error("Failed while adding data.", "Failed!");
        this.router.navigateByUrl('/main/customer-list');
      }    
    })
  
  }

 onCancel() 
    {
      this.router.navigateByUrl('/main/customer-list');
    }

}
