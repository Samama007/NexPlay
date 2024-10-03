import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(backgroundColor: backgroundColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: foregroundColor, fontSize: 16), // Base style for all text
              children: const [
                TextSpan(
                  text: 'Terms and Conditions\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                TextSpan(
                  text: 'General Site Usage\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextSpan(
                  text: 'Last Revised: December 16, 2013\n\n',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: 'Welcome to www.lorem-ipsum.info. This site is provided as a service to our visitors and may be used for informational purposes only. Because the Terms and Conditions contain legal obligations, please read them carefully.\n\n',
                ),
                TextSpan(
                  text: '1. YOUR AGREEMENT\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'By using this Site, you agree to be bound by, and to comply with, these Terms and Conditions. If you do not agree to these Terms and Conditions, please do not use this site.\n\n',
                ),
                TextSpan(
                  text: 'PLEASE NOTE:\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'We reserve the right, at our sole discretion, to change, modify or otherwise alter these Terms and Conditions at any time... For your information, this page was last updated as of the date at the top of these terms and conditions.\n\n',
                ),
                // Continue similarly for the rest of the text
                TextSpan(
                  text: '2. PRIVACY\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Please review our Privacy Policy, which also governs your visit to this Site, to understand our practices.\n\n',
                ),
                // Add more sections similarly
                TextSpan(
                  text: '11. PLACE OF PERFORMANCE\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'This Site is controlled, operated and administered by us from our office in Kiev, Ukraine. We make no representation that materials at this site are appropriate or available for use at other locations outside of the Ukraine and access to them from territories where their contents are illegal is prohibited. If you access this Site from a location outside of the Ukraine, you are responsible for compliance with all local laws.\n\n',
                ),
                TextSpan(
                  text: '12. GENERAL\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'A. If any provision of these Terms and Conditions is held to be invalid or unenforceable, the provision shall be removed... These Terms and Conditions set forth the entire understanding and agreement between us with respect to the subject matter contained herein.\n\n',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
