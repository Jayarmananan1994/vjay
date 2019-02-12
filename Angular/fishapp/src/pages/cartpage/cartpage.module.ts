import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { CartpagePage } from './cartpage';

@NgModule({
  declarations: [
    CartpagePage,
  ],
  imports: [
    IonicPageModule.forChild(CartpagePage),
  ],
})
export class CartpagePageModule {}
