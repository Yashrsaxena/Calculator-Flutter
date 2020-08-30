import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0';
  String memory = '0';
  String result = '0';
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  buttonPressed(String value) {
    //print(value);
    if (value == 'C') {
      result = '0';
      num1 = num2 = 0.0;
      operand = "";
      memory = '0';
    } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
      num1 = double.parse(result);
      operand = value;
      if (memory == '0' ||
          (!memory.contains('+') &&
              !memory.contains('-') &&
              !memory.contains('×') &&
              !memory.contains('÷')))
        memory = result + operand;
      else
        memory += result + operand;
      result = '0';
    } else if (value == '⋅') {
      if (result.contains('.')) {
        print('Already have a decimal');
        return;
      } else {
        result += '.';
      }
    } else if (value == '=') {
      num2 = double.parse(result);
      switch (operand) {
        case '+':
          num1 += num2;
          result = num1.toStringAsFixed(2);
          break;
        case '-':
          num1 -= num2;
          result = num1.toStringAsFixed(2);
          break;
        case '×':
          num1 *= num2;
          result = num1.toStringAsFixed(6);
          break;
        case '÷':
          num1 /= num2;
          result = num1.toStringAsFixed(6);
          break;
      }
      memory = result;
      num1 = num2 = 0.0;
    } else if (value == '±') {
      result = (-double.parse(result)).toString();
      memory = result;
    } else if (value == 'CE') {
      if (memory.length - result.length == 0) memory = '0';
      result = '0';
    } else if (value == '⌫') {
      if (result.length > 1)
        result = result.substring(0, result.length - 1);
      else
        result = '0';
    } else {
      if (result != '0' && result != '⋅')
        result += value;
      else if (result == '⋅')
        result = '0';
      else
        result = value;
    }
    setState(() {
      output = result;
    });
    print("Pressed:$value\nresult:$result\noutput:$output\n");
  }

  Widget _buildButton(String buttonLabel) {
    return Expanded(
      child: FlatButton(
        child: Text(
          buttonLabel,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          buttonPressed(buttonLabel);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  memory,
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )),
          ),
          Divider(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 40),
              )),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('C'),
              _buildButton('CE'),
              _buildButton('⌫'),
              _buildButton('÷'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('×'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('±'),
              _buildButton('0'),
              _buildButton('⋅'),
              _buildButton('='),
            ],
          ),
        ],
      ),
    );
  }
}
