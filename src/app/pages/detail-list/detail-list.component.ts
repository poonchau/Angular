import { Component, OnInit } from '@angular/core';
import { CustomerDetail,userRecords,DeleteRecord, EditRecord } from 'src/app/models/customer-detail';
import { Router } from '@angular/router';
import { Subject, Observable } from 'rxjs';
import { ApiCallService } from 'src/app/api-call.service';
import { ToastrService } from 'ngx-toastr';
import { strict } from 'assert';

@Component({
  selector: 'app-detail-list',
  templateUrl: './detail-list.component.html',
  styleUrls: ['./detail-list.component.css']
})
export class DetailListComponent implements OnInit {
 
  public customerList: CustomerDetail[];

  public editdetail:EditRecord[];

  

  public sendpkey:string;

 // public sendrecord: DeleteRecord[];



   public record: userRecords = { status:"", 
                                  message:""
                                        
                                }


                       

    public sendrecord: DeleteRecord=
                      { 
                                 initiatedUser:localStorage.getItem('username'),
                                 pkey:"",
                                 operationSite:"COSMO",

                               }

  //  public initiatedUser: string;
    //public  pkey: string;
  //  public  operationSite: string     
  
  
  

 dtOption: DataTables.Settings = {};
 dtTriger: Subject<any> = new Subject();

 constructor(private apicall: ApiCallService, private toast: ToastrService,private router: Router) { }

  ngOnInit(): void {
    this.dtOption = {
      pagingType: 'full_numbers',
      pageLength: 5,
      autoWidth: true,
      order: [[1, 'desc']]
  };
  // this.empID = localStorage.getItem('UserName');
  //this.sendrecord.pkey = pkey;
  
   this.getUserRecords() 
}

  

    getUserRecords() {
      this.apicall.getDetails().subscribe(result => {
        this.customerList = result;
        this.dtTriger.next();
      })
    }


  edit(keyIdd: string){
    //this.editdetail.pkey = keyIdd;
    //this.sendpkey= keyIdd;
    this.router.navigateByUrl('/main/updaterecord');

    //yha par ek method call ho jaye jisme me ye keyIdd ki value means pkey send kar du

    //this.apicall.getDetailById(this.sendpkey).subscribe(result => {
     //this.editdetail = result;
        //})
  

  }

  delete(keyId: string) {
    this.dtTriger.unsubscribe();
    
    this.sendrecord.pkey = keyId;
    
    //console.log("Pkey: " +  this.pkey );
    console.log("Primary key: " + keyId );
    // printing sendrecord=[initiatedUser, pkey, operationSite
      console.log("Deletion on Parameter:" , this.sendrecord);
      this.apicall.deleteDetails(this.sendrecord).subscribe((apidata:userRecords)=>{
         console.log("Status: " + apidata.status);
        //console.log("Error Message: " + apidata.message);
         if (apidata.status == 'OK') {
           this.toast.warning("Deleted Sucessfuly", "Deleted!");
          }
         else{
          this.toast.error("Sorry! Deletion Failed");
         }
      })
     }

}
