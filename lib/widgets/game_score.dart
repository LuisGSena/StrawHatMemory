import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/controllers/game_controller.dart';

class GameScore extends StatelessWidget {
  final Modo modo;
  const GameScore ({Key? key, required this.modo}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);
  return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(modo == Modo.Yonkou ? Icons.my_location : Icons.touch_app_rounded),
                const SizedBox(width: 10),
                Observer(builder: (_) => Text(controller.score.toString(), style: const TextStyle(fontSize: 25))),
              ],
            ),
            Image.asset(modo == Modo.Yonkou ? 'images/bandeiraYonkou.png' : 'images/bandeira.png', width: 80, height:60,),
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text(
                'Voltar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );

}
}