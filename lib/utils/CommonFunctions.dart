import 'dart:convert';
import 'dart:math';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/constants/assets.dart';
import 'package:glive/utils/globalVariables.dart';
import 'package:uuid/uuid.dart';

int randomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min);
}

String uid() {
  var uuid = const Uuid();
  return uuid.v4();
}

String randomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

Color rgba(
  int r,
  int g,
  int b,
  double a,
) {
  return Color.fromRGBO(r, g, b, a);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class RowBuilder extends StatelessWidget {
  const RowBuilder({
    super.key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  });

  final IndexedWidgetBuilder? itemBuilder;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          List.generate(itemCount!, (index) => itemBuilder!(context, index))
              .toList(),
    );
  }
}

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;
  const ColumnBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }
}

String getFileExtension(String path) {
  Uri uri = Uri.parse(path);
  List<String> split = uri.path.split("/");
  String filename = split[split.length - 1];
  List<String> split2 = filename.split(".");
  String extension = split2[split2.length - 1];

  return extension;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

Key createKey() {
  return Key(randomString(100));
}

Key createKeyId(String prefix, String id) {
  return Key("${prefix}_$id");
}

Map<String, dynamic> getParams(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
}

String getAge(String date) {
  List splitted = date.split("-");
  int year = int.parse(splitted[0]);
  int month = int.parse(splitted[1]);
  int day = int.parse(splitted[2]);
  return AgeCalculator.age(DateTime(year, month, day)).years.toString();
}

void showComingSoon(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: heightScreen(),
          width: widthScreen(),
          decoration: BoxDecoration(
            color: rgba(0, 0, 0, 0.1),
          ),
          child: Center(
            child: TapRegion(
              onTapOutside: (event) {
                Navigator.pop(context);
              },
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.coming_soon,
                      width: 368 * 0.5,
                      height: 266 * 0.5,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Stay tuned!",
                      style: TextStyle(color: AppColors.black, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

String commaNumber(double number) {
  // Split the number into integer and decimal parts
  List<String> parts = number.toStringAsFixed(2).split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? parts[1] : '';

  // Regular expression to format the integer part with commas
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  matchFunc(Match match) => '${match[1]},';

  // Apply the comma formatting to the integer part
  String formattedIntegerPart = integerPart.replaceAllMapped(reg, matchFunc);

  // Combine the formatted integer part with the decimal part
  return decimalPart.isNotEmpty
      ? '$formattedIntegerPart.$decimalPart'
      : formattedIntegerPart;
}

String padDateString(String dateString) {
  List splitted = dateString.split("-");
  String year = splitted[0];
  String month = splitted[1];
  String day = splitted[2];

  if (month.length == 1) {
    month = "0$month";
  }
  if (day.length == 1) {
    day = "0$day";
  }

  return "$year-$month-$day";
}

String convertDateFormat(String dateString) {
  // Parse the date string
  DateTime date = DateTime.parse(padDateString(dateString));
  // Format the date into "Month day, year" format
  String formattedDate = DateFormat('MMMM d, y').format(date);

  return formattedDate;
}

String formatPhoneNumber(String phoneNumber) {
  // Remove any non-digit characters from the phone number
  phoneNumber = phoneNumber.replaceAll(RegExp(r'\D+'), '');

  // Check if the phone number length is valid
  if (phoneNumber.length != 11) {
    // Return the original phone number if it's not in the expected format
    return phoneNumber;
  }

  // Split the phone number into its components
  String countryCode = phoneNumber.substring(0, 4);
  String firstGroup = phoneNumber.substring(4, 7);
  String secondGroup = phoneNumber.substring(7);

  // Format the phone number with spaces
  String formattedPhoneNumber = '$countryCode $firstGroup $secondGroup';

  return formattedPhoneNumber;
}

bool validatePhoneNumber(String phoneNumber) {
  // Check if the length of the phone number is at least 11 characters
  if (phoneNumber.length < 11) {
    return false;
  }

  // Extract the first two characters of the phone number
  String firstTwoChars = phoneNumber.substring(0, 2);

  // Check if the first two characters are "09"
  if (firstTwoChars == "09") {
    return true;
  } else {
    return false;
  }
}

String formatDateTime(DateTime mydate) {
  // Format time in 12-hour format with AM/PM

  DateTime dateTime = mydate;

  if (!dateTime.isUtc) {
    dateTime = dateTime.toUtc();
  }

  if (dateTime.isUtc && dateTime.timeZoneOffset == Duration.zero) {
    dateTime = dateTime.add(const Duration(hours: 8));
  }

  String time = DateFormat('h:mm:ss a').format(dateTime);

  // Format date in "Month day, year" format
  String date = DateFormat('MMMM d, y').format(dateTime);

  return '$time $date';
}

String encodeToJson(dynamic data) {
  if (data != null) {
    return jsonEncode(data);
  } else {
    return "";
  }
}

bool isSuperAdmin() {
  return GlobalVariables.currentUser.userType == "super-admin";
}

String removeTrailingSlash(String url) {
  if (url.endsWith('/')) {
    return url.replaceAll(RegExp(r'/+$'), '');
  }
  return url;
}
