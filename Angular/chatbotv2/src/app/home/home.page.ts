import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from '../provider/user.service';
import { AuthService } from '../provider/auth.service';
import { User } from '../provider/user.model';
import { BruceService } from '../provider/bruce/bruce.service';
import { ChatService } from '../provider/chatservice/chat.service';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage implements OnInit {
  userList: User[] = []
  constructor(public router: Router, public userService: UserService, public bruceService: BruceService, private chatService: ChatService) {

  }

  ngOnInit() {
    console.log(this.userService.signedInUser)
    if (this.userService.signedInUser == null) {
      this.router.navigate(['welcome'])
    }
    this.populateUserList();
  }

  populateUserList() {
    this.userList.push(this.bruceService.bruceUser)
    this.userService.fetchUserList()
      .snapshotChanges().subscribe(items => { 
        items.forEach(item => {
          let x = item.payload.toJSON() as User;
          if (x.email !== this.userService.signedInUser.email) {
            this.userList.push(x)
          }
        })
      });
  }
  redirectIfNotSignedIn() {

  }

  gotoChat(user: User) {
    console.log("Goto chat : %O", user)
    this.chatService.reciever = user
    this.router.navigate(['chatroom'])
  }
  signOut() {
    console.log("asdasd")
    this.router.navigate(['welcome'])
  }
}
