import 'dart:math';

double doubleInRange(Random source, num start, num end) => source.nextDouble() * (end - start) + start;

extension RandomElement<T> on List<T> {

  T randomElement(Random random){
    return this[random.nextInt(length)];
  }

}