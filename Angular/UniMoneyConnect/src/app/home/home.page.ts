import { ContactsService } from './../contacts.service';
import { Contact } from './../models/contact.model';
import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage implements OnInit {
  contactlist: Contact[];
  filteredList: Contact[];
  searchText: string;

  constructor(private contactService: ContactsService) {
    this.getContacts();
  }
  ngOnInit() {
  }

  getContacts() {
    this.contactService.getContactList().subscribe((response: Contact[]) => {
      console.log(response);
      this.contactlist = response;
      this.filteredList = this.contactlist;
    });
  }

  filterbySearchText() {
      console.log(this.searchText);
      this.filteredList = this.contactlist.filter(contact => contact.name.toLowerCase().indexOf(this.searchText.toLowerCase()) > -1 );
  }
}
