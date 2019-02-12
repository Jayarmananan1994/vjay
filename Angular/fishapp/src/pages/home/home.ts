import { Component, OnInit } from '@angular/core';
import { NavController } from 'ionic-angular';
import { CartpagePage } from '../cartpage/cartpage';
import { PeopleServiceProvider } from '../../providers/people-service/people-service';
import { Fish } from '../../providers/people-service/fish.model';
import { AngularFireList, AngularFireDatabase } from 'angularfire2/database';
import { Observable } from 'rxjs';
import { FishpagePage } from '../fishpage/fishpage';
import { FishPage } from '../fish/fish';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage implements OnInit {
  //sliSlides
  public fishes: Fish[]; 
  public adLists : String[]

  public itemsRef : AngularFireList<any>;
  constructor(public navCtrl: NavController,public peopleService : PeopleServiceProvider,public db : AngularFireDatabase) {
    this.loadBanners();
  }
  ngOnInit(){
    this.itemsRef = this.db.list('/fishcoll/edible');
    this.itemsRef.snapshotChanges()
    .subscribe(actions => {
       actions.forEach(action => {
        console.log(action.type);
        console.log(action.key);
        console.log(action.payload.val());
      });
    });
    
  }
  loadBanners(){
    this.adLists = [
      'assets/imgs/ad1.jpg',
      'assets/imgs/ad2.jpg',
      'assets/imgs/ad3.png',
      'assets/imgs/ad4.jpg'
    ]
    console.log("banners:%O",this.adLists)
  }

loadFishes(){
 // this.fishes = this.peopleSerive.load()

}

gotoCheckout(){
  this.navCtrl.push(CartpagePage);
}

navigateTo(page){
  if(page=='fish')
    this.navCtrl.push(FishPage);
  //alert('Navigate to '+page);
}

}
