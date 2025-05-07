import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HumanFormats {
  static String number(double number, [int decimals = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formattedNumber;
  }

  static String shortDate( DateTime date ) {    
     // Asegúrate de inicializar la data de localización para español
    initializeDateFormatting('es', null);
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
}
