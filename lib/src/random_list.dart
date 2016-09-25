// Copyright (c) 2016, Luca Carbone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

/// A list whose elements are associated to a number of occurrences. Elements
/// can be selected at random.
class RandomList<T> {
  Map<T, num> _data = <T, num>{};
  num _occurrences = 0;

  RandomList([Random this.randomGenerator]) {
    if (randomGenerator == null) randomGenerator = new Random();
  }

  RandomList.fromList(List<T> source, [Random this.randomGenerator]) {
    if (randomGenerator == null) randomGenerator = new Random();
    for(var item in source) add(item);
  }

  RandomList.fromMap(Map<T, num> source, [Random this.randomGenerator]) {
    if (randomGenerator == null) randomGenerator = new Random();
    for(var item in source.keys) {
      _data[item] = source[item];
      _occurrences += source[item];
    }
  }

  /// Returns the data as a <item, occurrences> Map.
  Map<T, num> asMap() => _data;

  /// Adds the specified number of occurrences of the item. Negative numbers
  /// are ignored.
  void add(T item, [num occurrences = 1]) {
    if (occurrences < 1) {
      return;
    } else if(_data.containsKey(item)) {
      _occurrences += occurrences;
      _data[item] += occurrences;
    } else {
      _occurrences += occurrences;
      _data[item] = occurrences;
    }
  }

  /// Returns a random item from the list, or null if the list is empty.
  T get item {
    if(_occurrences == 0)
      return null;
    num current = 0;
    num reference = randomGenerator.nextInt(_occurrences);
    for (var item in _data.keys) {
      current += _data[item];
      if (current > reference) {
        return item;
      }
    }
    // it should never happen except on an empty list
    return null;
  }

  /// Returns a list of all the items
  List<T> get items => _data.keys;

  /// Returns the total number of occurrences.
  num get occurrences => _occurrences;

  /// Gets or sets the random number generator used by this instance.
  /// By default a new [Random] is created with a [new RandomList] if not
  /// passed as parameter.
  Random randomGenerator;

  /// Removes all occurrences of the item.
  void remove(T item) {
    set(item, 0);
  }

  /// Adds the number of occurrences of the item.
  void set(T item, num occurrences) {
    if (_data.containsKey(item) && occurrences < 1) {
      _occurrences -= _data[item];
      _data.remove(item);
    } else if (_data.containsKey(item)) {
      _occurrences -= _data[item];
      _occurrences += occurrences;
      _data[item] = occurrences;
    } else {
      _occurrences += occurrences;
      _data[item] = occurrences;
    }
  }
}
