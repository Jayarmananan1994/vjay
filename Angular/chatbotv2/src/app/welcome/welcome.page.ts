import { Component, OnInit } from '@angular/core';
import { AuthService } from '../provider/auth.service';
import { UserService } from '../provider/user.service';
import { User } from '../provider/user.model';
import { HomePage } from '../home/home.page';
import { Router } from '@angular/router';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.page.html',
  styleUrls: ['./welcome.page.scss'],
})
export class WelcomePage implements OnInit {
  public currentEmail: string
  public isSignedIn = false;

  constructor(public router: Router, public authService: AuthService, public userService: UserService) {

  }
  ngOnInit() {
    this.signinUserbyDefault();
  }

  signinUserbyDefault() {
    this.authService.currentUserObservable.subscribe((state) => {
      console.log(state);
      this.currentEmail = (state == null) ? "" : state.email
      this.isSignedIn = (state == null) ? false : true;
      if (state !== null) {
        let currentUser = this.userService.parseUser(state);
        this.userService.signedInUser = currentUser
      }

    });

  }

  signinWithgoogle() {
    this.authService.googleSignin().then((state) => {
      console.log(state);
      this.userService.fetchUserList()
        .snapshotChanges().subscribe(items => {
          console.log("Users:%O", items)
          let signedInUser = this.userService.parseUser(state)

          let isNewUser = true;
          items.forEach(item => {
            let x = item.payload.toJSON() as User;
            if (x.email == state.email) {
              isNewUser = false
            }
          })
          if (isNewUser) {
            this.userService.addUser(signedInUser)
          }
          this.userService.signedInUser = signedInUser

        });
    })
  }
  signOut() {
    alert();
    if (this.authService.authenticated) {
      this.authService.logout().then((state) => {
        console.log("logout state", state);
      });
    } else {
      alert("not signed in")
    }

  }

  navigateChat() {
    this.router.navigate(['home']);
  }

}
