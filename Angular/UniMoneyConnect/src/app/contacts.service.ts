import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ContactsService {

  constructor(private httpClient: HttpClient) { }

  getContactList() {
    console.log('Service working');
    return this.httpClient.get('https://5c569377d293090014c0ee5a.mockapi.io/api/v1/contacts');
  }
}
