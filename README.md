# learning_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Documentation

### Start a new Project

- With Extension:
    - Add Flutter Extension to VS Code / Codium
    - Open View > Command Palette (Ctrl+Shift+P)
        - command: Flutter: Start New Project
        - install to install or chose path to Flutter SDK (if necessary)
    - Follow Steps
- Manually:
    - [Install Flutter manually](https://docs.flutter.dev/install/manual)

### Run your app

- Command Palette (View > Comand Palette):
    - Flutter: Select Device
    - Debugging Mode: Run > Start Debugging (OR press F5)
        - flutter run used to build and start app
    - Run w/o Debugging: Run > Start without Debugginh (OR press ctrl + F5)

### Learning Dart

#### [Overview](https://dart.dev/overview)

client-optimized language for developing fast apps on any plattform

- forms founation of Flutter: provides language and runtime, also provides tasks like formatting, analyzing and testing code
- TYPESAFE language: static type checking to ensure that value always matches type
- Dart has built-in SOUND NULL SAFETY: values can't be null unless you say they can be -> protection agains null exceptions at runtime

#### [Libabries](https://dart.dev/libraries)

Dart has a rich set of core libraries, providing essentials for many everyday programming tasks:

- Built-in types, collections, and other core functionality for every Dart program (dart:core)
- Richer collection types such as queues, linked lists, hashmaps, and binary trees (dart:collection)
- Encoders and decoders for converting between different data representations, including JSON and UTF-8 (dart:convert)
- Mathematical constants and functions, and random number generation (dart:math)
- Support for asynchronous programming, with classes such as Future and Stream (dart:async)
- Lists that efficiently handle fixed-sized data (for example, unsigned 8-byte integers) and SIMD numeric types (dart:typed_data)
- File, socket, HTTP, and other I/O support for non-web applications (dart:io)
- Foreign function interfaces for interoperability with other code that presents a C-style interface (dart:ffi)
- Concurrent programming using isolates—independent workers that are similar to threads but don't share memory, communicating only through messages (dart:isolate)
- HTML elements and other resources for web-based applications that need to interact with the browser and the Document Object Model (DOM) (dart:js_interop and package:web)
- and more: characters, intl, http, crypto, markdown, xml, windows integration, sqlite, compression etc.

#### [Basics with Dart - first Steps](https://github.com/aljamu/dartpedia-learning-dart)
A Basic Cli Application that fetches Data from the Wikipedia-API. Following the official [Dart Tutorial](https://dart.dev/learn/tutorial)

#### Learning Flutter

##### Widgets

A Widget is a Dart class that extends one of the Flutter widget classes, for example StatelessWidget.

- Build REUSABLE components
- Most widgets have a child or children property that's meant to be passed a widget or a list of widgets
- Common Widgets:
    - Container (convenient Widget that wraps several core stylings like Padding, ColoredBox, etc.)
    - Scaffold (convenience widget that provides a Material-style page layout)
    - AppBar (like taskbar or navbar)
    - Center
    - Text
-It's a good practice for interactive widgets to use callback functions to keep the widget that handles interactions reusable and decoupled from any specific functionality.

##### Stateful Widget
When a widget's appearance or data needs to change during its lifetime, you need a StatefulWidget and a companion State object. While the StatefulWidget itself is still immutable (its properties can't change after creation), the State object is long-lived, can hold mutable data, and can be rebuilt when that data changes, causing the UI to update.

class ExampleWidget extends StatefulWidget {
  ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

- Whenever you mutate a State object, you must call setState to signal the framework to update the user interface and call the build method again.
