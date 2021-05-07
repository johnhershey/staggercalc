import 'decimal_to_fraction.dart';

String formatStagger(double decimal) {
  String size = decimal.toString();
  String fraction = size.substring(size.indexOf('.'));
  fraction = decimalToFraction(fraction);
  String whole = size.substring(0, size.indexOf('.'));

  if (whole == '0') {
    if (fraction != '') {
      whole = '';
    }
  } else {
    if (fraction != '') {
      whole = whole + ' ';
    }
  }

  return whole + fraction;
}
