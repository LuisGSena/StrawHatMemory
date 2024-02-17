import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/controllers/game_controller.dart';
import 'package:strawhat_memory/widgets/start_button.dart';

class FeedbackGame extends StatelessWidget {
  final Resultado resultado;
  const FeedbackGame({Key? key, required this.resultado}) : super(key: key);

  String getResultado() {
    return resultado == Resultado.aprovado ? 'VOCÊ VENCEU!' : 'WASTED';

  }
    @override
    Widget build(BuildContext context) {
      var caminhoImagem = '';
      if(getResultado() == "VOCÊ VENCEU!") {
        caminhoImagem = "aprovado";
      }else {
        caminhoImagem = "eliminado";
      }
      final controller = context.read<GameController>();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${getResultado().toUpperCase()}!',
              style: const TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Image.asset('images/$caminhoImagem.jpg'),
            ),
            resultado == Resultado.eliminado
                ? StartButton(
                    title: 'Tentar novamente', 
                    color: Colors.white, 
                    action: () => controller.restartGame(),
                  )
                  : StartButton(
                      title: 'Próximo nível', 
                      color: Colors.white, 
                      action: () => controller.nextLevel(),
                    )
          ],
        ),
      );
    }
}