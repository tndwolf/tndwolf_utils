// Copyright (c) 2016, Luca Carbone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:tndwolf/tndwolf_utils.dart';
import 'package:test/test.dart';
import 'dart:math';

void main() {
  group('RandomList tests', () {
    final num maxIterations = 10000;
    final num resultTolerance = 0.05;
    final String testItem1 = "test 1";
    final String testItem2 = "test 2";
    final String testItem3 = "test 3";

    test('Basics', () {
      var list = new RandomList(new Random());
      list.add(testItem1, 1);
      list.add(testItem2, 2);
      list.add(testItem3, 3);
      var favorableResult = 0;
      for(var i = 0; i < maxIterations; i++) {
        if (list.item == testItem1) favorableResult++;
      }
      var favorableRatio = favorableResult/maxIterations;
      var expectedRatio = 1/(1 + 2 + 3);
      expect(favorableRatio, lessThan(expectedRatio + resultTolerance));
      expect(favorableRatio, greaterThan(expectedRatio - resultTolerance));
    });

    test('Constructors', () {
      var list = new RandomList();
      list.add(testItem1, 1);
      list.add(testItem2, 2);
      list.add(testItem3, 3);
      expect(list.asMap()[testItem1], 1);
      expect(list.asMap()[testItem2], 2);
      expect(list.asMap()[testItem3], 3);
      // Map
      list = new RandomList.fromMap(
          {testItem1: 1, testItem2: 2, testItem3: 3});
      expect(list.asMap()[testItem1], 1);
      expect(list.asMap()[testItem2], 2);
      expect(list.asMap()[testItem3], 3);
      // List
      list = new RandomList.fromList(
          [testItem1, testItem2, testItem2, testItem3]);
      expect(list.asMap()[testItem1], 1);
      expect(list.asMap()[testItem2], 2);
      expect(list.asMap()[testItem3], 1);
    });

    test('Edits', () {
      var list = new RandomList(new Random());
      list.add(testItem1, 1);
      list.add(testItem2, 2);
      list.add(testItem3, 3);
      expect(list.asMap()[testItem1], 1);
      expect(list.asMap()[testItem2], 2);
      expect(list.asMap()[testItem3], 3);
      expect(list.occurrences, 6);
      // Remove through set
      list.set(testItem1, 0);
      expect(list.asMap()[testItem1], isNull);
      expect(list.occurrences, 5);
      // Restore with set
      list.set(testItem1, 1);
      expect(list.asMap()[testItem1], 1);
      expect(list.occurrences, 6);
      // Increase with set
      list.set(testItem1, 2);
      expect(list.asMap()[testItem1], 2);
      expect(list.occurrences, 7);
      // Increase with add
      list.add(testItem1, 1);
      expect(list.asMap()[testItem1], 3);
      expect(list.occurrences, 8);
      // Invalid add
      list.add(testItem1, -1);
      list.add(testItem1, 0);
      expect(list.asMap()[testItem1], 3);
      expect(list.occurrences, 8);
      // Remove through remove
      list.remove(testItem1);
      expect(list.asMap()[testItem1], isNull);
      expect(list.occurrences, 5);
    });
  });
}
