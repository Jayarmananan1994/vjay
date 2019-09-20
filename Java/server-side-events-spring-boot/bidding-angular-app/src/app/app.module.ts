import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { routingModule } from './app-routing.module';
import { AppComponent, MessageDialog } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { TourProposalService } from './tourproposal.service';
import { RequestListComponent, BiddingDialog } from './request-list/request-list.component';
import { MatDialogModule,  } from '@angular/material/dialog';
import { BrowserAnimationsModule} from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';
import {  MatFormFieldModule,MatInputModule} from '@angular/material';

@NgModule({
  declarations: [
    AppComponent,
    RequestListComponent,
    MessageDialog,
    BiddingDialog
  ],
  imports: [
    BrowserModule,
    routingModule,
    HttpClientModule,
    FormsModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    BrowserAnimationsModule
    
  ],
  entryComponents: [MessageDialog, BiddingDialog],
  providers: [TourProposalService],
  bootstrap: [AppComponent]
})
export class AppModule { }
