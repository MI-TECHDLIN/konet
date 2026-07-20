String intColorConverter(int decimalValue) {
  '''
a function that recives decmial values and converts to hexcodes 
''';
  if (decimalValue == 0) return '0';

  String hexResult = '';

  while (decimalValue > 0) {
    int remainder = decimalValue % 16;

    String hexDigit = switch (remainder) {
      10 => 'A',
      11 => 'B',
      12 => 'C',
      13 => 'D',
      14 => 'E',
      15 => 'F',
      _ => remainder.toString(), // For 0-9, just keep the number as a string
    };

    hexResult = hexDigit + hexResult;

    decimalValue = decimalValue ~/ 16;
  }

  return hexResult;
}
