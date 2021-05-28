import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { MainComponent } from './main/main.component';
import { LoginComponent } from './login/login.component';
import { HeaderComponent } from './main/header/header.component';
import { FooterComponent } from './main/footer/footer.component';
import { MainSidebarComponent } from './main/main-sidebar/main-sidebar.component';
import { DataTablesModule } from 'angular-datatables';
import { ControlSidebarComponent } from './main/control-sidebar/control-sidebar.component';
import { PageNotFoundComponent } from './pages/page-not-found/page-not-found.component';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { FormsModule,ReactiveFormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';    
import { ToastrModule } from 'ngx-toastr';  
import { ApiinterceptInterceptor } from './apiintercept.interceptor'
import { PageguardGuard } from './pageguard.guard';
import { JwBootstrapSwitchNg2Module } from 'jw-bootstrap-switch-ng2';
import { CustomerRecordComponent } from './pages/customer-record/customer-record.component';
import { DetailListComponent } from './pages/detail-list/detail-list.component';
import { UpdateDetailComponent } from './pages/update-detail/update-detail.component';
import { ViewdataComponent } from './pages/viewdata/viewdata.component';




@NgModule({
  declarations: [
    AppComponent,
    MainComponent,
    LoginComponent,
    HeaderComponent,
    FooterComponent,
    MainSidebarComponent,
    ControlSidebarComponent,
    PageNotFoundComponent,
    CustomerRecordComponent,
    DetailListComponent,
    UpdateDetailComponent,
    ViewdataComponent,
    
 
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    [BrowserAnimationsModule],
   // ToastrModule.forRoot(), 
   ToastrModule.forRoot({
    timeOut: 2000,
    positionClass: 'toast-top-right',
  }),
    JwBootstrapSwitchNg2Module,
    DataTablesModule,
  ],
  providers: [
    PageguardGuard,
    {provide: HTTP_INTERCEPTORS, useClass: ApiinterceptInterceptor, multi: true }    
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
