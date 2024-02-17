import 'package:mobx/mobx.dart';
import 'package:strawhat_memory/config.dart';
import 'package:strawhat_memory/game_settings.dart';
import 'package:strawhat_memory/models/game_opcao.dart';
import 'package:strawhat_memory/models/game_play.dart';
import 'package:strawhat_memory/repositories/recordes_repository.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store{
  @observable
  List<GameOpcao> gameCards = [];
  @observable
  int score = 0;
  @observable
  bool venceu = false;
  @observable
  bool perdeu = false;

  late Gameplay _gamePlay;
  List<GameOpcao> _escolha = [];
  List<Function> _escolhaCallBack = [];
  int _acertos = 0;
  int _numPares = 0;
  RecordesRepository recordesRespository;

  @computed
  bool get jogadaCompleta => (_escolha.length == 2);

  GameControllerBase({required this.recordesRespository}){
    reaction((_) => venceu == true, (bool ganhou){
      if(ganhou){
        recordesRespository.updateRecordes(gameplay: _gamePlay, score: score);
      }
    });
  }

  startGame ({required Gameplay gameplay}){
    _gamePlay = gameplay;
    _acertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    venceu = false;
    perdeu = false;
    _resetScore();
    _generateCards();
  }

  _resetScore() {
    _gamePlay.modo == Modo.normal ? score = 0 : score = _gamePlay.nivel;
  }

  _generateCards(){
    List<int> cardOpcoes = GameSettings.cardOpcoes.sublist(0)..shuffle();
    cardOpcoes = cardOpcoes.sublist(0, _numPares);
    gameCards = [...cardOpcoes, ...cardOpcoes].map((opcao) => GameOpcao(opcao: opcao, matched: false, selected: false)).toList();

    gameCards.shuffle();
  }

  escolher(GameOpcao opcao, Function resetCard) async {
    opcao.selected = true;
    _escolha.add(opcao);
    _escolhaCallBack.add(resetCard);
    await _compararEscolhar();
  }

  _compararEscolhar() async {
    if(jogadaCompleta) {
      if(_escolha[0].opcao == _escolha[1].opcao) {
        _acertos++;
        _escolha[0].matched = true;
        _escolha[1].matched = true;
      }else {
        await Future.delayed(const Duration(seconds: 1), () {
          for(var i in [0, 1]) {
            _escolha[i].selected = false;
            _escolhaCallBack[i]();
          }
        });
      }

      _resetJogada();
      _updateScore();
      _checkGameResult();
    }
  }

  _resetJogada() {
    _escolha = [];
    _escolhaCallBack = [];
  }

  _updateScore() {
    _gamePlay.modo == Modo.normal ? score++ : score--;
  }

  restartGame() {
    startGame(gameplay: _gamePlay);
  }

  nextLevel() {
    int nivelIndex = 0;

    if(_gamePlay.nivel != GameSettings.niveis.last) {
      nivelIndex = GameSettings.niveis.indexOf(_gamePlay.nivel) + 1;
    }

    _gamePlay.nivel = GameSettings.niveis[nivelIndex];
    startGame(gameplay: _gamePlay);
  }

  _checkGameResult() async {
    bool allMatched = _acertos == _numPares;
    if(_gamePlay.modo == Modo.normal) {
      await _checkResultModoNormal(allMatched);
    }else {
      await _checkResultModoYonkou(allMatched);
    }
  }

  _checkResultModoNormal(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1), () => {
      venceu = allMatched
    });
  }

  _checkResultModoYonkou(bool allMatched) async {
    if(_chancesAcabaram()) {
      await Future.delayed(const Duration(milliseconds: 400), () => perdeu = true);
    }

    if(allMatched && score >= 0){
      await Future.delayed(const Duration(milliseconds: 400), () => venceu = allMatched);
    }
  }

  _chancesAcabaram() {
    return score < _numPares - _acertos;
  }
}