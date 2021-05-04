double fractionToDecimal(String fraction) {
  switch (fraction) {
    case "1/8":
      return 0.125;
      break;
    case "1/4":
      return 0.25;
      break;
    case "3/8":
      return 0.375;
      break;
    case "1/2":
      return 0.5;
      break;
    case "5/8":
      return 0.625;
      break;
    case "3/4":
      return 0.75;
      break;
    case "7/8":
      return 0.875;
      break;
    default:
      return 0.0;
  }
}
