import 'package:flutter/material.dart';


class ValueWrapper<T> {
	T _value;
	final State _state;

	ValueWrapper(this._state, this._value);

	T get value => _value;

	set value(T newValue) {
		if (_value != newValue) {
			_value = newValue;
			_state.setState(() {}); // Directly call setState on the widget’s state
		}
	}

	// Optional: Additional methods that use `_state` if needed
	void updateAndPrint(T newValue) {
		value = newValue;
		print("New value is $newValue in widget ${_state.widget}");
	}
}


//******************************* Example Widget *****************************************


class ValueWrapperWidget extends StatefulWidget {
	@override
	_ValueWrapperWidgetState createState() => _ValueWrapperWidgetState();
}

class _ValueWrapperWidgetState extends State<ValueWrapperWidget> {
	late final ValueWrapper<int> valueWrapper;

	@override
	void initState() {
		super.initState();
		// Pass `this` to allow the wrapper direct access to the state instance
		valueWrapper = ValueWrapper<int>(this, 0);
	}

	void incrementValue() {
		valueWrapper.value += 1; // Directly triggers setState through the wrapper
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				Text('Value: ${valueWrapper.value}'), // Displays the current value
				ElevatedButton(
					onPressed: incrementValue,
					child: Text('Increment'),
				),
			],
		);
	}
}

