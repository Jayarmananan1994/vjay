import { Component, OnInit, ViewChild } from '@angular/core';
import { Message } from '../provider/chatservice/message.model';
import { ChatService } from '../provider/chatservice/chat.service';
import { AuthService } from '../provider/auth.service';
import { BruceService } from '../provider/bruce/bruce.service';
import { UserService } from '../provider/user.service';
import { Router } from '@angular/router';
import { User } from '../provider/user.model';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-chatroom',
  templateUrl: './chatroom.page.html',
  styleUrls: ['./chatroom.page.scss'],
})
export class ChatroomPage implements OnInit {
  //@ViewChild(Conten) public content:Conten ;
  public chatMsg: string;

  public chatHistory: Message[] = []
  public recieveUser: User
  public isNormalChat: boolean = false
  botMessages: Observable<Message[]>

  constructor(private chatservice: ChatService, private authService: AuthService, private bruce: BruceService, private router: Router) {
    console.log(this.chatservice.reciever)
    this.recieveUser = this.chatservice.reciever
    console.log(this.recieveUser)
  }

  ngOnInit() {
    let dummyMessage = new Message()
    dummyMessage.msg = 'Dummy Message'
    //this.chatHistory.push(dummyMessage)
    if (this.authService.authenticated && this.chatservice.reciever != null) {
      if (this.chatservice.reciever !== this.bruce.bruceUser) {
        this.initiateChatBox();
        this.isNormalChat = true
      } else {
        //this.initiateBotChat();
      }
    } else {
      this.router.navigate(['welcome'])
    }
  }

  initiateBotChat() {
    this.chatHistory = []
    this.bruce.conversation.asObservable()
      .subscribe(items => {
        console.log(items);
        this.chatHistory.push(items[0]);
      });
  }
  initiateChatBox() {
    return this.chatservice.getChatBox()
      .snapshotChanges().subscribe(items => {
        this.chatHistory = [];
        items.forEach(item => {
          let x = item.payload.toJSON();
          x['author'] = (x['authorEmail'] === this.authService.currentUser.email) ? 'You' : x['author']
          this.chatHistory.push(x as Message);
        });
        console.log('Chat history: %O', this.chatHistory)
        // let dimensions = this.content.getContentDimensions();
        // console.log(dimensions) 
        // this.content.scrollTo(300, 4*dimensions.scrollHeight, 100);
      })
  }

  chat() {
    if (this.chatMsg.length != 0 && this.chatMsg != 'undefined') {
      this.addChatObj();
      this.chatMsg = "";
    }
  }

  addChatObj() {
    let message = new Message();
    message.author = 'You' //this.authService.currentUser.displayName
    message.authorEmail = this.authService.currentUser.email
    message.msg = this.chatMsg;
    message.media = null;
    //ga('send', {hitType: 'event', eventCategory: 'Messageing Frequency', eventAction: 'msg', user: this.authService.currentUser.displayName });
    if (this.chatservice.reciever !== this.bruce.bruceUser) {
      this.chatservice.insertChat(message);
    } else {
      this.chatHistory.push(message)
      this.bruce.talk(message).then(res => {
        let reply = new Message()
        reply.author = this.bruce.bruceUser.name
        reply.msg = res.result.fulfillment.speech;
        this.chatHistory.push(reply)
      });
    }
  }

}
