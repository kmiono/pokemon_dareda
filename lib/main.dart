import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import '../model/pokeapi.dart';
import '../const/pokeapi.dart';

Future<Pokemon> fetchPokemon(int id) async {
  final res = await http.get(Uri.parse('$pokeApiRoute/pokemon/$id'));
  if (res.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ポケモンだーれだ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          useMaterial3: true,
        ),
        home: MyHomePage(title: 'ポケモンだーれだ'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  var random = math.Random().nextInt(1025);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$random.png",
              height: 300,
              width: 300,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
          });
        },
      ),
    );
  }
}
