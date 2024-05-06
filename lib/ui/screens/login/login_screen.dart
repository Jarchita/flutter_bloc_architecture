import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../router/app_router.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../signup/sign_up_screen.dart';


/// Purpose : login screen of the app
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with ValidationMixin, UtilityMixin {
  late LoginBloc _bloc;
  late AppLocalizations? t;
  final _sidePadding = 25.0;
  // bool _isValid = false;

  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _pass;

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);
    _bloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          //do redirection
          // showSnackBar(context, "Success!");
          clearStackAndAddNamedRoute(context, RouteConstants.homeRoute);
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
                child: SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _logo(),
                      _buildLoginView(),
                    ],
                  ),
                ),
              ),
              const LoaderView<LoginBloc>(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() => Container(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 45,
      ),
     /* child: SvgPicture.asset(
        AppAssets.imgLoginLogo,
        height: 0,
      )*/);

  Widget _buildLoginView() => Padding(
        padding: EdgeInsets.symmetric(horizontal: _sidePadding),
        child: Form(
          key: _formKey,
          child: Column(
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
                // onChanged: (_) => _onTextChanged(),
                onSave: (value) {
                  Logger.d("email", value);
                  _email = value;
                },
              ),
              _vSpacer(20),
              CustomTextInputField(
                labelText: t?.lblPassword,
                isPassWord: true,
                validator: (value) =>
                    emptyPasswordValidator(context, value!) != ""
                        ? emptyPasswordValidator(context, value)
                        : null,
                // onChanged: (_) => _onTextChanged(),
                onSave: (value) {
                  Logger.d("password", value);
                  _pass = value;
                },
              ),
              _vSpacer(20),
              _btnForgotPassword(),
              _vSpacer(40),
              _btnLogin(),
              _vSpacer(30),
              _btnSignUp(),
              _vSpacer(20),
            ],
          ),
        ),
      );

  Widget _header() => Text(
        t?.lblPleaseSignIn ?? "",
        textAlign: TextAlign.center,
        style: AppStyles.titleTextStyle,
      );

  Widget _btnForgotPassword() => Container(
        alignment: Alignment.centerRight,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: _onClickForgotPassword,
          child: SizedBox(
            height: 20,
            child: Text(
              t?.lblForgotPassword ?? "",
              style: AppStyles.commonLabelsTextStyle,
            ),
          ),
        ),
      );

  Widget _btnLogin() => appCommonButton(
        btnTxt: t?.lblLogin ?? "",
        // isButtonEnabled: _isValid,
        onPressed: _onClickLogin,
      );

  Widget _or() => Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.border,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              t?.lblOrLoginVia ?? "",
              style: AppStyles.commonLabelsTextStyle,
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.border,
            ),
          ),
        ],
      );



  Widget _btnSignUp() => Container(
        alignment: Alignment.center,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: _onClickSignUp,
          child: RichText(
            text: TextSpan(
                text: t?.lblDontHaveAccount,
                style: AppStyles.commonLabelsTextStyle,
                children: [
                  TextSpan(
                    text: t?.lblSignup,
                    style: AppStyles.commonLabelsUnderlineTextStyle,
                  )
                ]),
          ),
        ),
      );

  SizedBox _vSpacer(double height) => SizedBox(
        height: height,
      );

  void _onTextChanged() {
    final isValid = _formKey.currentState?.validate();
    // if (_isValid != isValid) {
    //   setState(() {
    //     _isValid = isValid!;
    //   });
    // }
  }

  /// Purpose : click method for login button
  void _onClickLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      //redirect to home
      hideKeyboard(context);
      _formKey.currentState?.save();
      _bloc.add(LoginButtonPressed(
        email: _email!,
        password: _pass!,
      ));
    }
  }

  /// Purpose : click method for login button
  Future<void> _onClickForgotPassword() async {
    //redirect to reset pin
    hideKeyboard(context);
    await navigationPush(context, const ForgotPasswordScreen()).then((value) {
      _formKey.currentState?.reset();
      return null;
    });
  }

  Future<void> _onClickSignUp() async {
    //redirect to reset pin
    hideKeyboard(context);
    await navigationPush(context, const SignUpScreen()).then((value) {
      _formKey.currentState?.reset();
      return null;
    });
  }


}
