String decimalToFraction(String decimal) {
  switch (decimal) {
    case ".125":
      return "1/8";
      break;
    case ".25":
      return "1/4";
      break;
    case ".375":
      return "3/8";
      break;
    case ".5":
      return "1/2";
      break;
    case ".625":
      return "5/8";
      break;
    case ".75":
      return "3/4";
      break;
    case ".875":
      return "7/8";
      break;
    default:
      return "";
  }
}