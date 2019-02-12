import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { FishpagePage } from './fishpage';

@NgModule({
  declarations: [
    FishpagePage,
  ],
  imports: [
    IonicPageModule.forChild(FishpagePage),
  ],
})
export class FishpagePageModule {}
