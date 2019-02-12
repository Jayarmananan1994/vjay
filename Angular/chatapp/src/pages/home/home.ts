import { Component ,OnInit} from '@angular/core';
import { NavController } from 'ionic-angular';
import { AuthService } from '../../providers/auth-service/auth-service';
import { ChatroomPage } from '../chatroom/chatroom';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage implements OnInit { 
  public currentEmail :string
  public isSignedIn  = false;

  constructor(public navCtrl: NavController,public authService : AuthService) {
     
  }

  ngOnInit(){
    this.signinUserbyDefault();
  }

  signinUserbyDefault(){
    this.authService.currentUserObservable.subscribe((state)=>{
      console.log(state);
      this.currentEmail = (state==null) ? "" : state.email
      this.isSignedIn = (state==null) ? false : true;
    });
    
  }
  signinWithgoogle(){
    this.authService.googleSignin().then((state)=>{
        console.log(state);
    })
  }
  signOut(){
    alert();
    if(this.authService.authenticated){
      this.authService.logout().then((state) =>{
        console.log("logout state",state);
      });
    }else{
      alert("not signed in")
    }

  }
  navigateChat(){  
    this.navCtrl.push(ChatroomPage);
  }
}
