import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MainComponent } from './main/main.component';
import { LoginComponent } from './login/login.component';
import { PageNotFoundComponent } from './pages/page-not-found/page-not-found.component';
import { PageguardGuard } from './pageguard.guard';
import { CustomerRecordComponent } from './pages/customer-record/customer-record.component';
import { DetailListComponent } from './pages/detail-list/detail-list.component';
import { UpdateDetailComponent } from './pages/update-detail/update-detail.component';
import { ViewdataComponent } from './pages/viewdata/viewdata.component';


const routes: Routes = 
[
  {
    path: '', component:LoginComponent
  },
  {
    path:'main' , component:MainComponent, //canActivate: [PageguardGuard],
    children: 
    [
       {
        path:'addcustomer',component:CustomerRecordComponent,
      },
      {
        path:'customer-list',component:DetailListComponent,
      },
      {
        path:'updaterecord',component:UpdateDetailComponent,
      },
       {
        path:'data',component:ViewdataComponent,
      },
     
      {
        path: '**' , component:PageNotFoundComponent
      }
    
    ]
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
