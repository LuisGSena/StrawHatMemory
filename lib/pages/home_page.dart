import 'package:flutter/material.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/pages/nivel_page.dart';
import 'package:strawhat_memory/theme.dart';
import 'package:strawhat_memory/widgets/logo.dart';
import 'package:strawhat_memory/widgets/start_button.dart';
import 'package:strawhat_memory/widgets/recordes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
             StartButton(title: 'Modo Normal', color: Colors.white, action: () => Navigator.push(context, 
              MaterialPageRoute(
                builder: (BuildContext context) => const NivelPage(modo: Modo.normal),
              ),
             ),
             ),
             StartButton(title: 'Modo Yonkou', color: StrawhatMemoryTheme.color, action: () => Navigator.push(context, 
                MaterialPageRoute(
                  builder: (BuildContext context) => const NivelPage(modo: Modo.Yonkou),
                ),
              ),
             ),
             const SizedBox(height: 60),
             const Recordes()
          ],
        ),
      ),
    );
  }
}
