import 'package:intl/intl.dart';


class DateTimeConverter{
  static String convertDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

class MoneyFormat {
  MoneyFormat._();

  static final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi-VN');

  static String convertDoubleToString(double money) {
    return formatCurrency.format(money);
  }
}
