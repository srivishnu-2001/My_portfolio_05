import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launches a URI (phone, email, https) and shows a snackbar on failure.
Future<void> launchLink(BuildContext context, String uriString) async {
  final uri = Uri.parse(uriString);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open: $uriString'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

/// Pre-built launchers for the three contact modes.
void launchEmail(BuildContext context) =>
    launchLink(context, 'mailto:srivishnuthiriveedhi@gmail.com');

void launchPhone(BuildContext context) =>
    launchLink(context, 'tel:+918106824579');

void launchLinkedIn(BuildContext context) => launchLink(
      context,
      'https://www.linkedin.com/in/sri-vishnu-2a1777276?utm_source=share_via&utm_content=profile&utm_medium=member_android',
    );

void launchGitHub(BuildContext context) => launchLink(
      context,
      'https://github.com/srivishnu-thiriveedhi',
    );
