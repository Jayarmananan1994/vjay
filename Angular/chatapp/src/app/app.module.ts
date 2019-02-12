import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';
import { SplashScreen } from '@ionic-native/splash-screen';
import { StatusBar } from '@ionic-native/status-bar';

import { MyApp } from './app.component';
import { HomePage } from '../pages/home/home';
import { AuthService } from '../providers/auth-service/auth-service';

import { AngularFireModule } from 'angularfire2';
import { AngularFireAuthModule } from 'angularfire2/auth';
import { environment } from '../config/firebase-config';
import { ChatroomPage } from '../pages/chatroom/chatroom';
import { ChatServiceProvider } from '../providers/chat-service/chat-service';
import {  AngularFireDatabaseModule } from 'angularfire2/database';
import { PeopleServiceProvider } from '../providers/chat-service/people-service';

@NgModule({
  declarations: [
    MyApp,
    HomePage,
    ChatroomPage
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(MyApp),
    AngularFireModule.initializeApp(environment.firebaseConfig),
    AngularFireDatabaseModule,
    AngularFireAuthModule
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage,
    ChatroomPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    {provide: ErrorHandler, useClass: IonicErrorHandler},
    AuthService,
    ChatServiceProvider,
    PeopleServiceProvider
  ]
})
export class AppModule {}
