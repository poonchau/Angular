import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.css']
})
export class FooterComponent implements OnInit {

  constructor() { }
  Copyright_date : string;

  ngOnInit(): void {
    this.Copyright_date= new Date().getFullYear().toString();
  }

}
