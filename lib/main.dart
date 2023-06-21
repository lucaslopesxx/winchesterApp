import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Winchester APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("WinchesterAPP"),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 10),
                      enlargeCenterPage: true,
                    ),
                    items: [0, 1, 2, 3, 4, 5, 6, 7, 8].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: (Card(modulos[i])));
                        },
                      );
                    }).toList(),
                  )
                ])
              ],
            )));
  }
}

class Card extends StatelessWidget {
  final String modulo;
  const Card(this.modulo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(180, 0, 0, 0),
          border: Border.all(
              color: Colors.white, // Set border color
              width: 2.0), // Set border width
          borderRadius: const BorderRadius.all(
              Radius.circular(15.0)), // Set rounded corner radius
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                width: 125,
                height: 125,
                color: Colors.black,
              ),
              Text(
                modulo,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 199, 255),
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              )
            ])
          ],
        ));
  }
}

List<String> modulos = [
  'Materiais e Ferramentas',
  'Instruções de Caça',
  'Investigação',
  'Mitologia',
  'Fantasmas',
  'Monstros',
  'Demônios',
  'Anjos',
  'Divindades'
];
