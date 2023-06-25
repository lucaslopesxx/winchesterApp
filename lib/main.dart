import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:google_fonts/google_fonts.dart';

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
        home: NavBar(ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              margin: const EdgeInsets.symmetric(vertical: 50),
              child: Image.asset(
                'assets/images/wcacademy.png',
              ),
            ),
            Carrossel(),
          ],
        )));
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
      Container(
        padding: const EdgeInsets.only(top: 35),
        child: const Text(
          'DESTAQUES',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      CarouselSlider(
        items: modulos.asMap().entries.map((i) {
          final int posicao = i.key;
          final String modulo = i.value;
          final String imagem = modImagens[posicao];
          final Widget link = linkImagens[posicao];

          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.90,
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Card(modulo, imagem, link),
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
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Cores.corSecundaria)
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
  final Widget link;
  const Card(this.modulo, this.imagem, this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return link;
              }))
            },
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: Cores.corPrimaria.withAlpha(180),
                  border: Border.all(
                      color: Colors.white, // Set border color
                      width: 2.0), // Set border width
                  borderRadius: const BorderRadius.all(
                      Radius.circular(15.0)), // Set rounded corner radius
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/$imagem',
                        height: MediaQuery.of(context).size.height * 0.10),
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        modulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Cores.corExtra2,
                          fontSize: 28,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ))));
  }
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: SidebarXController(selectedIndex: -1, extended: true),
      theme: SidebarXTheme(
        decoration: const BoxDecoration(
          color: Cores.corExtra,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 40),
        selectedItemTextPadding: const EdgeInsets.only(left: 40),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Cores.corTerciaria.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [Cores.corTerciaria, Cores.corExtra2],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Cores.corExtra,
        ),
      ),
      headerBuilder: (context, extended) {
        return const SizedBox(
          height: 25,
          child: Padding(
            padding: EdgeInsets.all(16.0),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MyApp();
            }));
          },
        ),
        SidebarXItem(
          icon: Icons.list,
          label: 'Módulos',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Modulos();
            }));
          },
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'Suporte',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Suporte();
            }));
          },
        ),
        SidebarXItem(
          iconWidget: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              width: 25,
              height: 25,
              child: Image.asset(
                'assets/images/user.png',
              ),
            ),
          ),
          label: 'Conta',
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return const Conta();
            // }));
          },
        ),
      ],
    );
  }
}

class Cores {
  static const Color corPrimaria = Color.fromARGB(255, 14, 14, 14);
  static const Color corSecundaria = Color.fromARGB(255, 246, 246, 246);
  static const Color corTerciaria = Color.fromARGB(255, 8, 156, 198);
  static const Color corExtra = Color.fromARGB(255, 8, 82, 104);
  static const Color corExtra2 = Color.fromARGB(255, 0, 199, 255);
  static const Color corHover = Color.fromARGB(255, 37, 37, 37);
}

class Materiais extends StatelessWidget {
  const Materiais({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Materiais e Ferramentas'),
    ));
  }
}

class Instrucoes extends StatelessWidget {
  const Instrucoes({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Instruções de Caça'),
    ));
  }
}

class Investigacao extends StatelessWidget {
  const Investigacao({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Investigação'),
    ));
  }
}

class Mitologia extends StatelessWidget {
  const Mitologia({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Mitologia'),
    ));
  }
}

class Fantasmas extends StatelessWidget {
  const Fantasmas({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Fantasmas'),
    ));
  }
}

class Monstros extends StatelessWidget {
  const Monstros({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Monstros'),
    ));
  }
}

class Demonios extends StatelessWidget {
  const Demonios({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Demônios'),
    ));
  }
}

class Anjos extends StatelessWidget {
  const Anjos({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Anjos'),
    ));
  }
}

class Divindades extends StatelessWidget {
  const Divindades({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(Container(
      color: Cores.corExtra,
      child: Text('Divindades'),
    ));
  }
}

class NavBar extends StatelessWidget {
  const NavBar(this.app, {super.key});
  final Widget app;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.corPrimaria,
      endDrawer: SideBar(),
      appBar: AppBar(
          backgroundColor: Cores.corHover,
          title: Row(
            children: [
              Positioned(
                child: Image.asset(
                  'assets/images/icone.png',
                  width: 75,
                ),
              )
            ],
          )),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      Cores.corTerciaria,
                      Cores.corPrimaria
                          .withOpacity(0.0), // Cor com transparência
                    ], center: Alignment.topLeft, radius: 1),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(1000.0),
                    ),
                  ),
                ),
              ],
            ),
            app,
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    Cores.corTerciaria,
                    Cores.corPrimaria.withOpacity(0.0), // Cor com transparência
                  ], center: Alignment.bottomRight, radius: 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(1000.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Modulos extends StatelessWidget {
  const Modulos({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(ListView(children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 35),
              child: const Text(
                'MÓDULOS:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 20),
                child: Card(modulos[0], modImagens[0], linkImagens[0]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 20),
                child: Card(modulos[1], modImagens[1], linkImagens[1]),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: Card(modulos[2], modImagens[2], linkImagens[2]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: Card(modulos[3], modImagens[3], linkImagens[3]),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: Card(modulos[4], modImagens[4], linkImagens[4]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: Card(modulos[5], modImagens[5], linkImagens[5]),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: Card(modulos[6], modImagens[6], linkImagens[6]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: Card(modulos[7], modImagens[7], linkImagens[7]),
              ),
            ]),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.only(top: 15),
              child: Card(modulos[8], modImagens[8], linkImagens[8]),
            ),
          ]),
    ]));
  }
}

class Suporte extends StatelessWidget {
  const Suporte({super.key});

  @override
  Widget build(BuildContext context) {
    return NavBar(
      Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 35),
                child: Text(
                  'PRECISA DE AJUDA?',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                    color: Cores.corExtra2,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  )),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 30),
                child: Text(
                  'Fale com um de nossos professores',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardContato('dean', 'DEAN WINCHESTER', 'INSTRUTOR DE CAÇA'),
                  CardContato('sam', 'SAMUEL WINCHESTER', 'ANALISTA DE CASOS'),
                ]),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardContato('bobby', 'ROBERT SINGER', 'MITOLOGISTA'),
                    CardContato('castiel', 'CASTIEL', 'GUARDIÃO CELESTIAL'),
                  ]),
            ),
          ]),
    );
  }
}

class CardContato extends StatelessWidget {
  final String imagem;
  final String nome;
  final String cargo;
  const CardContato(this.imagem, this.nome, this.cargo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.425,
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/images/$imagem.png')),
        border: Border.all(
            color: Colors.white, // Set border color
            width: 1.0), // Set border width
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(nome,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Cores.corExtra2,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            )),
        Container(
          padding: const EdgeInsets.only(bottom: 10, top: 5),
          child: Text(
            cargo,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 11,
            )),
          ),
        ),
      ]),
    );
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

List<Widget> linkImagens = [
  const Materiais(),
  const Instrucoes(),
  const Investigacao(),
  const Mitologia(),
  const Fantasmas(),
  const Monstros(),
  const Demonios(),
  const Anjos(),
  const Divindades(),
];
