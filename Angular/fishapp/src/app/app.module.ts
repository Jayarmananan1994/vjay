import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';
import { SplashScreen } from '@ionic-native/splash-screen';
import { StatusBar } from '@ionic-native/status-bar';

import { MyApp } from './app.component';
import { HomePage } from '../pages/home/home';
import { PeopleServiceProvider } from '../providers/people-service/people-service';
import { HttpModule } from '@angular/http';
import { AngularFireModule } from 'angularfire2';
import { environment } from '../environment/environment';
import { AngularFireDatabaseModule } from 'angularfire2/database';
import { CartpagePage } from '../pages/cartpage/cartpage';
import { FishPage } from '../pages/fish/fish';

@NgModule({
  declarations: [
    MyApp,
    HomePage,
    CartpagePage,
    FishPage
  ],
  imports: [
    BrowserModule,
    HttpModule,
    IonicModule.forRoot(MyApp),
    AngularFireModule.initializeApp(environment.firebaseConfig),
    AngularFireDatabaseModule 
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage,
    CartpagePage,
    FishPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    {provide: ErrorHandler, useClass: IonicErrorHandler},
    PeopleServiceProvider
  ]
})
export class AppModule {}
