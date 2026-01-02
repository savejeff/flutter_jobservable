/*
import 'dart:collection';
import 'dart:math';
import 'observable_base.dart';

class ObservableList<T> extends ListBase<T> with ObservableObject {
	final List<T> _list;

	ObservableList([List<T>? initial])
		: _list = initial == null ? <T>[] : List<T>.from(initial);

	@override
	int get length => _list.length;

	@override
	set length(int newLength) {
		if (newLength == _list.length) {
			return;
		}
		_list.length = newLength;
		notifyValueChange();
	}

	@override
	T operator [](int index) => _list[index];

	@override
	void operator []=(int index, T value) {
		if (index >= 0 && index < _list.length) {
			if (_list[index] == value) {
				return;
			}
		}
		_list[index] = value;
		notifyValueChange();
	}

	@override
	void add(T value) {
		_list.add(value);
		notifyValueChange();
	}

	@override
	void addAll(Iterable<T> iterable) {
		if (iterable.isEmpty) {
			return;
		}
		_list.addAll(iterable);
		notifyValueChange();
	}

	@override
	void insert(int index, T element) {
		_list.insert(index, element);
		notifyValueChange();
	}

	@override
	void insertAll(int index, Iterable<T> iterable) {
		if (iterable.isEmpty) {
			return;
		}
		_list.insertAll(index, iterable);
		notifyValueChange();
	}

	@override
	bool remove(Object? value) {
		final bool res = _list.remove(value);
		if (res) {
			notifyValueChange();
		}
		return res;
	}

	@override
	T removeAt(int index) {
		final T res = _list.removeAt(index);
		notifyValueChange();
		return res;
	}

	@override
	T removeLast() {
		final T res = _list.removeLast();
		notifyValueChange();
		return res;
	}

	@override
	void removeWhere(bool Function(T element) test) {
		final int before = _list.length;
		_list.removeWhere(test);
		if (_list.length != before) {
			notifyValueChange();
		}
	}

	@override
	void retainWhere(bool Function(T element) test) {
		final int before = _list.length;
		_list.retainWhere(test);
		if (_list.length != before) {
			notifyValueChange();
		}
	}

	@override
	void clear() {
		if (_list.isEmpty) {
			return;
		}
		_list.clear();
		notifyValueChange();
	}

	@override
	void setAll(int index, Iterable<T> iterable) {
		if (iterable.isEmpty) {
			return;
		}
		_list.setAll(index, iterable);
		notifyValueChange();
	}

	@override
	void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {
		_list.setRange(start, end, iterable, skipCount);
		notifyValueChange();
	}

	@override
	void replaceRange(int start, int end, Iterable<T> replacements) {
		final bool hasStructuralChange = (end - start) != replacements.length;
		_list.replaceRange(start, end, replacements);
		if (hasStructuralChange || replacements.isNotEmpty) {
			notifyValueChange();
		}
	}

	@override
	void fillRange(int start, int end, [T? fillValue]) {
		bool changed = false;
		for (int i = start; i < end; i++) {
			if (_list[i] != fillValue) {
				changed = true;
				break;
			}
		}
		if (!changed) {
			return;
		}
		_list.fillRange(start, end, fillValue);
		notifyValueChange();
	}

	@override
	void sort([int Function(T a, T b)? compare]) {
		if (_list.length < 2) {
			return;
		}
		_list.sort(compare);
		notifyValueChange();
	}

	@override
	void shuffle([Random? random]) {
		if (_list.length < 2) {
			return;
		}
		_list.shuffle(random);
		notifyValueChange();
	}

	List<T> toListCopy({bool growable = true}) {
		return List<T>.from(_list, growable: growable);
	}
}
*/