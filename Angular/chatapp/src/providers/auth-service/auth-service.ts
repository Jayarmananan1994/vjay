//import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AngularFireAuth } from 'angularfire2/auth';
import { FirebaseAuth } from '@firebase/auth-types';
import * as firebase from 'firebase';
/*
  Generated class for the AuthServiceProvider provider.

  See https://angular.io/guide/dependency-injection for more info on providers
  and Angular DI.
*/
@Injectable()
export class AuthService {
  
  authState :any;
  
  constructor(public afAuth : AngularFireAuth) {
      afAuth.authState.subscribe((state)=>{
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

  googleSignin(){
    const provider = new firebase.auth.GoogleAuthProvider()
    return this.socialSignin(provider)
  }
  logout(){
    return this.afAuth.auth.signOut();
  }

  ///////////
  private socialSignin(provider){
    return this.afAuth.auth.signInWithPopup(provider)
    .then((credential) =>  {
      this.authState = credential.user
      this.updateUserData()
      return this.authState;
    })
    .catch(error => console.log(error));
  }

  private updateUserData(){

  }
}
