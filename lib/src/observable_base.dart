import 'dart:collection';

import 'observable_state.dart';

import 'util_sys.dart';


/*
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
			observer.notify(); // Call the update method on each observer
		}
	}

  int countObservers() {
    return _observers.length;
  }

}

 */


mixin ObservableObject {
	// Keep track of all observers
	final Set<ObservableWrapper> _observers = HashSet<ObservableWrapper>();

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
		for (final ObservableWrapper observer in _observers) {
			observer.notify(); // Call the update method on each observer
		}
	}

	int countObservers() {
		return _observers.length;
	}
}

class ObservableFlag with ObservableObject {

}

class ObserverObject with ObservableObject {
	static final _TAG = "ObserverObject";

	final Map<ObservableObject, ObservableObserverWrapper> _observed_objects_lookup = Map();
	//final Set<ObservableObserverWrapper> _observed_objects = HashSet();

	void observe(ObservableObject observed_object) {
		final wrapper = ObservableObserverWrapper(this, observed_object);
		_observed_objects_lookup[observed_object] = wrapper;
		//_observed_objects.add(wrapper);
	}

	void unobserve(ObservableObject observed_object) {
		if(_observed_objects_lookup.containsKey(observed_object)) {
			final wrapper = _observed_objects_lookup.remove(observed_object)!;
			//_observed_objects.remove(wrapper);
		}
	}

	// this must be called manually when the ObserverObject is not used anymore
	dispose() {
		for (var observer in _observed_objects_lookup.values) {
			observer.dispose();
		}
		_observed_objects_lookup.clear();
	}

	// accept notify from Observed Objects
	notify() {
		LogV(_TAG, ">>> notify");
		notifyValueChange();
	}
}


class CallbackObserver extends ObserverObject {

	final void Function() callback_on_notify;

	CallbackObserver(this.callback_on_notify, ObservableObject observedobject) {
    observe(observedobject);
  }

	@override
	notify() {
		callback_on_notify();
	}
}


//************************************************************************************************

// TODO rename to ObserveSubscription or ObserveLink or ObserveForwarder

class ObservableWrapper {
	// the Observable Object subscribed to
	final ObservableObject _observableObject;

	ObservableWrapper(this._observableObject) {
		// Register this wrapper as an observer with the ObservableObject
		_observableObject.addObserver(this);
	}

	// This method is called when the ObservableObject notifies observers of a change
	void notify() {
		// implement in child like
		//_state.scheduleRedraw(); // Delegate the update to the ObserverState's scheduleRedraw method
	}

	// called when Observing Object is destroyed
	void dispose() {
		// unsubscribe
		_observableObject.removeObserver(this);
	}
}


class ObservableStateWrapper extends ObservableWrapper {
	final ObserverState _state;

	ObservableStateWrapper(this._state, ObservableObject _observableObject)
	: super(_observableObject);

	@override
	void notify() {
		_state.scheduleRedraw(); // Delegate the update to the ObserverState's scheduleRedraw method
	}

}

class ObservableObserverWrapper extends ObservableWrapper {
	final ObserverObject _state;

	ObservableObserverWrapper(this._state, ObservableObject _observableObject)
	: super(_observableObject);

	@override
	void notify() {
		_state.notify(); // Delegate the update to the ObserverState's scheduleRedraw method
	}

}
