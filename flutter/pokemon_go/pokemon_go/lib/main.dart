import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pokedetail.dart';
import 'pokehub.dart';

void main() => runApp(MaterialApp(
      title: 'pokemon go',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  var data = 'empty data..';
  PokeHut pokeHut;
  @override
  void initState() {
    super.initState();
    fetchData();
    // setState(() {});
  }

  mainBodyWidget() => FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          PokeHut restData = snapShot.data;
          print('RESt DATa: $restData');
          if (restData == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.count(
              crossAxisCount: 2,
              children: restData.pokemon
                  .map((poke) => Padding(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PokemonDetail(pokemon: poke)));
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(poke.img))),
                                ),
                                Text(poke.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(2.0)))
                  .toList(),
            );
            /*return ListView.builder(
              itemCount: restData.pokemon.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(restData.pokemon[index].name),
                );
              },
            );*/
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Go'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: mainBodyWidget() /* pokeHut == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHut.pokemon
                  .map((poke) => Padding(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PokemonDetail(pokemon: poke)));
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(poke.img))),
                                ),
                                Text(poke.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(2.0)))
                  .toList(),
            )*/
          ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
        onPressed: () {},
      ),
      drawer: Drawer(),
    );
  }

  Future<PokeHut> fetchData() async {
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    pokeHut = PokeHut.fromJson(decodedJson);
    print(pokeHut);
    return pokeHut;
    // data = resdata.body;
  }
}
