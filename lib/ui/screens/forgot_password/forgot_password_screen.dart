import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/forgot_password/forgot_password_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';


/// Purpose : forgot password screen
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with ValidationMixin, UtilityMixin {
  late AppLocalizations? t;
  late ForgotPasswordBloc _bloc;

  String? _email;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);

    return BaseScreen<ForgotPasswordBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
      },
      builder: (context, bloc, child) =>
          BlocListener<ForgotPasswordBloc, BaseState>(
        listener: (context, state) {
          if (state is SuccessState) {
            _formKey.currentState?.reset();
            //display popup
            CustomAlert().showInformativeDialog(
              context,
              title: t?.lblLinkSent ?? "",
              content: t?.lblMsgLinkSent ?? "",
              btnOkText: t?.lblOkay ?? "",
              onWillPop: () async {
                _dismissPopupAndNavigateBack();
                return true;
              },
              onOkTap: _dismissPopupAndNavigateBack,
            );
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
                      SliverAppBar(
                        leading: Container(),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close)),
                          )
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                              height: MediaQuery.of(context).size.height - 150,
                              child: _buildView()),
                        ]),
                      ),
                    ],
                  ),
                ),
                const LoaderView<ForgotPasswordBloc>(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildView() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppStyles.pageSideMargin),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(),
              _vSpacer(15),
              _headerMsg(),
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
              _vSpacer(30),
              _btn(),
            ],
          ),
        ),
      );

  Widget _header() => Text(
        t?.lblResetPassword ?? "",
        textAlign: TextAlign.center,
        style: AppStyles.titleTextStyle,
      );

  Widget _headerMsg() => Text(
        t?.lblMsgResetPassword ?? "",
        textAlign: TextAlign.center,
        style: AppStyles.commonSecondaryLargeTextStyle,
      );

  Widget _btn() => appCommonButton(
        btnTxt: t?.lblSend ?? "",
        // isButtonEnabled: _isValid,
        onPressed: _onClickBtn,
      );

  SizedBox _vSpacer(double height) => SizedBox(
        height: height,
      );

  void _executeValidation() {
    final isValid = _formKey.currentState?.validate() ?? false;
    // if (_isValid != isValid) {
    //   setState(() {
    //     _isValid = isValid;
    //   });
    // }
  }

  /// Purpose : click method for login button
  void _onClickBtn() {
    if (_formKey.currentState?.validate() ?? false) {
      //redirect to home
      _formKey.currentState?.save();
      hideKeyboard(context);
      _bloc.add(PasswordResetEvent(email: _email));
    }
  }

  void _dismissPopupAndNavigateBack() {
    //dismiss popup
    Navigator.of(context).pop();
    //back to previous screen
    Navigator.of(context).pop();
  }
}
