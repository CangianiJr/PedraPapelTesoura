import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pedra_papel_tesoura/app/icons/options_icons_icons.dart';
import 'package:pedra_papel_tesoura/app/rotinas/logica_jogo_rotina.dart';
import 'package:pedra_papel_tesoura/app/constants/opcoes_constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pontuacaoVoce = 0;
  int pontuacaoComputador = 0;
  int pontuacaoEmpate = 0;
  int? _opcaoComputador;
  int _pedra = 0;
  bool _bloqueiaPedra = false;

  void _jogar(int opcaoVoce) {
    if (opcaoVoce == Opcoes.pedra) {
      _pedra++;
      if (_pedra == 2) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Não pode jogar pedra duas vezes seguidas",
                textAlign: TextAlign.center,
              ),
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                side: BorderSide(
                  color: Colors.yellow.shade400,
                  width: 3,
                ),
              ),
              content: Icon(
                Icons.error,
                size: 100,
                color: Colors.yellow.shade400,
              ),
              contentPadding: const EdgeInsets.all(8),
            );
          },
        );
        setState(() {
          _bloqueiaPedra = true;
        });
        return;
      }
    } else {
      _pedra = 0;
      setState(() {
        _bloqueiaPedra = false;
      });
    }
    setState(() {
      _opcaoComputador = Random().nextInt(3);
    });

    int resultado = Logica().jogar(opcaoVoce, _opcaoComputador);

    switch (resultado) {
      case Logica.empate:
        setState(() {
          pontuacaoEmpate++;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Embate",
                textAlign: TextAlign.center,
              ),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.yellow.shade800,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                side: BorderSide(
                  color: Colors.yellow.shade800,
                  width: 3,
                ),
              ),
              contentPadding: const EdgeInsets.all(8),
            );
          },
        );
        break;
      case Logica.voce:
        setState(() {
          pontuacaoVoce++;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                "Você venceu",
                textAlign: TextAlign.center,
              ),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                side: BorderSide(
                  color: Colors.green,
                  width: 3,
                ),
              ),
              contentPadding: EdgeInsets.all(8),
            );
          },
        );
        break;
      case Logica.computador:
        setState(() {
          pontuacaoComputador++;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                "Computador venceu",
                textAlign: TextAlign.center,
              ),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                side: BorderSide(
                  color: Colors.red,
                  width: 3,
                ),
              ),
              contentPadding: EdgeInsets.all(8),
            );
          },
        );
        break;
      default:
        break;
    }
  }

  Widget? _iconeComputador(int? opcao) {
    switch (opcao) {
      case Opcoes.pedra:
        return const Icon(
          OptionsIcons.hand_rock,
          size: 100,
          color: Colors.yellow,
        );
      case Opcoes.papel:
        return const Icon(
          OptionsIcons.hand_paper,
          size: 100,
          color: Colors.yellow,
        );
      case Opcoes.tesoura:
        return const Icon(
          OptionsIcons.hand_scissors,
          size: 100,
          color: Colors.yellow,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedra Papel Tesoura"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              "Escolha do App",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(5),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: _iconeComputador(_opcaoComputador),
            ),
            const Text(
              "Escolha uma opção abaixo",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      onPressed:
                          !_bloqueiaPedra ? () => _jogar(Opcoes.pedra) : null,
                      icon: const Icon(OptionsIcons.hand_rock),
                      iconSize: 70,
                      color: Colors.yellow,
                      disabledColor:
                          !_bloqueiaPedra ? null : Colors.grey.shade200,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        _jogar(Opcoes.papel);
                      },
                      icon: const Icon(OptionsIcons.hand_paper),
                      iconSize: 70,
                      color: Colors.yellow,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        _jogar(Opcoes.tesoura);
                      },
                      icon: const Icon(OptionsIcons.hand_scissors),
                      iconSize: 70,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Você: $pontuacaoVoce",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              "Computador: $pontuacaoComputador",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              "Empate: $pontuacaoEmpate",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
