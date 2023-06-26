import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
            ),
            app,
          ],
        ),
      ),
    );
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
        itemTextPadding: const EdgeInsets.only(left: 20),
        selectedItemTextPadding: const EdgeInsets.only(left: 20),
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
              return const Home();
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
          icon: Icons.support_agent,
          label: 'Suporte',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Suporte();
            }));
          },
        ),
        SidebarXItem(
          /*iconWidget: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              width: 25,
              height: 25,
              child: Image.asset(
                'assets/images/user.png',
              ),
            ),
          ),*/
          icon: Icons.person,
          label: 'Conta',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Conta();
            }));
          },
        ),
      ],
    );
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
        child: Text('DESTAQUES',
            style: GoogleFonts.kronaOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
            )),
      ),
      CarouselSlider(
        items: modulos.asMap().entries.map((i) {
          final int posicao = i.key;
          final String modulo = modulos[posicao].nome;
          final String imagem = modulos[posicao].imagem;
          final Widget link = Conta();

          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.90,
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                child: CardCarrossel(modulo, imagem, link),
              );
            },
          );
        }).toList(),
        carouselController: _controle,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(milliseconds: 7500),
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

class CardCarrossel extends StatelessWidget {
  final String modulo;
  final String imagem;
  final Widget link;
  const CardCarrossel(this.modulo, this.imagem, this.link, {super.key});

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
                      child: Text(modulo,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Cores.corExtra2,
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                            ),
                          )),
                    ),
                  ],
                ))));
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

class Modulos extends StatelessWidget {
  const Modulos({super.key});
  static const Widget link = Conta();

  @override
  Widget build(BuildContext context) {
    return NavBar(ListView(children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 35),
              child: Text('MÓDULOS',
                  style: GoogleFonts.kronaOne(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  )),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 20),
                child: CardCarrossel(modulos[0].nome, modulos[0].imagem, link),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 20),
                child: CardCarrossel(modulos[1].nome, modulos[1].imagem, link),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: CardCarrossel(modulos[2].nome, modulos[2].imagem, link),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: CardCarrossel(modulos[3].nome, modulos[3].imagem, link),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: CardCarrossel(modulos[4].nome, modulos[4].imagem, link),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: CardCarrossel(modulos[5].nome, modulos[5].imagem, link),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: CardCarrossel(modulos[6].nome, modulos[6].imagem, link),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: 15),
                child: CardCarrossel(modulos[7].nome, modulos[7].imagem, link),
              ),
            ]),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.only(top: 15),
              child: CardCarrossel(modulos[8].nome, modulos[8].imagem, link),
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
                child: Text('PRECISA DE AJUDA?',
                    style: GoogleFonts.kronaOne(
                      textStyle: const TextStyle(
                        color: Cores.corExtra2,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    )),
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                onTap: () => informacoesContato(context, professores[0]),
                child: const CardContato(
                    'dean', 'DEAN WINCHESTER', 'INSTRUTOR DE CAÇA'),
              ),
              GestureDetector(
                onTap: () => informacoesContato(context, professores[1]),
                child: const CardContato(
                    'sam', 'SAMUEL WINCHESTER', 'ANALISTA DE CASOS'),
              )
            ]),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => informacoesContato(context, professores[2]),
                      child: const CardContato(
                          'bobby', 'ROBERT SINGER', 'MITOLOGISTA'),
                    ),
                    GestureDetector(
                      onTap: () => informacoesContato(context, professores[3]),
                      child: const CardContato(
                          'castiel', 'CASTIEL', 'GUARDIÃO CELESTIAL'),
                    ),
                  ]),
            ),
          ]),
    );
  }
}

void informacoesContato(BuildContext context, Professor professor) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: Theme.of(context).copyWith(
                dialogBackgroundColor: Cores.corPrimaria.withAlpha(0)),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Cores.corPrimaria.withAlpha(220),
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        professor.nome,
                        style: GoogleFonts.kronaOne(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Cores.corExtra2,
                          fontSize: 20,
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(children: [
                                        Container(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: const Icon(
                                              FontAwesomeIcons.envelope,
                                              color: Cores.corExtra2,
                                              size: 20,
                                            )),
                                        Text(
                                          'Email:',
                                          style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                      Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          professor.email,
                                          style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                              ]),
                          Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(children: [
                                    Row(children: [
                                      Container(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: const Icon(
                                            FontAwesomeIcons.whatsapp,
                                            color: Cores.corExtra2,
                                            size: 20,
                                          )),
                                      Text(
                                        'Telefone:',
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 15,
                                        )),
                                      ),
                                    ]),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        professor.telefone,
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                      ),
                                    ),
                                  ]),
                                ]),
                          ),
                        ]),
                      ),
                    ]),
              ),
            )
            // Adicione outras informações de contato aqui, se necessário
            );
      });
}

