import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:strawhat_memory/controllers/game_controller.dart';
import 'package:strawhat_memory/pages/home_page.dart';
import 'package:strawhat_memory/repositories/recordes_repository.dart';
import 'package:strawhat_memory/theme.dart';

void main() async {
  await Hive.initFlutter(); 
  runApp(
    MultiProvider(
      providers: [
        Provider<RecordesRepository>(create: (_) => RecordesRepository()),
        ProxyProvider<RecordesRepository, GameController>(update: (_, repo, __) => GameController(recordesRespository: repo),
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strawhat Memory',
      debugShowCheckedModeBanner: false,
      theme: StrawhatMemoryTheme.theme,
      home: const HomePage(),
    );
  }
}