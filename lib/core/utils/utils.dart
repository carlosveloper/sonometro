import 'package:intl/intl.dart';
import 'package:miapp/core/utils/extensions.dart';

String dayTimePresentation(int difference, DateTime dateTime,
    {bool hoyFecha = false}) {
  if (difference < 6 && difference > 0) {
    var formattedDate = DateFormat('EEEE', 'es-ES').format(dateTime);

    return formattedDate.capitalize;
  } else if (difference == 0) {
    var formattedDate = 'Hoy';
    if (!hoyFecha) {
      formattedDate = DateFormat('H:mm a').format(dateTime);
    }

    return formattedDate;
  } else if (difference == 1) {
    return 'ayer';
  } else {
    var formattedDate = DateFormat('EEEE, dd MMMM .', 'es-ES').format(dateTime);
    return formattedDate.capitalize;
  }
}
