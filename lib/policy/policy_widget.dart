import '/components/onboarding_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'policy_model.dart';
export 'policy_model.dart';

class PolicyWidget extends StatefulWidget {
  const PolicyWidget({super.key});

  static String routeName = 'policy';
  static String routePath = '/policy';

  @override
  State<PolicyWidget> createState() => _PolicyWidgetState();
}

class _PolicyWidgetState extends State<PolicyWidget> {
  late PolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PolicyModel());

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
                        '''# 🔒 Privacy Policy\n**Effective Date:** October 24, 2025  \n**Company:** Ear to Hear Media, LLC  \n**Contact:** [support@scripturlyapp.com](mailto:support@scripturlyapp.com)\n\n## 1. Introduction\nAt **Ear to Hear Media, LLC**, your privacy matters to us.  \nThis Privacy Policy explains how we collect, use, and protect your information when you use our **Bible Study App** (“the App”) on mobile or web platforms.  \n\nBy using the App, you agree to the practices described in this policy.  \n\n## 2. Information We Collect\nWe collect information to provide a better, more personalized experience. This includes:  \n\n### a. Information You Provide\n- **Account details:** name, email address, password, and profile information.  \n- **Payment information:** when purchasing a subscription or paid add-on (handled by trusted third parties like Stripe, Apple, and Google).  \n- **Communication preferences:** including when you contact us for support or opt into notifications.  \n\n### b. Automatically Collected Information\nWhen you use the App, we automatically collect:  \n- **Device and usage data:** such as device model, browser type, operating system, IP address, and usage patterns.  \n- **Analytics data:** through Firebase and Google Analytics to help us understand how users interact with the App and improve performance.  \n- **Cookies and similar technologies:** to remember preferences, improve features, and track performance.  \n\n### c. Location Data\nWe may collect approximate location data to improve recommendations, translations, or local devotional content.  \n\n## 3. How We Use Your Information\nWe use your data to:  \n- Provide, operate, and improve the App.  \n- Process payments and manage subscriptions.  \n- Send devotional, educational, and promotional notifications.  \n- Respond to inquiries and support requests.  \n- Comply with legal obligations and enforce our Terms of Service.  \n\nWe do **not sell** your personal information.  \n\n## 4. Notifications and Communications\nWe may send:  \n- **Informational messages** (e.g., Bible verses, study reminders).  \n- **Promotional content** (e.g., new features, special offers).  \n\nYou can manage notifications in your device settings or unsubscribe from emails at any time.  \n\n## 5. Third-Party Services\nWe work with trusted partners to deliver essential features:  \n- **Firebase** (authentication and analytics)  \n- **Google Analytics** (usage analytics)  \n- **Stripe** (secure payment processing)  \n- **Apple App Store** and **Google Play Store** (app distribution and in-app billing)  \n\nEach of these providers has its own privacy policy that governs how they handle your data. We encourage you to review them for more information.  \n\n## 6. International Users\nOur App is available globally.  \nIf you access the App from outside the United States, you agree that your data may be transferred to and processed in the U.S. in accordance with this policy.  \n\nWe comply with international privacy principles, including the **General Data Protection Regulation (GDPR)** for users in the European Union and the **California Consumer Privacy Act (CCPA)** for users in California.  \n\n## 7. Data Retention and Deletion\nWe retain your personal information for as long as necessary to provide the service or comply with legal obligations.  \n\nYou can delete your account — and your personal data — directly from the App’s settings. Once deleted, your data is permanently removed from our systems (except where retention is required by law).  \n\n## 8. Data Security\nWe use industry-standard measures to protect your data, including encryption, secure servers, and authentication controls.  \n\nHowever, no system is completely secure. By using the App, you acknowledge that you share data at your own risk, and we cannot guarantee absolute security.  \n\n## 9. Children’s Privacy\nThe App is intended for users aged **13 and older**.  \nWe do not knowingly collect data from children under 13. If we learn that we have done so, we will delete it promptly.  \n\n## 10. Your Rights\nDepending on where you live, you may have the right to:  \n- Access the information we hold about you.  \n- Request corrections or deletion of your data.  \n- Withdraw consent for data use or marketing communications.  \n- File a complaint with your local data protection authority.  \n\nTo exercise these rights, contact us at [support@scripturlyapp.com](mailto:support@scripturlyapp.com).  \n\n## 11. Changes to This Policy\nWe may update this Privacy Policy from time to time.  \nWhen we make changes, we’ll post the updated version within the App and update the **Effective Date** at the top.  \n\nYour continued use after updates means you accept the revised policy.  \n\n## 12. Contact Us\nIf you have questions or concerns about this Privacy Policy, please contact:  \n**Ear to Hear Media, LLC**  \n📧 [support@scripturlyapp.com](mailto:support@scripturlyapp.com)\n''',
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
