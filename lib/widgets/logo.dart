import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(bottom: 0), child: Image.asset("images/logo.png", width:350, height: 330,))
      ],
    );
  }
}