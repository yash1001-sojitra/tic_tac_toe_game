import 'package:flutter/material.dart';

import '../widgets/aleart_diagloag.dart';
import '../core/constant.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const HomeBackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _clearBoard();
                _clearScore();
              },
            )
          ],
          title: Text(
            'Tic Tac Toe',
            style: CustomText(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildPointsTable(),
            _buildGrid(),
            _buildTurn(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildPointsTable() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              children: [
                Text(
                  'Player O',
                  style: CustomText(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _scoreO.toString(),
                  style: CustomText(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              children: [
                Text(
                  'Player X',
                  style: CustomText(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _scoreX.toString(),
                  style: CustomText(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Expanded(
      flex: 3,
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _tapped(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white12),
                child: Center(
                  child: Text(
                    _xOrOList[index],
                    style: TextStyle(
                      color:
                          _xOrOList[index] == 'x' ? Colors.white : Colors.red,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildTurn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          _turnOfO ? 'Turn of O' : 'Turn of X',
          style: CustomText(color: Colors.white),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (_turnOfO && _xOrOList[index] == '') {
        _xOrOList[index] = 'o';
        _filledBoxes += 1;
      } else if (!_turnOfO && _xOrOList[index] == '') {
        _xOrOList[index] = 'x';
        _filledBoxes += 1;
      }

      _turnOfO = !_turnOfO;
      _checkTheWinner();
    });
  }

  void _checkTheWinner() {
    // check first row
    if (_xOrOList[0] == _xOrOList[1] &&
        _xOrOList[0] == _xOrOList[2] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second row
    if (_xOrOList[3] == _xOrOList[4] &&
        _xOrOList[3] == _xOrOList[5] &&
        _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      return;
    }

    // check third row
    if (_xOrOList[6] == _xOrOList[7] &&
        _xOrOList[6] == _xOrOList[8] &&
        _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      return;
    }

    // check first column
    if (_xOrOList[0] == _xOrOList[3] &&
        _xOrOList[0] == _xOrOList[6] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second column
    if (_xOrOList[1] == _xOrOList[4] &&
        _xOrOList[1] == _xOrOList[7] &&
        _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      return;
    }

    // check third column
    if (_xOrOList[2] == _xOrOList[5] &&
        _xOrOList[2] == _xOrOList[8] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    // check diagonal
    if (_xOrOList[0] == _xOrOList[4] &&
        _xOrOList[0] == _xOrOList[8] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check diagonal
    if (_xOrOList[2] == _xOrOList[4] &&
        _xOrOList[2] == _xOrOList[6] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'The match ended in a draw'
            : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
  }

  void _clearScore() {
    _scoreO = 0;
    _scoreX = 0;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOrOList[i] = '';
      }
    });

    _filledBoxes = 0;
  }
}

class HomeBackgroundImage extends StatelessWidget {
  const HomeBackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.26)],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homeback.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