class Conta extends StatelessWidget {
  const Conta({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavBar(TelaLogin());
  }
}

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});
  Duration get tempoLogin => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Nome: ${data.name}, Senha: ${data.password}');
    return Future.delayed(tempoLogin).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Usuário não encontrado';
      }
      if (users[data.name] != data.password) {
        return 'A senha não coincide';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Nome: ${data.name}, Senha: ${data.password}');
    return Future.delayed(tempoLogin).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String nome) {
    debugPrint('Nome: $nome');
    return Future.delayed(tempoLogin).then((_) {
      if (!users.containsKey(nome)) {
        return 'Usuário não registrado';
      }
      return 'null';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Winchester APP',
      theme: LoginTheme(
        primaryColor: Cores.corExtra,
        accentColor: Cores.corExtra2,
        errorColor: Colors.red,
        titleStyle: GoogleFonts.kronaOne(
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 35)),
        buttonTheme: LoginButtonTheme(
          splashColor: Cores.corTerciaria,
          backgroundColor: Cores.corExtra,
          highlightColor: Cores.corTerciaria,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        pageColorDark: Cores.corExtra.withAlpha(0),
        pageColorLight: Cores.corExtra.withAlpha(0),
        logoWidth: 0.8,
      ),
      messages: LoginMessages(
          userHint: 'Email',
          passwordHint: 'Senha',
          confirmPasswordHint: 'Confirme a senha',
          signupButton: 'Cadastre-se',
          forgotPasswordButton: 'Esqueceu sua senha?',
          recoverPasswordButton: 'Enviar',
          recoverPasswordDescription: 'Um link de recuperação será enviado',
          recoverPasswordIntro: 'Recupere sua senha',
          goBackButton: 'Voltar',
          confirmPasswordError: 'Senhas não coincidem',
          providersTitleFirst: 'ou entre com',
          recoverPasswordSuccess:
              'Um email de recuperação foi enviado, confira sua caixa de entrada'),
      logo: const AssetImage('assets/images/wcacademy.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            debugPrint('start google sign in');
            await Future.delayed(tempoLogin);
            debugPrint('stop google sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      },
      disableCustomPageTransformer: true,
      onRecoverPassword: _recoverPassword,
    );
  }
}

//variaveis globais utilizadas no desenvolvimento
class Cores {
  static const Color corPrimaria = Color.fromARGB(255, 14, 14, 14);
  static const Color corSecundaria = Color.fromARGB(255, 246, 246, 246);
  static const Color corTerciaria = Color.fromARGB(255, 8, 156, 198);
  static const Color corExtra = Color.fromARGB(255, 8, 82, 104);
  static const Color corExtra2 = Color.fromARGB(255, 0, 199, 255);
  static const Color corHover = Color.fromARGB(255, 37, 37, 37);
}

List<ListaModulos> modulos = [
  ListaModulos('UTILITÁRIOS', 'materiais.png'),
  ListaModulos('CAÇADAS', 'caca.png'),
  ListaModulos('INVESTIGAÇÃO', 'investigacao.png'),
  ListaModulos('MITOLOGIA', 'mitologia.png'),
  ListaModulos('FANTASMAS', 'fantasmas.png'),
  ListaModulos('MONSTROS', 'monstros.png'),
  ListaModulos('DEMÔNIOS', 'demonios.png'),
  ListaModulos('ANJOS', 'anjos.png'),
  ListaModulos('DIVINDADES', 'divindades.png'),
];

class ListaModulos {
  String nome;
  String imagem;
  ListaModulos(this.nome, this.imagem);
}

List<Professor> professores = [
  Professor('DEAN WINCHESTER', 'deanwinchester@winchesteracademy.com.br',
      '(11)98206-7492'),
  Professor('SAMUEL WINCHESTER', 'samuelwinchester@winchesteracademy.com.br',
      '(11)98600-4585'),
  Professor('ROBERT SINGER', 'robertsinger@winchesteracademy.com.br',
      '(11)99212-8222'),
  Professor('CASTIEL', 'castiel@winchesteracademy.com.br', '(11)99876-6363'),
];

class Professor {
  String nome;
  String email;
  String telefone;

  Professor(this.nome, this.email, this.telefone);
}

const users = {
  'lucasalvarengalopes@gmail.com': '25032004',
};
