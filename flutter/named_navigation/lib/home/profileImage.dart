import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final String caption;
  ProfileImage({@required this.imageUrl, this.caption});
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Ink.image(
            image: new NetworkImage(this.imageUrl),
            fit: BoxFit.cover,
            width: 120.0,
            height: 120.0,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: InkWell(
                onTap: () {},
                child: null,
              ),
            )));
  }
}

/*
Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
        width: 135.0,
        height: 170.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage("https://i.imgur.com/BoN9kdC.png")))),
        onTap: (){},
      ),
    );

*/
/*
 Container(
        width: 135.0,
        height: 170.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage("https://i.imgur.com/BoN9kdC.png"))));
                */
/* 
ListTile(
          title: Text('data'),
          subtitle: Text('data'),
        )
*/
/*
Ink.image(
        image: new NetworkImage(this.imageUrl),
        fit: BoxFit.cover,
        width: 120.0,
        height: 120.0,
        child: InkWell(
          onTap: () {},
          child: null,
        ),
      )
 */
/*
  new Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(this.imageUrl)))),
*/
