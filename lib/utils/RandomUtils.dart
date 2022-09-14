import 'dart:math';

double doubleInRange(Random source, num start, num end) => source.nextDouble() * (end - start) + start;