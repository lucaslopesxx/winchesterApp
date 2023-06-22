import 'dart:html';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Winchester APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
              title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('WinchesterAPP'),
              // Image.asset(
              //   'assets/images/icone.png',
              //   width: 100,
              // ),
            ],
          )),
          body: ListView(
            children: [
              Column(children: [
                Carrossel(),
              ])
            ],
          ),
        ));
  }
}

class Carrossel extends StatefulWidget {
  const Carrossel({super.key});

  @override
  State<Carrossel> createState() => _Carrossel();
}

class _Carrossel extends State<Carrossel> {
  int _atual = 0;
  final CarouselController _controle = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: modulos.asMap().entries.map((i) {
          final int posicao = i.key;
          final String modulo = i.value;
          final String imagem = modImagens[posicao];

          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Card(modulo, imagem),
              );
            },
          );
        }).toList(),
        carouselController: _controle,
        options: CarouselOptions(
          enlargeCenterPage: true,
          onPageChanged: (posicao, reason) {
            setState(() {
              _atual = posicao;
            });
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: modulos.asMap().entries.map((i) {
          return GestureDetector(
            onTap: () => _controle.animateToPage(i.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(_atual == i.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

class Card extends StatelessWidget {
  final String modulo;
  final String imagem;
  const Card(this.modulo, this.imagem, {super.key});

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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/$imagem',
                  height: 100,
                ),
                Text(
                  modulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 199, 255),
                    fontSize: 28,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
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

List<String> modImagens = [
  'materiais.png',
  'caca.png',
  'investigacao.png',
  'mitologia.png',
  'fantasmas.png',
  'monstros.png',
  'demonios.png',
  'anjos.png',
  'divindades.png',
];
