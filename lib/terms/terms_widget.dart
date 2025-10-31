import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'terms_model.dart';
export 'terms_model.dart';

class TermsWidget extends StatefulWidget {
  const TermsWidget({super.key});

  static String routeName = 'terms';
  static String routePath = '/terms';

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  late TermsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.onboardingHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: OnboardingHeaderWidget(
                    isSignUp: false,
                    showText: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: MarkdownBody(
                    data:
                        '''# 📜 Terms and Conditions\n**Effective Date:** October 24, 2025  \n**Company:** Ear to Hear Media, LLC  \n**Contact:** [support@scripturlyapp.com](mailto:support@scripturlyapp.com)\n\n## 1. Overview\nWelcome to the Bible Study App (“the App”), operated by **Ear to Hear Media, LLC** (“we,” “our,” “us”). By using the App, you agree to these Terms and Conditions (“Terms”). Please read them carefully.  \n\nIf you do not agree, please do not use the App.  \n\n## 2. Eligibility\nThe App is available to individuals aged **13 and older**. By creating an account or using the App, you confirm that you meet this age requirement.\n\n## 3. Accounts and Access\nTo use certain features, you’ll need to create an account. You’re responsible for maintaining the confidentiality of your login credentials and for all activity under your account.  \n\nYou can delete your account at any time from the settings menu.  \n\n## 4. Payments and Subscriptions\nThe App is a **paid service**. Pricing may change over time, and we reserve the right to introduce additional features or premium add-ons at higher prices.  \n\nPayments made through **Google Play** or the **Apple App Store** follow their respective refund and billing policies.  \nFor direct payments, we follow industry-standard practices consistent with major apps like **Duolingo** and **Headspace**—refunds are reviewed case-by-case and may be granted at our sole discretion in cases of accidental charge or technical failure.  \n\n## 5. Intellectual Property and Bible Content\nAll content within the App—including text, audio, design, and graphics—is owned or licensed by **Ear to Hear Media, LLC**. You may not copy, reproduce, or distribute any content for **commercial purposes** without prior written permission.  \n\n**Bible content copyright and licensing:**  \n- Scriptures quotations marked **KJV** are taken from the *King James (Authorised) Version*, Copyright 2025 Public Domain — except in the United Kingdom, where a Crown Copyright applies. Creative Commons. [https://ebible.org](https://ebible.org)  \n- *New King James Version®*, Copyright © 1982, Thomas Nelson. All rights reserved. [http://harpercollins.com](http://harpercollins.com)  \n- *Holy Bible, New Living Translation*, Copyright © 2014, Tyndale House Publishers. All rights reserved. [https://tyndale.com](https://tyndale.com)  \n\n## 6. Sharing and Social Media\nYou may share verses, insights, or other content from the App to external platforms (like social media) for **personal, non-commercial use**.  \n\nPlease give appropriate attribution when sharing publicly.  \n\n## 7. Acceptable Use\nYou agree not to:  \n- Use the App in any way that violates applicable laws or regulations.  \n- Attempt to disrupt, damage, or gain unauthorized access to our systems.  \n- Use the App for any form of commercial exploitation without permission.  \n\n## 8. Notifications and Communications\nWe may send you **informational, devotional, and promotional notifications**. You can manage notification settings within your device or account preferences.  \n\n## 9. Third-Party Services\nWe use trusted third-party providers for analytics, payments, and authentication:  \n- **Firebase** (analytics and authentication)  \n- **Google Analytics** (usage analytics)  \n- **Stripe** (direct payments)  \n- **Apple App Store** and **Google Play Store** (app distribution and payments)  \n\nThese services have their own terms and privacy policies.  \n\n## 10. Termination\nWe reserve the right to suspend or terminate your account if you violate these Terms or misuse the App.  \n\n## 11. Disclaimers and Limitation of Liability\nWe strive to maintain a reliable, spiritually enriching experience, but we do not guarantee the App will always be error-free or uninterrupted.  \n\nTo the fullest extent permitted by law, **Ear to Hear Media, LLC** is not liable for indirect, incidental, or consequential damages arising from your use of the App.  \n\n## 12. Governing Law\nThese Terms are governed by the laws of the **State of California, United States**, without regard to conflict of law principles.  \n\nIf a dispute arises, you agree to first contact us at [support@scripturlyapp.com](mailto:support@scripturlyapp.com) to seek resolution before pursuing legal action.  \n\n## 13. Updates to These Terms\nWe may update these Terms periodically. When we do, we’ll post the updated version in the App and update the “Effective Date.” Continued use after changes means you accept the new Terms.  \n\n## 14. Contact Us\nFor questions or concerns, please reach out to us at:  \n**Ear to Hear Media, LLC**  \n📧 [support@scripturlyapp.com](mailto:support@scripturlyapp.com)\n''',
                    selectable: true,
                    onTapLink: (_, url, __) => launchURL(url!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
