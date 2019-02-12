import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { FishPage } from './fish';

@NgModule({
  declarations: [
    FishPage,
  ],
  imports: [
    IonicPageModule.forChild(FishPage),
  ],
})
export class FishPageModule {}
