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



## Start a new Project

- With Extension:
    - Add Flutter Extension to VS Code / Codium
    - Open View > Command Palette (Ctrl+Shift+P)
        - command: Flutter: Start New Project
        - install to install or chose path to Flutter SDK (if necessary)
    - Follow Steps
- Manually:
    - [Install Flutter manually](https://docs.flutter.dev/install/manual)

## Run your app

- Command Palette (View > Comand Palette):
    - Flutter: Select Device
    - Debugging Mode: Run > Start Debugging (OR press F5)
        - flutter run used to build and start app
    - Run w/o Debugging: Run > Start without Debugginh (OR press ctrl + F5)
- flutter run -d web-server



# Learning Dart

### [Overview](https://dart.dev/overview)
client-optimized language for developing fast apps on any plattform

- forms founation of Flutter: provides language and runtime, also provides tasks like formatting, analyzing and testing code
- TYPESAFE language: static type checking to ensure that value always matches type
- Dart has built-in SOUND NULL SAFETY: values can't be null unless you say they can be -> protection agains null exceptions at runtime

### [Libabries](https://dart.dev/libraries)

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

### [Basics with Dart - first Steps](https://github.com/aljamu/dartpedia-learning-dart)
A Basic Cli Application that fetches Data from the Wikipedia-API. Following the official [Dart Tutorial](https://dart.dev/learn/tutorial)



# Learning Flutter
## Widgets

A Widget is a Dart class that extends one of the Flutter widget classes, for example StatelessWidget.

- Build REUSABLE components
- Most widgets have a child or children property that's meant to be passed a widget or a list of widgets
- It's a good practice for interactive widgets to use callback functions to keep the widget that handles interactions reusable and decoupled from any specific functionality.

### Stateless Widget
Stateless Arguments recieve arguments from their parent widgets, which they store in FINAL member variables. 

### [Stateful Widget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
When a widget's appearance or data needs to change during its lifetime, you need a StatefulWidget and a 
companion State object.

```dart    class ExampleWidget extends StatefulWidget {
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
```
- A widget's state is stored in a State object, separating the widget's state from its appearance. The state consists of values that can change, like a slider's current value or whether a checkbox is checked. When the widget's state changes, the state object calls **setState()**, telling the framework to redraw the widget.

## Packages

- add packages: "flutter pub add [name]" in cli
    - e. g.: flutter pub add http

## MVVM-Architecture (Model-View-ViewModel)

- Model: Handles data operations.
- View: Displays the UI.
- ViewModel: Manages state and connects the two.

The core tenet of MVVM (and many other patterns) is separation of concerns. Managing state in separate classes (outside your UI widgets) makes your code more testable, reusable, and easier to maintain.

### Model
The Model is the source-of-truth for your app's data and is responsible for low-level tasks such as making HTTP requests, caching data, or managing system resources such as used by a Flutter plugin. A model doesn't usually need to import Flutter libraries.

### ViewModel
When developers talk about state-management in Flutter, they're essentially referring to the pattern by which your app updates the data it needs to render correctly and then tells Flutter to re-render the UI with that new data.

In MVVM, this responsibility falls to the ViewModel layer, which sits between and connects your UI to your Model layer. In Flutter, ViewModels use Flutter's ChangeNotifier class to notify the UI when data changes.

## Layouts

Widgets can be seperated into visible and layout widgets.
- Visible Widgets: Contain visible elements like icons, text, images etc.
- Layout Widgets: Help layouting like padding, margin, colors etc.. They have child and children properties for other layout or visible widgets
- There are Flutter Base Widgets, Material Widgets specifically for Android and Cupertino for iOS

### Container

A container is used whenever you need customization like padding, margins, borders and bg color on it's child elements.

### Row and Column

Used to nest other widgets inside.
They usually take up all the space they need. For Opposite: e.g. mainAxisSize.min

### Aligning Widgets

Alignment with mainAxisAlignment and crossAxisAlignment

- mainAxisAlignment: Horizontally for a Row, Vertically for a Column (e.g. ROW [o, o, o, o, o] - ---mainAxis--->)
- crossAxisAlignment: Vertically for a Row, Horizontally for a Column (e.g. ROW [o, o, o, o, o] vvvvcrossAxisvvvv)

### Expanded

Widgets can be sized to fit within a row or column.
Has Flex property: determines the flex facrot for a widget (default 1).
E.g.
 [Image] [   Image   ] [Image]
[flex: 1]  [flex: 2]  [flex: 1]

### GridView

Build a custom grid, replacing nested rows and cols

### ListView

A column-like widget that automatically provides scrolling when content is too long

### Stack

Arrange widgets on top of a base widget (e.g. often an image) either completely or partially.

### Responsive Design

[Google offers a simple 3-way method to archive responsiveness across the platform. Click me for more details](https://docs.flutter.dev/ui/adaptive-responsive/general)

### Share Layout and Fonts with Themes

[To share colors and font styles throughout an app, use themes](https://docs.flutter.dev/cookbook/design/themes)

## Interactivity [(Managing State)](https://docs.flutter.dev/ui/interactivity)
There are different approaches for managing state.
You, as the widget designer, choose which approach to use.
If in doubt, start by managing state in the parent widget.

How do you decide which approach to use? The following principles should help you decide:

- If the state in question is user data, for example the checked or unchecked mode of a checkbox, or the position of a slider, then the state is best managed by the parent widget.

- If the state in question is aesthetic, for example an animation, then the state is best managed by the widget itself.

### The widget manages its own state
Sometimes it makes the most sense for the widget to manage its state internally. For example, ListView automatically scrolls when its content exceeds the render box. Most developers using ListView don't want to manage ListView's scrolling behavior, so ListView itself manages its scroll offset.

#### The parent widget manages the widget's state
Often it makes the most sense for the parent widget to manage the state and tell its child widget when to update. For example, IconButton allows you to treat an icon as a tappable button. IconButton is a stateless widget because we decided that the parent widget needs to know whether the button has been tapped, so it can take appropriate action.

#### A mix-and-match approach
For some widgets, a mix-and-match approach makes the most sense. In this scenario, the stateful widget manages some of the state, and the parent widget manages other aspects of the state.

## [Gestures](https://docs.flutter.dev/ui/interactivity/gestures)
The gesture system has two separate layers. The first layer has raw pointer events that describe the location and movement of pointers (for example, touches, mice, and styli) across the screen. The second layer has gestures that describe semantic actions that consist of one or more pointer movements.

**If you're using Material Components, many of those widgets already respond to taps or gestures. For example, IconButton and TextButton respond to presses (taps), and ListView responds to swipes to trigger scrolling.**

### Pointers
Pointers represent raw data about the user's interaction with the device's screen. There are four types of pointer events:
- PointerDownEvent: The pointer has contacted the screen at a particular location. The framework does a hit test on your app to determine which widget exists at the location where the pointer contacted the screen.
- PointerMoveEvent: The pointer has moved from one location on the screen to another.
- PointerUpEvent: The pointer has stopped contacting the screen.
- PointerCancelEvent: Input from this pointer is no longer directed towards this app.

### Gestures
Gestures represent semantic actions (for example, tap, drag, and scale) that are recognized from multiple individual pointer events, potentially even multiple individual pointers.
#### Tap
- onTapDown
- onTapUp
- onTap
- onTapCancel
- onDoubleTap
- onLongPress
#### Drag
- onVerticalDragStart
- onVerticalDragUpdate
- onVerticalDragEnd
also works Horizontally
#### Pan
- onPanStart
- onPanUpdate
- onPanEnd

### GestureDetector
Use the GestureDetector widget to respond to fundamental actions, such as tapping and dragging.