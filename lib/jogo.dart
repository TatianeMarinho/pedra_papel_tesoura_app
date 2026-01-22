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
    bool selecionado = _escolhaUsuario == opcao;

    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: selecionado ? Colors.green : Colors.amber,
        width: 4,
      ),
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(
          //verde selecinado e amarelo quando nao
          color: selecionado
              ? Colors.green.withValues(alpha: 0.6)
              : Colors.amber.withValues(alpha: 0.4),
          blurRadius: selecionado ? 15 : 10, //brilho da sombra
          spreadRadius: selecionado ? 5 : 3, //expansao da sombra
          offset: const Offset(0, 0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "images/droidybar.png",
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              "DroidyPô",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
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
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.cyan, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withValues(alpha: 0.4),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image(image: _imagemApp, fit: BoxFit.contain),
                      ),
                    ),
                  ),
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
                      height: 85,
                      width: 85,
                      decoration: _estiloBorda("pedra"),
                      child: ClipOval(
                        child: Image.asset(
                          "images/pedra.png",
                          fit: BoxFit.cover, //faz a imagem preencher o circulo
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selecionarOpcao("papel"),
                    child: Container(
                      height: 85,
                      width: 85,
                      decoration: _estiloBorda("papel"),
                      child: ClipOval(
                        child: Image.asset(
                          "images/papel.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selecionarOpcao("tesoura"),
                    child: Container(
                      height: 85,
                      width: 85,
                      decoration: _estiloBorda("tesoura"),
                      child: ClipOval(
                        child: Image.asset(
                          "images/tesoura.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //bloco 4: botoes de açao
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Botao droidpo
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 3),
                      shape: BoxShape.circle,
                      //usa a forma circulo no proprio container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.5),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: _jogar,
                        child: Image.asset(
                          "images/droidypo.png",
                          fit: BoxFit
                              .cover, //faz a imagem preencher o circulo sem esticar
                        ),
                      ),
                    ),
                  ),
                  //botao nova rodada
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
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
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 45,
                        color: Colors.red,
                      ),
                      onPressed: _zerarPlacar,
                      tooltip: "zerar placar",
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
          color: Colors.amber,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, -4), //cria sombra para cima
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                "PLACAR",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
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
                        fontSize: 20,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
