import { Component, OnInit, Inject } from '@angular/core';
import { Observable } from 'rxjs';
import { TourProposalService } from '../tourproposal.service';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-request-list',
  templateUrl: './request-list.component.html',
  styleUrls: ['./request-list.component.css']
})
export class RequestListComponent implements OnInit {
  reqlist: Observable<any>; // = []

  proposalList = [];
  data : any;

  constructor(public tourProposalService: TourProposalService, public dialog: MatDialog) { }

  ngOnInit() {
    this.tourProposalService.getAllRequest().subscribe((res)=>{
      this.reqlist =  res;
    });
  }

  trackReq(req){
    this.proposalList = []
    console.log(req);
    //this.tourProposalService.getAllProposals(req.id)
    let source = new EventSource('http://localhost:8080/bid/allbidsbyid?requestId='+req.id);
    source.addEventListener('message', message => {
            let n: Notification; //need to have this Notification model class in angular2
            n = JSON.parse(message.data);
            console.log(message.data); 
            let obj = JSON.parse(message.data)
            this.proposalList.push(obj);
    });

  }
  makeaproposal(req){
    // let reqBody = {	"proposedBy": "ram","amount": 5500.0,"bitRequestId": req.id}
    // this.tourProposalService.postNewBitProposal(reqBody).subscribe((res)=>{
    //     console.log(res);
    // });
    let dialogRef = this.dialog.open(BiddingDialog, {
      width: "250px",
      data: { "proposedBy": "","amount": 0.0,"bitRequestId": req.id }
    });
    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed : %O',result);
      this.tourProposalService.postNewBitProposal(result).subscribe((res)=>{
          console.log(res);
       })
      
    });

  }
  
}



@Component({
  selector: "bidding-dialog",
  templateUrl: "../dialogtemplate/bidding-dialog.html"
})
export class BiddingDialog {
  constructor(
    public dialogRef: MatDialogRef<BiddingDialog>,
    @Inject(MAT_DIALOG_DATA) public data: BiddingDialogData
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }
}

export class BiddingDialogData {
  proposedBy: String;
  amount: number
}
