import 'decimal_to_fraction.dart';

String formatStagger(double decimal) {
  String size = decimal.toString();
  String fraction = size.substring(size.indexOf('.'));
  fraction = decimalToFraction(fraction);
  String whole = size.substring(0, size.indexOf('.'));

  return whole + " " + fraction;
}
