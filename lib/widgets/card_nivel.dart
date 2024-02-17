import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/controllers/game_controller.dart';
import 'package:strawhat_memory/models/game_play.dart';
import 'package:strawhat_memory/pages/game_page.dart';
import 'package:strawhat_memory/theme.dart';

class CardNivel extends StatelessWidget {
  final Gameplay gamePlay;

const CardNivel({
  Key? key, 
  required this.gamePlay,
  }): super(key: key);

  startGame(BuildContext context) {
    context.read<GameController>().startGame(gameplay: gamePlay);
    
    Navigator.push(
      context,
      MaterialPageRoute(fullscreenDialog: true,
      builder: (BuildContext context) => GamePage(gameplay: gamePlay),
      ),
     );

  }

  @override
  Widget build(BuildContext context){
    
    return InkWell(
      onTap: () =>startGame(context),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(
            color: gamePlay.modo == Modo.normal? Colors.white : StrawhatMemoryTheme.color
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: gamePlay.modo == Modo.normal? Colors.transparent : StrawhatMemoryTheme.color.withOpacity(.6),
        ),
        child: Center(
          child: Text(gamePlay.nivel.toString(), style:  const TextStyle(
            fontSize: 30
            ),
          ) 
        ),
      ),
    );
  }
}