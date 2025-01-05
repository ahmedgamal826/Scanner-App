import 'package:flutter/material.dart';

class CustomShowDialog {
  static Future<void> showCustomDialog(BuildContext context) async {
    // إظهار الـ Dialog
    showDialog(
      context: context,
      barrierDismissible: false, // يمنع إغلاق الـ Dialog عند النقر خارجها
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: const AnimatedScale(
            duration: Duration(milliseconds: 500), // مدة تأثير الانيميشن
            scale: 1.1, // مقياس التأثير
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'PDF name already exists!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // إغلاق الـ Dialog بعد 2 ثانية
    await Future.delayed(const Duration(seconds: 2));

    // إغلاق الـ Dialog بعد فترة زمنية معينة
    Navigator.of(context).pop();
  }
}
