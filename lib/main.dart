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
    return Counter();
  }
}
//Configuration for state. Holds the values of parent and ud by the build method
class Counter extends StatefulWidget {
  const Counter({ super.key });
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  double height = 50;
  double width = 500;
  int _counter = 0;

  void _increment(){
    setState(() {
      _counter++;
    });
  }

  //Will rerun every time the setState is called.
  @override
  Widget build(BuildContext context) {
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
                _increment();
              },
              child: Container(
                height: height,
                width: width,
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
              height: height,
              width: width,
              decoration: BoxDecoration(color: Colors.lightBlue[500]),
              child: Center(child: Text('Count: $_counter')),
            ),
          ],
        ),   
      ],
    ); 
  }
}
