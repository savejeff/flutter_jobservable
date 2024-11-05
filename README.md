<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# jObservable

**A Simple UI Update Framework inspired by SwiftUI**

`jObservable` is a Flutter package that provides a lightweight and efficient way to handle state updates and trigger UI redraws based on observable values. Inspired by SwiftUI, this framework uses an observer pattern that lets widgets observe individual state variables (signals) and only redraws affected widgets when the observed state changes.

## Features

- **Observable Values**: Create observable state variables (`ObservableValue`) that can be individually observed by widgets.
- **Efficient UI Redraws**: Widgets observe specific values, so only the widgets depending on those values redraw when they change, reducing unnecessary UI updates.
- **Asynchronous Handling**: Automatically batches multiple `setState` calls within a short timeframe to avoid redundant redraws.
- **Simple API**: Easily manage and observe state updates without complex configurations.

## Installation

Add `jObservable` to your `pubspec.yaml` file:

```yaml
dependencies:
  jobservable: ^0.0.1
```

Then, run:

```bash
flutter pub get
```

## Getting Started

To begin, import the `jObservable` package:

```dart
import 'package:jobservable/observable.dart';
```

### Creating an Observable State Variable

Define an observable state variable using the `ObservableValue` class. Here’s an example of a `SignalManager` that contains a few observable signals:

```dart
class SignalManager {
  final ObservableValue<double> signalA = ObservableValue(0.0);
  final ObservableValue<double> signalB = ObservableValue(0.0);
  final ObservableValue<double> signalC = ObservableValue(0.0);

  // Additional signals can be added here
}

final SignalManager globalSignalManager = SignalManager();
```

Each `ObservableValue` instance holds a single value that can be observed individually by any widget.

### Observing an Observable Value in a Widget

1. Create a widget that extends `ObserverState`.
2. Use the `observe` method in `ObserverState` to register interest in a specific `ObservableValue`.
3. When the `ObservableValue` changes, the widget will automatically rebuild.

Here’s a basic example:

```dart
import 'package:flutter/material.dart';
import 'package:jobservable/observable.dart';

class SignalWidget extends StatefulWidget {
  @override
  _SignalWidgetState createState() => _SignalWidgetState();
}

class _SignalWidgetState extends ObserverState<SignalWidget> {
  late final ObservableWrapper signalWrapper;

  @override
  void initState() {
    super.initState();
    // Observe only the specific signal we care about
    signalWrapper = observe(globalSignalManager.signalA);
  }

  void incrementSignal() {
    // Update the signal's value, triggering a redraw only for widgets observing this signal
    globalSignalManager.signalA.value += 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Signal A: ${globalSignalManager.signalA.value}'), // Displays the specific signal's value
        ElevatedButton(
          onPressed: incrementSignal,
          child: Text('Increment Signal A'),
        ),
      ],
    );
  }
}
```

In this example:
- The `SignalWidget` observes `globalSignalManager.signalA`.
- When `signalA` changes, `SignalWidget` rebuilds automatically, showing the updated value.

### Usage Summary

- **Define Observable Values**: Use `ObservableValue` for each state variable you want to observe independently.
- **Observe in Widgets**: Extend `ObserverState` and use `observe` to start observing a specific `ObservableValue`.
- **Automatic Redraws**: Observed widgets will automatically update when the `ObservableValue` changes.

## API Reference

- **ObservableObject**: Base class that supports adding and notifying observers.
- **ObservableValue<T>**: Wraps a single value and notifies observers when it changes.
- **ObservableWrapper**: Connects an `ObservableObject` with the widget’s `ObserverState` to facilitate updates.
- **ObserverState<T>**: A `State` subclass that manages observers and automatically disposes them.

<!--
## Example Project

For a complete example project using `jObservable`, visit the [GitHub repository](https://jtec.website).
-->

## License

This package is open-source and licensed under the MIT License. 

## Contribution

Contributions are welcome! Please see the contribution guidelines in the repository.

