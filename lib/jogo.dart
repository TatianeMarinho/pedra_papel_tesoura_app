import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png"); // imagem do app
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
        _mensagem = "O App Ganhou! 😢";
        _pontosApp++;
      }
    });
  }

  // reseta a rodada limpando imagem e mensagem
  void _novaRodada() {
    setState(() {
      _imagemApp = AssetImage("images/padrao.png");
      _mensagem = "Esolha uma opção abaixo:";
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
    return Scaffold(
      appBar: AppBar(title: Text("Pedra, Papel & Tesoura")),
      body: SingleChildScrollView(
        //garante que caiba em telas menores
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //escolha do app
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 10),
              child: Text(
                "Escolha do App",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Image(image: _imagemApp, height: 85),
            //mensagem de instruçao e de resultado
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 20),
              child: Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 35),
            //opçoes usuario e borda verde
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
            const SizedBox(height: 60),

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

            const Divider(
              height: 40,
              thickness: 2,
            ), // linha para separar o placar

            const Text(
              "PLACAR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
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
                  const Text(
                    "VS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      const Text("App"),
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
            ),
          ],
        ),
      ),
    );
  }
}
