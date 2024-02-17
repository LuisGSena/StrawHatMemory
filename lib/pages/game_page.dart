import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/controllers/game_controller.dart';
import 'package:strawhat_memory/game_settings.dart';
import 'package:strawhat_memory/models/game_opcao.dart';
import 'package:strawhat_memory/models/game_play.dart';
import 'package:strawhat_memory/widgets/card_game.dart';
import 'package:strawhat_memory/widgets/feedback_game.dart';
import 'package:strawhat_memory/widgets/game_score.dart';


class GamePage extends StatelessWidget {
  final Gameplay gameplay;

  const GamePage({
    Key? key,
    required this.gameplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GameScore(modo: gameplay.modo),
      ),
   
      body: Observer(
        builder: (_) {
          if(controller.venceu) {
            return const FeedbackGame(resultado: Resultado.aprovado);
          }else if(controller.perdeu) {
            return const FeedbackGame(resultado: Resultado.eliminado);
          }else {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: GameSettings.gameBoardAxisCount(gameplay.nivel),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children: controller.gameCards.map((GameOpcao go) => CardGame(modo: gameplay.modo, gameOpcao: go)).toList(),
              ),
            );
          }
        }
      ),
      
    );
        
}
}
