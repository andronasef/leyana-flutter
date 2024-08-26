import 'package:flutter/material.dart';
import 'package:leyana/utils/logger.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

void launchUrl(String link, BuildContext context) async {
  if (link.isEmpty) {
    logger.e('Link is empty');
    return;
  }

  if (!await canLaunchUrlString(link)) {
    logger.e('Link is not valid / cannot be launched');
    if (context.mounted) showSnackbar(context, "لا يمكن فتح الرابط");
    return;
  }

  await launchUrlString(link);
}
