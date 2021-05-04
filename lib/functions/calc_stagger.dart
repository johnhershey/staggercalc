import 'fraction_to_decimal.dart';

double calcStagger(int a, int b, String aF, String bF) {
  double aD = a + fractionToDecimal(aF);
  double bD = b + fractionToDecimal(bF);

  if (aD > bD) {
    return aD - bD;
  } else {
    return bD - aD;
  }
}
