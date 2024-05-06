import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_config.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/signup/sign_up_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';
import '../home_base/home_base_screen.dart';


/// Purpose : sign up screen of the app
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with ValidationMixin, UtilityMixin {
  late AppLocalizations? t;
  final _sidePadding = 25.0;
  // bool _isValid = false;
  bool _isTermsSelected = false;

  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();
  final _appBar = const SliverAppBar();

  late SignUpBloc _bloc;
  String? _email;
  String? _pass;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);
    return BaseScreen<SignUpBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
      },
      builder: (context, bloc, child) => BlocListener<SignUpBloc, BaseState>(
        listener: (context, state) {
          if (state is SuccessState) {
            //do redirection
            // showSnackBar(context, "Success!");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const HomeBaseScreen(
                          showVerificationAlert: true,
                        )),
                (route) => false);
          }
          if (state is ConnectionFailedState) {
            showSnackBar(context, t?.errConnectionFailed ?? "");
          }
          if (state is FailedState) {
            showSnackBar(context, state.msg ?? t?.errSomethingWentWrong ?? "");
          }
        },
        child: GestureDetector(
          onTap: () => hideKeyboard(context),
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: AppStyles.loginBgDecoration,
                  child: CustomScrollView(
                    slivers: [
                      _appBar,
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                              height: MediaQuery.of(context).size.height - 200,
                              child: _buildSignUpView()),
                          _vSpacer(20),
                          _linkLogin(),
                          _vSpacer(20),
                        ]),
                      ),
                    ],
                  ),
                ),
                const LoaderView<SignUpBloc>(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpView() => Padding(
        padding: EdgeInsets.symmetric(horizontal: _sidePadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(),
              _vSpacer(30),
              CustomTextInputField(
                labelText: t?.lblEmailAddress,
                inputType: TextInputType.emailAddress,
                validator: (value) => emailValidator(context, value!) != ""
                    ? emailValidator(context, value)
                    : null,
                // onChanged: (_) => _executeValidation(),
                onSave: (value) {
                  Logger.d("email", value);
                  _email = value;
                },
              ),
              _vSpacer(20),
              CustomTextInputField(
                fieldKey: _passKey,
                labelText: t?.lblPassword,
                isPassWord: true,
                enablePasswordVisibility: false,
                validator: (value) => passwordValidator(context, value!) != ""
                    ? passwordValidator(context, value)
                    : null,
                // onChanged: (_) => _executeValidation(),
              ),
              _vSpacer(20),
              CustomTextInputField(
                labelText: t?.lblConfirmPassword,
                isPassWord: true,
                enablePasswordVisibility: false,
                validator: (value) => confirmPasswordValidator(
                            context, _passKey.currentState?.value, value!) !=
                        ""
                    ? confirmPasswordValidator(
                        context, _passKey.currentState?.value, value)
                    : null,
                // onChanged: (_) => _executeValidation(),
                onSave: (value) {
                  Logger.d("confirm password", value);
                  _pass = value;
                },
              ),
              _vSpacer(20),
              _termsCheckBox(),
              _vSpacer(30),
              _btnSignUp(),
            ],
          ),
        ),
      );

  Widget _header() => Text(
        t?.lblWelcomeAboard ?? "",
        textAlign: TextAlign.center,
        style: AppStyles.titleTextStyle,
      );

  Widget _termsCheckBox() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRadioCheckBoxWidget(
            onChanged: _onChangedRememberMe,
            value: _isTermsSelected,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 10,
              ),
              child: Text.rich(
                TextSpan(
                  text: t?.lblBySigningUpIAgree,
                  style: AppStyles.commonLabelsTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onClickPrivacyPolicy,
                      text: t?.lblPrivacyPolicy,
                      style: AppStyles.commonLabelsUnderlineTextStyle,
                    ),
                    TextSpan(
                      text: t?.lblAndThe,
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onClickServices,
                      text: t?.lblTermsOfServices,
                      style: AppStyles.commonLabelsUnderlineTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _btnSignUp() => appCommonButton(
        btnTxt: t?.lblSignUp ?? "",
        // isButtonEnabled: _isValid,
        onPressed: _onClickSignUp,
      );

  Widget _linkLogin() => Container(
        alignment: Alignment.center,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: _onClickLogin,
          child: RichText(
            text: TextSpan(
                text: t?.lblAlreadyHaveAccount,
                style: AppStyles.commonLabelsTextStyle,
                children: [
                  TextSpan(
                    text: t?.lblLogin,
                    style: AppStyles.commonLabelsUnderlineTextStyle,
                  )
                ]),
          ),
        ),
      );

  SizedBox _vSpacer(double height) => SizedBox(
        height: height,
      );

  void _executeValidation() {
    final isValid =
        (_formKey.currentState?.validate() ?? false) && _isTermsSelected;
    // if (_isValid != isValid) {
    //   setState(() {
    //     _isValid = isValid;
    //   });
    // }
  }

  void _onChangedRememberMe(bool val) {
    setState(() {
      _isTermsSelected = val;
    });
    hideKeyboard(context);
    // _executeValidation();
  }

  /// Purpose : click method for login button
  void _onClickSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_isTermsSelected) {
        showSnackBar(context, t?.errTermsNotSelected ?? "");
      } else {
        //redirect to home
        _formKey.currentState?.save();
        hideKeyboard(context);
        _bloc.add(SignUpUser(
          email: _email!,
          password: _pass!,
        ));
      }
    }
  }

  void _onClickLogin() {
    hideKeyboard(context);
    Navigator.of(context).pop();
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
