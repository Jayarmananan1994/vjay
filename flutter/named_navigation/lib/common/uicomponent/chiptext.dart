import 'package:flutter/material.dart';

class ChipText extends StatelessWidget {
  final String text;
  ChipText({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 7,vertical: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          color: Colors.grey,
          child: Text(text),
        ),
      ),
    );
  }
}
