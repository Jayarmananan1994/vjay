import { Injectable } from '@angular/core';
import { AngularFireDatabase, AngularFireList } from '@angular/fire/database';
import { AngularFireAuth } from '@angular/fire/auth'
import * as firebase from 'firebase';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  authState: any;

  constructor(public afAuth: AngularFireAuth) {
    afAuth.authState.subscribe((state) => {
      this.authState = state;
    });
  }

  get authenticated(): boolean {
    return this.authState !== null;
  }

  get currentUser(): any {
    return this.authenticated ? this.authState : null;
  }
  get currentUserObservable(): any {
    return this.afAuth.authState
  }

  googleSignin() {
    const provider = new firebase.auth.GoogleAuthProvider()
    return this.socialSignin(provider)
  }
  logout() {
    return this.afAuth.auth.signOut();
  }

  ///////////
  private socialSignin(provider) {
    return this.afAuth.auth.signInWithPopup(provider)
      .then((credential) => {
        this.authState = credential.user
        //this.updateUserData()
        return this.authState;
      })
      .catch(error => console.log(error));
  }

}
