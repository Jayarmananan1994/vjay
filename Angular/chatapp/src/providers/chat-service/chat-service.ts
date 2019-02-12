//import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AngularFireDatabase, AngularFireList } from 'angularfire2/database';
import { ChatObj } from './chatObj.model';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';

/*
  Generated class for the ChatServiceProvider provider.

  See https://angular.io/guide/dependency-injection for more info on providers
  and Angular DI.
*/
@Injectable()
export class ChatServiceProvider {
  private baseUrl = "/beta/chatBox"
  chatHistory: AngularFireList<any>;

  constructor(private db : AngularFireDatabase) {
    //this.getChatBox();
  }


  getChatBox(){
     this.chatHistory = this.db.list(this.baseUrl); 
    console.log(this.chatHistory);
    return this.chatHistory;
  }

  insertChat(chat: ChatObj){
    this.chatHistory.push(chat);
  }



}
