import { Injectable } from '@angular/core';
import { AngularFireDatabase, AngularFireList } from '@angular/fire/database';
import { Message } from './message.model';
import { User } from '../user.model';
import { UserService } from '../user.service';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private baseUrl = "/beta/chatBox"
  chatHistory: AngularFireList<any>;
  reciever: User = null;
  constructor(private db: AngularFireDatabase, private userService: UserService) {
    //this.getChatBox();
  }


  getChatBox() {

    let subUrl = (this.userService.signedInUser.name < this.reciever.name) ? 
            (this.userService.signedInUser.name + this.reciever.name) : (this.reciever.name + this.userService.signedInUser.name)

    this.chatHistory = this.db.list(this.baseUrl+"/"+subUrl);
    console.log(this.chatHistory);
    return this.chatHistory;
  }

  insertChat(chat: Message) {
    this.chatHistory.push(chat);
  }
}
