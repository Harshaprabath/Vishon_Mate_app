import 'package:flutter/material.dart';

class AutoClickPage extends StatefulWidget {
  @override
  _AutoClickPageState createState() => _AutoClickPageState();
}

class _AutoClickPageState extends State<AutoClickPage> {
  @override
  void initState() {
    super.initState();

    // Delay execution by a short period to ensure proper layout
    Future.delayed(Duration(milliseconds: 200), () {
      _handleButtonClick(); // Call the function that handles the button click
    });
  }

  void _handleButtonClick() {
    // Add your logic here that should be executed when the button is clicked
    print('Button Clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto Button Click')),
      body: Center(
        child: MaterialButton(
          onPressed: _handleButtonClick,
          child: Text('Click Me'),
        ),
      ),
    );
  }
}
