import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';

// Here is inside the main function we run our MyApp() class
void main() {
runApp(MyApp());
}


//Here we define our MyApp class using stateless widget
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
	return MaterialApp(

    //We used debugshowcheckedmodebanner user to remove the label displayed on our app
	debugShowCheckedModeBanner: false,

  //Here we route the home to HomePage class that we have define below
	home: HomePage(),
	); // MaterialApp
}
}

//Here we define our HomePage Class
class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Here we declare two variables one is for the user input and another one is for answer
var userInput = '';
var answer = '';

// Array of button which we are going to use in our calculator
final List<String> buttons = [
	'C',
	'+/-',
	'%',
	'DEL',
	'7',
	'8',
	'9',
	'/',
	'4',
	'5',
	'6',
	'x',
	'1',
	'2',
	'3',
	'-',
	'0',
	'.',
	'=',
	'+',
];

@override
Widget build(BuildContext context) {
  //Here we are returning the scaffold widget
	return Scaffold(
    // Here is the app bar of our app also we can change the appbar styling form here
	appBar: new AppBar(
    backgroundColor: Colors.red,
		title:   Text(   'Yogx Calculator',
                              style: GoogleFonts.adventPro(
                                textStyle:TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
	), //AppBar
	backgroundColor: Color.fromARGB(255, 255, 204, 204),

  //Inside the body we are building our buttons and arithmetic operation functions
	body: Column(
		children: <Widget>[
		Expanded(
			child: Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Container(
					padding: EdgeInsets.all(20),
					alignment: Alignment.centerRight,
					child: Text(
						userInput,
						style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 17, 0)),
					),
					),
					Container(
					padding: EdgeInsets.all(15),
					alignment: Alignment.centerRight,
					child: Text(
						answer,
						style: TextStyle(
							fontSize: 30,
							color: Color.fromARGB(255, 255, 17, 0),
							fontWeight: FontWeight.bold),
					),
					)
				]),
			),
		),
    
		Expanded(
			flex: 3,
			child: Container(
			child: GridView.builder(
				itemCount: buttons.length,
				gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
					crossAxisCount: 4),
				itemBuilder: (BuildContext context, int index) {

					// Clear Button
					if (index == 0) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput = '';
							answer = '0';
						});
						},
						buttonText: buttons[index],
						color: Color.fromARGB(255, 255, 146, 146),
						textColor: Colors.black,
					);
					}

					// +/- button
					else if (index == 1) {
					return MyButton(
						buttonText: buttons[index],
				color: Color.fromARGB(255, 255, 146, 146),
						textColor: Colors.black,
					);
					}
					// % Button
					else if (index == 2) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput += buttons[index];
						});
						},
						buttonText: buttons[index],
							color: Color.fromARGB(255, 255, 146, 146),
						textColor: Colors.black,
					);
					}
					// Delete Button
					else if (index == 3) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput =
								userInput.substring(0, userInput.length - 1);
						});
						},
						buttonText: buttons[index],
					color: Color.fromARGB(255, 255, 146, 146),
						textColor: Colors.black,
					);
					}
					// Equal_to Button
					else if (index == 18) {
					return MyButton(
						buttontapped: () {
						setState(() {
							equalPressed();
						});
						},
						buttonText: buttons[index],
						color: Color.fromARGB(255, 255, 255, 255),
						textColor: Colors.black,
					);
					}

					// other buttons
					else {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput += buttons[index];
						});
						},
						buttonText: buttons[index],
						color: isOperator(buttons[index])
							? Color.fromARGB(255, 255, 0, 0)
							: Colors.white,
						textColor: isOperator(buttons[index])
							? Color.fromARGB(255, 255, 255, 255)
							: Colors.black,
					);
					}
				}), // GridView.builder
			),
		),
    
		],
	),
	);
}

bool isOperator(String x) {
	if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
	return true;
	}
	return false;
}

// function to calculate the input operation
void equalPressed() {
	String finaluserinput = userInput;
	finaluserinput = userInput.replaceAll('x', '*');

	Parser p = Parser();
	Expression exp = p.parse(finaluserinput);
	ContextModel cm = ContextModel();
	double eval = exp.evaluate(EvaluationType.REAL, cm);
	answer = eval.toString();
}
}


// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {

// declaring variables
final color;
final textColor;
final String buttonText;
final buttontapped;

//Constructor
MyButton({this.color, this.textColor, required this.buttonText, this.buttontapped});

@override
Widget build(BuildContext context) {
	return GestureDetector(
	onTap: buttontapped,
	child: Container(
		padding: const EdgeInsets.all(0.2),
    margin: const EdgeInsets.all(1.5),
		child: ClipRRect(
		borderRadius: BorderRadius.circular(5),
		child: Container(
			color: color,
			child: Center(
			child: Text(
				buttonText,
				style: TextStyle(
				color: textColor,
				fontSize: 25,
				fontWeight: FontWeight.bold,
				),
			),
			),
		),
		),
	),
	);
}
}
