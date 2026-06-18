import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Flutter Tutorial', home: TutorialHome()));
}

class TutorialHome extends StatelessWidget {
  const TutorialHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: const Center(child: MyButton()),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    double buttonHeight = 50;
    double buttonWidth = 500;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Column(
          children: [
            //Gesture is basically a Button
            //More Gestures are IconButton, ElevatedButton, FloatingActionButton with onPressed() callbacks
            GestureDetector(
              onTap: () {
                print('MyButton was tapped!');
              },
              child: Container(
                height: buttonHeight,
                width: buttonWidth,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.lightGreen[500],
                ),
                child: const Center(child: Text('Engage Button')),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: buttonHeight,
              width: buttonWidth,
              decoration: BoxDecoration(color: Colors.lightBlue[500]),
              child: const Center(child: Text('No Button')),
            ),
          ],
        ),
      ],
    );
  }
}
