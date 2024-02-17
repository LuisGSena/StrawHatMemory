import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/models/game_play.dart';

part 'recordes_repository.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store{
  late final Box _recordes;
  late final Gameplay gamePlay;
  @observable
  Map recordesYonkou = {};
  @observable
  Map recordesNormal = {};

  RecordesRepositoryBase(){
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadRecordes();
  }

  _initDatabase() async {
    _recordes = await Hive.openBox('gameRecordes');
  }

  @action
  loadRecordes(){
    recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    recordesYonkou = _recordes.get(Modo.Yonkou.toString()) ?? {};
  }
  
  updateRecordes({required Gameplay gameplay, required int score}){
    final key = gameplay.modo.toString();

    if(gameplay.modo == Modo.normal && (recordesNormal[gameplay.nivel] == null || score< recordesNormal[gameplay.nivel])){
      recordesNormal[gameplay.nivel] = score;
      _recordes.put(key, recordesNormal);
    } else if(gameplay.modo == Modo.Yonkou && (recordesYonkou[gameplay.nivel] == null || score > recordesYonkou[gameplay.nivel])){
      recordesYonkou[gameplay.nivel] = score;
      _recordes.put(key, recordesYonkou);
    }
  }
}