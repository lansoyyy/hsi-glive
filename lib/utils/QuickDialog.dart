// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glive/constants/appColors.dart';
import 'package:glive/utils/commonFunctions.dart';

class QuickDialog {
  static Future getString(BuildContext context, String title, String label) {
    Completer completer = Completer();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textController = TextEditingController();

        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        completer.complete(value);
      }
    });

    return completer.future;
  }

  static Future getStringCanBeEmpty(BuildContext context, String title, String label) {
    Completer completer = Completer();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textController = TextEditingController();

        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop("");
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    ).then((value) {
      completer.complete(value);
    });

    return completer.future;
  }

  static Future getStringDefault(BuildContext context, String title, String label, String defaultValue) {
    Completer completer = Completer();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textController = TextEditingController(text: defaultValue);

        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        completer.complete(value);
      }
    });

    return completer.future;
  }

  static Future getInt(BuildContext context, String title, String label, String defaultValue) {
    Completer completer = Completer();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textController = TextEditingController(text: defaultValue);

        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: textController,
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(textController.text);
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        completer.complete(value);
      }
    });

    return completer.future;
  }

  static Future deleteConfirmation(
    BuildContext context,
  ) {
    Completer completer = Completer();

    showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dialog dismissal when tapping on the backdrop
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Delete',
            style: TextStyle(fontSize: 18),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(false);
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red, // Customize text color for delete button
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(true);
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  static Future logoutConfirmation(
    BuildContext context,
  ) {
    Completer completer = Completer();

    showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dialog dismissal when tapping on the backdrop
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Logout',
            style: TextStyle(fontSize: 18),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(false);
              },
            ),
            TextButton(
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red, // Customize text color for delete button
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(true);
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  static Future disbursementConfirmation(BuildContext context, double amount, String name) {
    Completer completer = Completer();

    showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dialog dismissal when tapping on the backdrop
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmation',
            style: TextStyle(fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Confirm giving ₱ ${commaNumber(amount)} to $name?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(false);
              },
            ),
            TextButton(
              child: Text(
                'Disburse',
                style: TextStyle(
                  color: AppColors.primaryColor, // Customize text color for delete button
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(true);
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  static Future deleteAllConfirmation(
    BuildContext context,
  ) {
    Completer completer = Completer();

    showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dialog dismissal when tapping on the backdrop
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Delete',
            style: TextStyle(fontSize: 18),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete all the selected items?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(false);
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red, // Customize text color for delete button
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                completer.complete(true);
              },
            ),
          ],
        );
      },
    );

    return completer.future;
  }
}
