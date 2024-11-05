import 'dart:collection';

import 'observable_state.dart';

class ObservableObject {
	// Keep track of all observers
	final Set<ObservableWrapper> _observers = HashSet();

	// Register an observer
	void addObserver(ObservableWrapper observer) {
		_observers.add(observer);
	}

	// Remove an observer
	void removeObserver(ObservableWrapper observer) {
		_observers.remove(observer);
	}

	// Notify all observers of a value change
	void notifyValueChange() {
		for (var observer in _observers) {
			observer.update(); // Call the update method on each observer
		}
	}
}



class ObservableWrapper {
	final ObserverState _state;
	final ObservableObject _observableObject;

	ObservableWrapper(this._state, this._observableObject) {
		// Register this wrapper as an observer with the ObservableObject
		_observableObject.addObserver(this);
	}

	// This method is called when the ObservableObject notifies observers of a change
	void update() {
		_state.scheduleRedraw(); // Delegate the update to the ObserverState's scheduleRedraw method
	}

	// Clean up to prevent memory leaks
	void dispose() {
		_observableObject.removeObserver(this);
	}
}
