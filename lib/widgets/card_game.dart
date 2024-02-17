import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/controllers/game_controller.dart';
import 'package:strawhat_memory/models/game_opcao.dart';
import 'package:strawhat_memory/theme.dart';

class CardGame extends StatefulWidget {
  final Modo modo;
  final GameOpcao gameOpcao;

  const CardGame({
    Key? key,
    required this.modo,
    required this.gameOpcao,
  }) : super(key: key);
  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> with SingleTickerProviderStateMixin{
  late final AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 400),
      // upperBound: 5,
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  flipCard() {
    final game = context.read<GameController>();

    if(!animation.isAnimating && !widget.gameOpcao.matched && !widget.gameOpcao.selected && !game.jogadaCompleta) {
      animation.forward();
      game.escolher(widget.gameOpcao, resetCard);
    }
  }

  resetCard() {
    animation.reverse();
  }

  AssetImage getImage(double angulo) {
    if(angulo > 0.5 * pi) {
      return AssetImage('images/${widget.gameOpcao.opcao.toString()}.jpg');
    }else {
      return widget.modo == Modo.normal ? const AssetImage('images/fundocarta.jpg') : const AssetImage('images/fundo_yonkou.jpg');
    }
  }

  @override
  Widget build(BuildContext context){
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) {
        final angulo = animation.value * pi;
        final transform = Matrix4.identity()
        ..setEntry(3, 2,0.001)
        ..rotateY(angulo);
        
        return GestureDetector(
          onTap: () => flipCard(),
          child: Transform(
            transform: transform,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.modo == Modo.normal? Colors.white : StrawhatMemoryTheme.color,
                  width: 1,
                ),
                borderRadius:  const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: getImage(angulo),
                ),
              ),
            ),
          ),
        );
    });
  }
}