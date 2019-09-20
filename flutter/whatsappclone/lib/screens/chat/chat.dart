import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
   var list = [
      ChatItem(
          circleAvatar:
              'https://image.shutterstock.com/image-vector/man-character-face-avatar-glasses-600w-542759665.jpg',
          name: 'Arsent',
          lastMessage: 'Arsent: Received the money'),
      ChatItem(
          circleAvatar:
              'https://i.stack.imgur.com/kdrpp.png',
          name: 'We need shuttle reunion',
          lastMessage: 'Received the money'),
      ChatItem(
          circleAvatar:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7QpVGMXkaI2Xur3eEEUeYP5ME5EhcYvLzwMGMlzQ1AbKRF4wl',
          name: 'Partha',
          lastMessage: 'Partha: have you seen it?'),
      ChatItem(
          circleAvatar:
              'https://media.creativemornings.com/uploads/user/avatar/120448/profile-circle.png',
          name: 'Mahesh yadhav',
          lastMessage: 'Partha: have you seen it?'),
            ChatItem(
          circleAvatar:
              'https://www.ingenie.com/wp-content/uploads/2014/03/avatar-customers-faith-mitchell-circle.png',
          name: 'Link2Settle ',
          lastMessage: 'You: sent the email'),
         
    ];


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      // appBar: AppBar(title: Text('Chats'),),
      body: Padding( padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),child: chatList(),),
    );
  }

  get chatList => (){
    return ListView.separated(
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => Divider(indent: 70,height: 0,),
        itemBuilder: (BuildContext ctxt, int index) {
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(list[index].circleAvatar),radius: 30,),
            title: Text(list[index].name, style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(list[index].lastMessage),
            onTap: (){},
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Today', style: TextStyle(fontSize: 10),),
                Text('')
              ],
            ),
          );
        },
      );
  };

}

class ChatItem {
  String circleAvatar;
  String name;
  String lastMessage;

  ChatItem({this.circleAvatar, this.name, this.lastMessage});
}
