class DateTimeConverter{
  static String convertDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}