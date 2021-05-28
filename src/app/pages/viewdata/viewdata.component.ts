import { Component, OnInit } from '@angular/core';
import { Subject, Observable } from 'rxjs';

@Component({
  selector: 'app-viewdata',
  templateUrl: './viewdata.component.html',
  styleUrls: ['./viewdata.component.css']
})
export class ViewdataComponent implements OnInit {
 public record=
  [
    
    {"filename":"a", "location":"India","date":"03-09-2020","position":"Manager"},
    {"filename":"b", "location":"Canada","date":"03-09-2020","position":"Manager"},
    {"filename":"c", "location":"Dubai","date":"03-09-2020","position":"Manager"},
    {"filename":"d", "location":"USA","date":"03-09-2020","position":"Manager"},
    {"filename":"e", "location":"China","date":"03-09-2020","position":"Manager"},
  
  ];

  dtOption: DataTables.Settings = {};
  dtTriger: Subject<any> = new Subject();
  constructor() { }

  ngOnInit(): void {
 this.dtOption = {
      pagingType: 'full_numbers',
      pageLength: 5,
      autoWidth: true,
      order: [[1, 'desc']]
  };
     
  }

}
