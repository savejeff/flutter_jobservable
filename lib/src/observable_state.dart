import 'package:flutter/material.dart';

import 'dart:collection';

import 'observable_base.dart';

import 'opt.dart';
import 'util_sys.dart';



// Subclass of State that manages observers and disposes them automatically
abstract class ObserverState<T extends StatefulWidget> extends State<T> {
	String _TAG = "ObserverState";

  bool was_disposed = false;

	jObservable_setTag(String tag) {
		_TAG = tag;
	}


	//final Set<ObservableWrapper> _observers = HashSet();
	final Map<ObservableObject, ObservableWrapper> _observers_lookup = Map();

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

        if(was_disposed) {
          LogD(_TAG, "REDRAW: skipped due to disposed");
          return;
        }

				LogD(_TAG, "REDRAW: merged=$_redraw_queued_count");

				_redraw_queued = false;
				_redraw_queued_count = 0;
				_redraw(); // Trigger a rebuild asynchronously
			});
		}
	}

  // triggers a redraw
  void _redraw() {
    _redraw_count++;

    onRedraw();

    setState(() { });
  }

  void redraw() {
    scheduleRedraw();
  }

	// Observe an ObservableObject by creating an ObservableWrapper
	ObservableWrapper observe(ObservableObject observableObject) {
		final wrapper = ObservableStateWrapper(this, observableObject);
		//_observers.add(wrapper);
		_observers_lookup[observableObject] = wrapper;
		return wrapper;
	}

	// Observe an ObservableObject by creating an ObservableWrapper
	unobserve(ObservableObject observableObject) {
		if(_observers_lookup.containsKey(observableObject)) {
			final wrapper = _observers_lookup.remove(observableObject)!;
			//_observed_objects.remove(wrapper);
		}
	}

	@override
	void dispose() {
    was_disposed = true;

		// Dispose of all observers to prevent memory leaks
		for (var observer in _observers_lookup.values) {
			observer.dispose();
		}
		_observers_lookup.clear();

		super.dispose();
	}


  // ****************** Events ***************************

  void onRedraw() {
    // Called if a Redraw is triggered
    // can be overridden to update stuff before setState() is called
  }

}

