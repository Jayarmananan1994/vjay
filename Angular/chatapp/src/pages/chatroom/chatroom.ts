import { Component, OnInit, ViewChild } from '@angular/core';
import { IonicPage, NavController, NavParams, Content } from 'ionic-angular';
import { ChatObj } from '../../providers/chat-service/chatObj.model';
import { ChatServiceProvider } from '../../providers/chat-service/chat-service';
import { AuthService } from '../../providers/auth-service/auth-service';
import { PeopleServiceProvider } from '../../providers/chat-service/people-service';
declare let ga: Function;

/**
 * Generated class for the ChatroomPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-chatroom',
  templateUrl: 'chatroom.html'
})
export class ChatroomPage  implements OnInit {
  @ViewChild(Content) public content:Content ;
  public chatMsg : string;
  public chatHistory : ChatObj[]
  public doneLoad: boolean = false;
  constructor(public navCtrl: NavController, public navParams: NavParams,
              public chatservice : ChatServiceProvider,public authService : AuthService,
              public peopleService : PeopleServiceProvider) {
    this.chatHistory = [];
    //this.content.scrollToBottom(500);
  }

  ngOnInit(){
    console.log("load");
     return this.chatservice.getChatBox()
        .snapshotChanges().subscribe(items=>{
            this.chatHistory = [];
            items.forEach(item =>{
              let x  = item.payload.toJSON();
              x['author'] = (x['authorEmail']===this.authService.currentUser.email) ? 'You' : x['author']
              this.chatHistory.push(x as ChatObj);
            });
            let dimensions = this.content.getContentDimensions();
            console.log(dimensions) 
            this.content.scrollTo(300, 4*dimensions.scrollHeight, 100);
        });
     // console.log(this.peopleService.load().snapshotChanges().subscribe());
  } 

  ionViewDidEnter() {
    let dimensions = this.content.getContentDimensions();
   // this.content.scrollTo(0, dimensions.contentHeight+100, 100);
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad ChatroomPage scrolling down');
    let dimensions = this.content.getContentDimensions();
    //this.content.scrollTo(0, 2*dimensions.scrollHeight, 300);
  }

  chat(){
    //alert("sadas");
    if(this.chatMsg.length!=0 && this.chatMsg!='undefined'){
      this.addChatObj();
      this.chatMsg = "";
    }
  }

  addChatObj(){
    let chatObj = new ChatObj();
    chatObj.author = this.authService.currentUser.displayName
    chatObj.authorEmail = this.authService.currentUser.email
    chatObj.msg = this.chatMsg;
    chatObj.media = null;  
    ga('send', {hitType: 'event', eventCategory: 'Messageing Frequency', eventAction: 'msg', user: this.authService.currentUser.displayName });
    this.chatservice.insertChat(chatObj);
  }

  deleteChatObj(){

  }


}
