import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/calls/calls.dart';
import 'package:whatsapp_clone/screens/chat/chat.dart';
import 'package:whatsapp_clone/screens/status/status.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            // IconButton( icon: Icon(Icons.more_vert), onPressed: () {},),
            appPopUpMeuButton()
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Container(child: Tab(icon: Icon(Icons.camera_alt))),
              Container(width: width * 0.21, child: Tab(text: 'CHATS')),
              Container(width: width * 0.21, child: Tab(text: 'STATUS')),
              Container(width: width * 0.21, child: Tab(text: 'CALLS'))
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: <Widget>[Chat(), Chat(), Status(), Calls()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.message),
          backgroundColor: Colors.teal[800],
        ),
      ),
    );
  }

  get appPopUpMeuButton => () {
        return PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(child: Text('New group'), value: 1),
            PopupMenuItem(child: Text('New broadcast'), value: 2),
            PopupMenuItem(child: Text('WhatsApp Web'), value: 3),
            PopupMenuItem(child: Text('Starred messages'), value: 4),
            PopupMenuItem(child: Text('Settings'), value: 5),
          ],
        );
      };
}
