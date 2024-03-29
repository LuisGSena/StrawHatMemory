import 'package:flutter/material.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/game_settings.dart';
import 'package:strawhat_memory/models/game_play.dart';
import 'package:strawhat_memory/widgets/card_nivel.dart';

class NivelPage extends StatelessWidget {
  final Modo modo;

 const NivelPage({Key? key, required this.modo}) : super(key: key);

  
  @override
  Widget build(BuildContext context){
    final niveis = GameSettings.niveis.map((n)=> CardNivel(gamePlay: Gameplay(modo: modo, nivel: n))).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nivel do Jogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: const EdgeInsets.all(24),
          children: niveis,
        ),
      ),
    );
  }
}