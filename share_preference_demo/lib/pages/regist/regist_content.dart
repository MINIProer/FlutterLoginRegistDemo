import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:share_preference_demo/extensions/int_extension.dart';
import 'package:share_preference_demo/extensions/local_storage_extension.dart';
import 'package:share_preference_demo/models/user_model.dart';
import 'package:share_preference_demo/tools/local_storage_tool.dart';
import 'package:share_preference_demo/viewModels/user_view_model.dart';
import 'package:share_preference_demo/widgets/input_textfiled.dart';
import 'package:share_preference_demo/widgets/submit_button.dart';

class JRRegistContent extends StatefulWidget {
  @override
  _JRRegistContentState createState() => _JRRegistContentState();
}

class _JRRegistContentState extends State<JRRegistContent> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  String _userName;
  String _pwd;
  String _submitButtonTitle = '注册';
  String _tipTitle = '已有账号，登录';
  String _userErrorMsg = '用户名或密码错误';
  String _pwdErrorMsg = '用户名或密码错误';
  bool _shouldShowUserErrorMsg = false;
  bool _shouldShowPwdErrorMsg = false;
  bool _isTipSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.px),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          JRInputTextField('用户名', userNameController,
              type: JRInputTextFieldType.registStyle, textChangeFunc: (str) {
            setState(() {
              this.userNameController.text = _userName = str;
            });
            keepCursorAtLast(this.userNameController, _userName);
          },
              shouldShowErrorMsg: _shouldShowUserErrorMsg,
              errorMsg: _userErrorMsg),
          SizedBox(height: 20.px),
          JRInputTextField('密码', pwdController,
              needSecure: true,
              type: JRInputTextFieldType.registStyle, textChangeFunc: (str) {
            setState(() {
              this.pwdController.text = _pwd = str;
            });
            keepCursorAtLast(this.pwdController, _pwd);
          }, shouldShowErrorMsg: _shouldShowPwdErrorMsg, errorMsg: _pwdErrorMsg),
          SizedBox(height: 20.px),
          GestureDetector(
            child: Text(_tipTitle, style: TextStyle(color: Colors.blue)),
            onTap: () {
              _isTipSelected = !_isTipSelected;
              setState(() {
                _submitButtonTitle = _isTipSelected ? '登录' : '注册';
                _tipTitle = _isTipSelected ? '注册' : '已有账号，登录';
              });
            },
          ),
          SizedBox(height: 20.px),
          shouldSubmitButtonEnable()
              ? Consumer<JRUserViewModel>(builder: (context, userVM, child) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: JRSubmitButton(_submitButtonTitle,
                        tapAction: () => submit(context, userVM)),
                  );
                })
              : JRSubmitButton(_submitButtonTitle)
        ],
      ),
    );
  }

  bool shouldSubmitButtonEnable() {
    if (userNameController.text.length != 0 && pwdController.text.length != 0) {
      return true;
    }
    return false;
  }

  void submit(BuildContext context, JRUserViewModel userVM) {
    if (_submitButtonTitle == '注册') {
      if (userVM.userNameExist(_userName) == true) {
        print('注册失败');
        setState(() {
          _shouldShowUserErrorMsg = true;
          _shouldShowPwdErrorMsg = false;
          _userErrorMsg = '用户已存在，请登录';
        });
        return;
      }

      Map<String, dynamic> userMap = {
        'username': _userName,
        'password': _pwd
      };

      JRLocalStorage.get('UserList').then((res) {
        if (res == null) {
          JRUserLoacalData.createUserListMap(userMap);
        } else {
          JRLocalStorage.get('UserList').then((res) {
            JRUserLoacalData.updateUserListMap(res, userMap);
          });
        }
      });

      JRUserModel userModel = JRUserModel.fromMap(userMap);
      userVM.add(userModel);

      print('注册成功');
      setState(() {});
      Navigator.of(context).pop();
    } else {
      JRLoginInputErrorType type = userVM.hasUser(_userName, _pwd);
      switch (type) {
        case JRLoginInputErrorType.error:
          {
            print('登录失败');
            setState(() {
              _userErrorMsg = '用户名或密码错误';
              _pwdErrorMsg = '用户名或密码错误';
              _shouldShowUserErrorMsg = true;
              _shouldShowPwdErrorMsg = true;
            });
          }
          break;
        case JRLoginInputErrorType.correct:
          {
            print('登录成功');
            _shouldShowUserErrorMsg = false;
            _shouldShowPwdErrorMsg = false;
            setState(() {});
            Navigator.of(context).pop();
          }
          break;
        default:
      }
    }
  }

  void keepCursorAtLast(TextEditingController controller, String text) {
    controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: text.length)));
  }

  @override
  void dispose() {
    userNameController.dispose();
    pwdController.dispose();
    super.dispose();
  }
}
