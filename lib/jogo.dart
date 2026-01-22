import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/droidy.png"); // imagem do app
  var _mensagem = "Escolha uma opção abaixo"; // mensagem que aparece no app
  var _escolhaUsuario = ""; //guarda o que clicou

  int _pontosJogador = 0;
  int _pontosApp = 0;

  // marca o que o usurario escolheu sem rodar o jogo
  void _selecionarOpcao(String escolha) {
    setState(() {
      _escolhaUsuario = escolha;
      _mensagem = "Opção selecionada! Clique em JOKENPÔ";
    });
  }

  //Botão jokenpo executa a logica e soma os pontos
  void _jogar() {
    if (_escolhaUsuario == "") {
      setState(() => _mensagem = "Selecione uma opção primeiro!");
      return;
    }

    var opcoes = ["pedra", "papel", "tesoura"];
    var escolhaApp = opcoes[Random().nextInt(opcoes.length)];

    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");

      if (_escolhaUsuario == escolhaApp) {
        _mensagem = "Empate! 🤝";
      } else if ((_escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
          (_escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
          (_escolhaUsuario == "papel" && escolhaApp == "pedra")) {
        _mensagem = "Você Ganhou! 🎉";
        _pontosJogador++;
      } else {
        _mensagem = "Droidy Ganhou! 😢";
        _pontosApp++;
      }
    });
  }

  // reseta a rodada limpando imagem e mensagem
  void _novaRodada() {
    setState(() {
      _imagemApp = AssetImage("images/droidy.png");
      _mensagem = "Escolha uma opção abaixo:";
      _escolhaUsuario = "";
    });
  }

  //zera o placar total
  void _zerarPlacar() {
    setState(() {
      _pontosApp = 0;
      _pontosJogador = 0;
      _novaRodada();
    });
  }

  //funcao auxiliar para criar a borda ao clicar
  BoxDecoration _estiloBorda(String opcao) {
    return BoxDecoration(
      border: Border.all(
        color: _escolhaUsuario == opcao ? Colors.green : Colors.amber,
        width: 4,
      ),
      borderRadius: BorderRadius.circular(50),
    );
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Pedra, Papel & Tesoura")),
      body: SingleChildScrollView(
        //garante que caiba em telas menores
        child: Container(
          constraints: BoxConstraints(minHeight: alturaTela - 200),
          //define que o container vai tertodo o espaço da tela menos o appbar e o bottombar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // bloco1:escolha do droidy
              Column(
                children: [
                  const Text(
                    "Escolha do Droidy",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), //respiro interno
                  Image(image: _imagemApp, height: 85),
                ],
              ),

              // bloco 2:mensagem de instruçao e de resultado
              Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              //bloco 3:opçoes usuario e borda verde
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _selecionarOpcao("pedra"),
                    child: Container(
                      decoration: _estiloBorda("pedra"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset("images/pedra.png", height: 75),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selecionarOpcao("papel"),
                    child: Container(
                      decoration: _estiloBorda("papel"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset("images/papel.png", height: 75),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selecionarOpcao("tesoura"),
                    child: Container(
                      decoration: _estiloBorda("tesoura"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset("images/tesoura.png", height: 75),
                      ),
                    ),
                  ),
                ],
              ),

              //bloco 4: botoes de açao
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Botao jokenpo
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 3),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: GestureDetector(
                        onTap: _jogar,
                        child: Image.asset("images/jokenpo.jpeg", height: 65),
                      ),
                    ),
                  ),
                  //botao nova rodada
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        size: 45,
                        color: Colors.blue,
                      ),
                      onPressed: _novaRodada,
                      tooltip: "Nova Rodada",
                    ),
                  ),
                  //botao zerar placar
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 45,
                        color: Colors.red,
                      ),
                      onPressed: _zerarPlacar,
                      tooltip: "Nova Rodada",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, -4), //cria sombra para cima
            ),
          ],
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "PLACAR",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text("Você"),
                    Text(
                      "$_pontosJogador",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const Text("VS", style: TextStyle(fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    const Text("Droidy"),
                    Text(
                      "$_pontosApp",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
