import { Component, OnInit, Inject } from "@angular/core";
import { TourProposalService } from "./tourproposal.service";
import { Observable } from "rxjs";
import {
  MAT_DIALOG_DATA,
  MatDialog,
  MatDialogRef
} from "@angular/material/dialog";
import { inject } from "@angular/core/testing";

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.css"]
})
export class AppComponent implements OnInit {
  title = "Cityusher app";
  productName = "";
  price = 0;
  mylist: Observable<any>; 
  showReqList = false;

  ngOnInit() {
  }

  constructor(
    public tourProposalService: TourProposalService,
    public dialog: MatDialog
  ) {}

  postNewBidRequest() {
    let req = { productName: this.productName, initialAmount: this.price };
    console.log(req);
    this.tourProposalService.postNewBit(req).subscribe(res => {
      console.log(res);
      //alert("Submitted your request. The req id is")
      this.dialog.open(MessageDialog, {
        width: "250px",
        data: { reqId: res.id }
      });
    });
  }

  viewReqeust() {
    this.showReqList = true;
  }
}

@Component({
  selector: "message-dialog",
  templateUrl: "./dialogtemplate/message-dialog.html"
})
export class MessageDialog {
  constructor(
    public dialogRef: MatDialogRef<MessageDialog>,
    @Inject(MAT_DIALOG_DATA) public data: MessageDialogData
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }
}

export class MessageDialogData {
  reqId: String;
}
