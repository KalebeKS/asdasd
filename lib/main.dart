import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;

  void _clear() {
    setState(() {
      _output = "0";
      _input = "";
      _operator = "";
      _num1 = 0;
      _num2 = 0;
    });
  }

  void _appendNumber(String number) {
    setState(() {
      if (_input.length < 12) {
        _input += number;
        _output = _input;
      }
    });
  }

  void _setOperator(String operator) {
    if (_input.isNotEmpty) {
      setState(() {
        _num1 = double.parse(_input);
        _operator = operator;
        _input = "";
      });
    }
  }

  void _calculate() {
    if (_input.isNotEmpty && _operator.isNotEmpty) {
      setState(() {
        _num2 = double.parse(_input);
        switch (_operator) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = _num2 != 0 ? (_num1 / _num2).toString() : "Erro";
            break;
        }
        _input = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculadora"),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: const TextStyle(color: Colors.white, fontSize: 48),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  _buildButtonRow(["7", "8", "9", "÷"]),
                  _buildButtonRow(["4", "5", "6", "×"]),
                  _buildButtonRow(["1", "2", "3", "-"]),
                  _buildButtonRow(["C", "0", "=", "+"]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((text) {
          return _buildButton(text);
        }).toList(),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (text == "C") {
              _clear();
            } else if (text == "=") {
              _calculate();
            } else if (["+", "-", "×", "÷"].contains(text)) {
              _setOperator(text);
            } else {
              _appendNumber(text);
            }
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}