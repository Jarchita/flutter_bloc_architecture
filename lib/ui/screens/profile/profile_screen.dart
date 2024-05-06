import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/profile/profile_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';


/// Purpose : My profile tab view
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.appBar, Key? key}) : super(key: key);

  final PreferredSizeWidget appBar;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with UtilityMixin, ValidationMixin {
  late AppLocalizations? t;
  late ProfileBloc _bloc;

  bool _changePassword = false;
  // bool _isValid = false;
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isExternalLogin = true;
  String? _currentPass;
  String? _newPass;
  @override
  void initState() {
    _getUser();
    super.initState();
  }

  Future<void> _getUser() async {
    // final prefs = await SharedPreferences.getInstance();
    // final email = prefs.getString(PrefKeys.userEmail);
    // final token = prefs.getString(PrefKeys.accessToken);
    // final authProvider = prefs.getString(PrefKeys.authProvider);
    // if (email != null) {
    //   setState(() {
    //     _isExternalLogin = authProvider != null && authProvider != "";
    //     _emailController.text = email;
    //   });
    //   Logger.d("profile", email);
    //   Logger.d("token", token);
    // }
  }

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);

    return BaseScreen<ProfileBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
      },
      builder: (context, bloc, child) => BlocListener<ProfileBloc, BaseState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            _emailController.text = state.data;
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
            backgroundColor: AppColors.bg,
            appBar: widget.appBar,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppStyles.pageSideMargin),
                  child: Container(
                    decoration: AppStyles.commonRectContainer,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - (190)),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          CommonContentHeader(
                              t: t, title: t?.tabLblProfile ?? ""),
                          _profileView(),
                          if (_changePassword)
                            CommonContentHeader(
                                t: t, title: t?.lblChangePassword ?? ""),
                          if (_changePassword) _changePasswordView(),
                        ],
                      )),
                    ),
                  ),
                ),
                const LoaderView<ProfileBloc>(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileView() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppStyles.pageSideMargin),
        child: Column(
          children: [
            ///email
            CustomTextInputField(
              labelText: t?.lblEmailID,
              controller: _emailController,
              // initialValue: _email,
              enabled: false,
              boxBorderWhenDisabled: false,
              horizontalPaddingApplied: false,
            ),
            _vSpacer(20),

            if (!_isExternalLogin)

              ///password
              Stack(
                children: [
                  CustomTextInputField(
                    labelText: t?.lblPassword,
                    initialValue: "123123456",
                    isPassWord: true,
                    enablePasswordVisibility: false,
                    horizontalPaddingApplied: false,
                    enabled: false,
                    boxBorderWhenDisabled: false,
                  ),
                  if (!_changePassword)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: TextButton.icon(
                          onPressed: _onTapChangeButton,
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.accentGreen,
                          ),
                          label: Text(
                            t?.lblChange ?? "",
                            style: AppStyles.commonPrimaryTextStyle,
                          )),
                    )
                ],
              ),
          ],
        ),
      );

  Widget _changePasswordView() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppStyles.pageSideMargin),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _vSpacer(5),
              CustomTextInputField(
                labelText: t?.lblOldPassword,
                isPassWord: true,
                enablePasswordVisibility: false,
                // onChanged: (_) => _onTextChanged(),
                validator: (value) =>
                    emptyOldPasswordValidator(context, value!) != ""
                        ? emptyOldPasswordValidator(context, value)
                        : null,
                onSave: (value) {
                  _currentPass = value;
                },
              ),
              _vSpacer(20),
              CustomTextInputField(
                fieldKey: _passKey,
                labelText: t?.lblNewPassword,
                isPassWord: true,
                enablePasswordVisibility: false,
                // onChanged: (_) => _onTextChanged(),
                validator: (value) =>
                    newPasswordValidator(context, value!) != ""
                        ? newPasswordValidator(context, value)
                        : null,
              ),
              _vSpacer(20),
              CustomTextInputField(
                labelText: t?.lblConfirmNewPassword,
                isPassWord: true,
                enablePasswordVisibility: false,
                // onChanged: (_) => _onTextChanged(),
                validator: (value) => confirmPasswordValidator(
                            context, _passKey.currentState?.value, value!) !=
                        ""
                    ? confirmPasswordValidator(
                        context, _passKey.currentState?.value, value)
                    : null,
                onSave: (value) {
                  _newPass = value;
                },
              ),
              _vSpacer(25),

              ///buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: appCommonButton(
                      btnTxt: t?.lblCancel ?? "",
                      height: 45,
                      isNegative: true,
                      onPressed: _onCancel,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  Expanded(
                    child: appCommonButton(
                      btnTxt: t?.lblUpdate ?? "",
                      height: 45,
                      onPressed: _onUpdate,
                      // isButtonEnabled: _isValid,
                    ),
                  ),
                ],
              ),
              _vSpacer(25),
            ],
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

  void _onTapChangeButton() {
    setState(() {
      _changePassword = !_changePassword;
    });
  }

  void _onCancel() {
    _formKey.currentState?.reset();
    setState(() {
      _changePassword = !_changePassword;
      // _isValid = false;
    });
  }

  void _onUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _bloc.add(ChangePasswordEvent(current: _currentPass, newPass: _newPass));
    }
  }
}
