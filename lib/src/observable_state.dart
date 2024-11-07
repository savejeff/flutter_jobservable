import 'package:flutter/material.dart';

import 'dart:collection';

import 'observable_base.dart';




// Subclass of State that manages observers and disposes them automatically
abstract class ObserverState<T extends StatefulWidget> extends State<T> {
	final Set<ObservableWrapper> _observers = HashSet();

	int _redraw_queued_count = 0; // Tracks how many redraw calls are queued
  bool _redraw_queued = false; // Tracks if a redraw is already scheduled

  int _redraw_count = 0;

	// Schedule a redraw with asynchronous handling
	void scheduleRedraw() {
		_redraw_queued_count ++;
		if (!_redraw_queued) {
			_redraw_queued = true;
			//Future.microtask(() {
      Future.delayed(Duration(milliseconds: 50), () { // batch up some consecutive calls
				//print(">> REDRAW($_redraw_queued_count)");
				_redraw_queued = false;
				_redraw_queued_count = 0;
				redraw(); // Trigger a rebuild asynchronously
			});
		}
	}

  // triggers a redraw
  void redraw() {
    _redraw_count++;
    setState(() { });
  }

	// Observe an ObservableObject by creating an ObservableWrapper
	ObservableWrapper observe(ObservableObject observableObject) {
		final wrapper = ObservableStateWrapper(this, observableObject);
		_observers.add(wrapper);
		return wrapper;
	}

	@override
	void dispose() {
		// Dispose of all observers to prevent memory leaks
		for (var observer in _observers) {
			observer.dispose();
		}
		super.dispose();
	}
}

