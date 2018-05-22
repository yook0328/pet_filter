import { Component, OnInit } from '@angular/core';
import { DataServiceService } from './data-service.service';
@Component({
  selector: 'pet-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css'],
  providers: [DataServiceService]
})
export class HeaderComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

}
