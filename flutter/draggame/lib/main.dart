import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(DragDropGame());
}

class DragDropGame extends StatefulWidget {
  @override
  _DragDropGameState createState() => _DragDropGameState();
}

class _DragDropGameState extends State<DragDropGame> {
  Map<String, bool> scoreMap = {};
  int random = 1;
  Map fruitList = {
    '\u{1f34e}': Colors.red,
    '\u{1f350}': Colors.green,
    '\u{1f34b}': Colors.yellow,
    '\u{1f34a}': Colors.orange,
    '\u{1f347}': Colors.purple,
    '\u{1f330}': Colors.brown
  };

  AudioCache audioCache = new AudioCache();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match the color',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Score : ${scoreMap.length}'),
          backgroundColor: Colors.pinkAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          backgroundColor: Colors.purple,
          onPressed: () {
            setState(() {
              scoreMap.clear();
              random++;
            });
          },
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: fruitList.keys.map((emoji) {
                return Draggable<String>(
                  data: emoji,
                  child: Emoji(
                      emojiStr: (scoreMap[emoji] == true) ? '\u{2714}' : emoji),
                  feedback: Emoji(emojiStr: emoji),
                  childWhenDragging: Container(
                    height: 50,
                  ),
                );
              }).toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: fruitList.keys
                  .map((emoji) => _buildDragTarget(emoji))
                  .toList()
                    ..shuffle(Random(random)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> candidateData,
          List rejectedData) {
        print('creating target for--' + fruitList[emoji].toString());
        if (scoreMap[emoji] == true) {
          return Container(
            child: Text('Correct !'),
            alignment: Alignment.center,
            color: Colors.white,
            height: 50,
            width: 200,
          );
        } else {
          return Container(
            color: fruitList[emoji],
            height: 50,
            width: 200,
          );
        }
      },
      onWillAccept: (data) {
        print(' will accept data' + data);
        return data == emoji;
      },
      onAccept: (data) {
        setState(() {
          scoreMap[data] = true;
          if (scoreMap.length == 6) {
            audioCache.play('zim_success.mp3');
          } else {
            audioCache.play('successful.mp3');
          }
        });

        print(scoreMap.length);
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  final String emojiStr;

  Emoji({Key key, this.emojiStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        child: Text(
          emojiStr,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
