import { Injectable } from '@angular/core';
import { User } from './user.model';
import { AngularFireList, AngularFireDatabase } from '@angular/fire/database';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private baseUrl = "/beta/userlist"
  usersList: AngularFireList<any>;
  signedInUser: User = null

  constructor(private db: AngularFireDatabase) { }

  fetchUserList() {
    this.usersList = this.db.list(this.baseUrl);
    console.log(this.usersList);
    return this.usersList;
  }

  addUser(user: User) {
    console.log("Adding new User:%O", user)
    this.usersList.push(user);
  }

  parseUser(state) {
    let user = new User();
    user.email = state.email
    user.photourl = state.photoURL
    user.name = state.displayName
    user.emailUser = false
    return user;
  }
}
