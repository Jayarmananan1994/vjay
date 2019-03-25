import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { ApiAiClient } from 'api-ai-javascript/es6/ApiAiClient'
import { User } from '../user.model';
import { BehaviorSubject } from 'rxjs';
import { Message } from '../chatservice/message.model';

@Injectable({
  providedIn: 'root'
})
export class BruceService {
  readonly token = environment.dialogFlow.botKey
  readonly client = new ApiAiClient({ accessToken: this.token })
  readonly bruceUser : User

  conversation = new BehaviorSubject<Message[]>([]);

  constructor() { 
    this.bruceUser = new User()
    this.bruceUser.name = 'Bruce Wayne'
    this.bruceUser.photourl = 'https://vignette.wikia.nocookie.net/nolanverse/images/4/41/Christian_bale_bruce_wayne.jpg'
  }

  updateChat(msg: Message){
    this.conversation.next([msg]);
  }

  talk(message: Message) {
    this.updateChat(message)
   return this.client.textRequest(message.msg)
        /*.then(res => {
           let reply = new Message()
           reply.author = this.bruceUser.name
           reply.msg = res.result.fulfillment.speech;
           this.updateChat(reply);
        });*/
  }

}
