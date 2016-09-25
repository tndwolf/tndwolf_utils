// Copyright (c) 2016, Luca Carbone. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:tndwolf/tndwolf_utils.dart';

main() {
  var list = new RandomList();
  list.add("Red", 1);
  list.add("Green", 2);
  list.add("Blue", 3);
  var favorableResult = 0;
  for(var i = 0; i < 10000; i++) {
    if (list.item == "Blue") favorableResult++;
  }
  print("I got Blue $favorableResult out of 10000 tries");
}
