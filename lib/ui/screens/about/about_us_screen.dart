import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_config.dart';
import '../../../constants/api_constants.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';

/// Purpose : about us screen --> opens from side menu navigation
class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> with UtilityMixin {
  late AppLocalizations? t;
  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(t?.lblAboutUs ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.pageSideMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SvgPicture.asset(
                  //   AppAssets.imgLogo,
                  //   height: 45,
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "${t?.lblAppVersion} 1.0",
                    style: AppStyles.commonPrimaryLargeTextStyle,
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    style: AppStyles.commonLabelsTextStyle,
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onClickPrivacyPolicy,
                        text: "${t?.lblPrivacyPolicy}.",
                        style: AppStyles.commonPrimaryLargeTextStyle,
                      ),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onClickServices,
                        text: t?.lblTermsOfServices,
                        style: AppStyles.commonPrimaryLargeTextStyle,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.border,
                ),
                const SizedBox(
                  height: AppStyles.pageSideMargin,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onClickPrivacyPolicy() async {
    await launchUrl(
        context, "${getPrivacyPolicyUrl[AppConfig.apiEnvironment]}");

    /*final url = Uri.parse("${getPrivacyPolicyUrl[AppConfig.apiEnvironment]}");
    if (await canLaunchUrl(url)) {
    await launchUrl(url);
    } else {
    throw Exception('Could not launch $url');
    }*/
  }

  Future<void> _onClickServices() async {
    await launchUrl(
        context, "${getTermsOfServiceUrl[AppConfig.apiEnvironment]}");

    /* final url = Uri.parse("${getTermsOfServiceUrl[AppConfig.apiEnvironment]}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }*/
  }
}
