import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpInterceptor
} from '@angular/common/http';


@Injectable()
export class ApiinterceptInterceptor implements HttpInterceptor {

  constructor() {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler) {
    let token = localStorage.getItem('userToken');
    if(!!localStorage.getItem('userToken'))
    {
      let tokenizedreq = request.clone({
        setHeaders : {
          Authorization : `Bearer ${token}`
        }
      });
      return next.handle(tokenizedreq);
    }
    else
    {
      return next.handle(request);
    }
  }
}
