import 'package:flutter/material.dart';
import 'package:calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = '';
  var output= '';
  var hideInput= false;
  var outputSize = 35.0;

  onButtonClick(value){
    if(value == "Kudo"){
      input = '';
      output = 'Developed by ~Sami Wasta';
    } else if(value == "AC"){
      input = '';
      output = '';
    } else if(value == "DEL") {
      if(input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if(value == "="){
      if(input.isNotEmpty){
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith(".0")){
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 50;
      }
    }
    else {
      input = input + value;
      hideInput = false;
      outputSize = 35.0;
    }

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '': input,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      output,
                      style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white30
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
          ),
          Row(
            children: [
              button(text: "Kudo", buttonBgColor: operatorColor, textColor: orangeColor),
              button(text: "AC", buttonBgColor: operatorColor, textColor: orangeColor),
              button(text: "DEL", buttonBgColor: operatorColor, textColor: orangeColor),
              button(text: "/", buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x",  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "%", buttonBgColor: operatorColor),
              button(text: "0"),
              button(text: ".", buttonBgColor: operatorColor),
              button(text: "=", buttonBgColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, textColor = Colors.white, buttonBgColor = buttonColor}){
    return Expanded(
        child: Container(
          margin: EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(22),
                backgroundColor: buttonBgColor
            ),
            onPressed: () => onButtonClick(text),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
    );
  }
}
