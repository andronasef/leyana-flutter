import 'package:flutter/material.dart';
import 'package:leyana/utils/logger.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

void launchUrl(String link, BuildContext context) async {
  try {
    await launchUrlString(link);
  } catch (e) {
    logger.e('Error launching link: $e');
    if (context.mounted) showSnackbar(context, "حدث خطأ أثناء فتح الرابط");
  }
}
