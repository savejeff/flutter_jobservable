import 'observable_base.dart';

class ObservableValue<T> extends ObservableObject {
	T _value;

	ObservableValue(this._value);

	T get value => _value;

	set value(T newValue) {
		if (_value != newValue) {
			_value = newValue;
			notifyValueChange(); // Only notify observers when the value actually changes
		}
	}
}
