import 'package:flutter/material.dart';

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
        home: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    color: Colors.black,
                    width: 300,
                    height: 300,
                  ),
                  Container(
                    color: Colors.red,
                    height: 150,
                    width: 150,
                  ),
                  Container(
                    color: Colors.blue,
                    height: 75,
                    width: 75,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 37,
                    width: 37,
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Quem apertar o botão é gay',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('gay');
                    },
                    child: const Text('Tá avisado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.deepOrange,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.deepOrange,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.deepOrange,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
