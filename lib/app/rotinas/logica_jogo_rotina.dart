import 'package:pedra_papel_tesoura/app/constants/opcoes_constant.dart';

class Logica {
  static const int empate = 0;
  static const int voce = 1;
  static const int computador = 2;

  jogar(int opcaoVoce, opcaoComputador) {
    if (opcaoVoce == opcaoComputador) {
      return empate;
    } else if ((opcaoVoce == Opcoes.papel && opcaoComputador == Opcoes.pedra) ||
        (opcaoVoce == Opcoes.tesoura && opcaoComputador == Opcoes.papel) ||
        (opcaoVoce == Opcoes.pedra && opcaoComputador == Opcoes.tesoura)) {
      return voce;
    } else {
      return computador;
    }
  }
}
