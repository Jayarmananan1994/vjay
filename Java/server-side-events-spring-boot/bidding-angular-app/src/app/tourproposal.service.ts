import { Injectable, NgZone } from '@angular/core';

import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class TourProposalService{
    serviceUrl = 'http://localhost:8080/bid'
    constructor(private http: HttpClient, private ngZone : NgZone) {}

    getAllBitResponse(id){
        this.http.get(this.serviceUrl+'/allbidsbyid?requestId='+id).subscribe((resp)=>{
            console.log(resp)
        });
    }

    postNewBit(req): Observable<any>{
        return this.http.post(this.serviceUrl+'/newbid',req);
    }

    getAllRequest(): Observable<any>{
        return this.http.get(this.serviceUrl+'/allbidreq');
    }

    postNewBitProposal(req): Observable<any>{
        return this.http.post(this.serviceUrl+'/postbidresponse',req)
    }
   
    getAllProposals(id): Observable<any>{
        let proposals = []
        return Observable.create((observer)=>{
            const eventSource = new EventSource(this.serviceUrl+'/allbidsbyid?requestId='+id);
            eventSource.addEventListener('message', message => {                
                console.log(message.data); 
            });
            eventSource.onmessage=(event)=>{
                console.log("REceived Event:%O",event)
                var obj = JSON.parse(event.data)
                proposals.push(obj)
                console.log(proposals)
                this.ngZone.run(()=>{
                    observer.next(proposals)
                })
            },
            eventSource.onerror=(error)=>{
                //console.log("REceived error:%O",error);                    
            }               

        });
        //return this.http.get(this.serviceUrl+'/proposals');


    }
}