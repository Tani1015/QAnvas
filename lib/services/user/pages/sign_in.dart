import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';

//クラスインポート
import 'package:qanvas/services/user/controller/user_controller.dart';
import 'package:qanvas/utils/animation.dart';
import '../data/login_data.dart';


class SignInPage extends GetWidget<UserController>{

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final FirebaseController = Get.put(UserController());

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final LoginProducts = Get.put(LoginProduct());

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(


          child: Column(
            children: <Widget> [
              SizedBox(height: height * 0.15),
              //画像配置
              FadeAnimation(
                delay: 1,
                child: SizedBox(
                  height:  height * 0.13,
                  width:   weight * 0.6,
                  child: Image.asset('assets/images/QAnvas_title.png'),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(height: height * 0.03,),
              FadeAnimation(
                delay: 2,
                child: Container(
                  width: weight * 0.9,
                  height: height * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: LoginProducts.selected == Gender.email ? LoginProducts.enabled : LoginProducts.background,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTap: () {
                      LoginProducts.emailselect();
                    },
                    controller: email,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle_outlined,color: LoginProducts.selected == Gender.email ? LoginProducts.enabledtxt : LoginProducts.deaible,),
                      hintText: 'メール',
                      hintStyle: TextStyle(
                        color: LoginProducts.selected == Gender.email ? LoginProducts.enabledtxt : LoginProducts.deaible,
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: "Font3",
                        color: LoginProducts.selected == Gender.email ? LoginProducts.enabledtxt : LoginProducts.deaible,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02,),

              FadeAnimation(
                  delay: 2,
                  child: Container(
                    width: weight * 0.9,
                    height: height * 0.071,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: LoginProducts.selected == Gender.password ? LoginProducts.enabled : LoginProducts.background
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() => TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onTap: () {
                        LoginProducts.selected = Gender.password;
                      },
                      controller: pass,
                      decoration: InputDecoration(
                        enabledBorder:  InputBorder.none,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_open_outlined, color: LoginProducts.selected == Gender.password ? LoginProducts.enabledtxt : LoginProducts.deaible,),
                        suffixIcon: IconButton(
                            icon: LoginProducts.password.value ? Icon(Icons.visibility_off,color: LoginProducts.selected == Gender.password ? LoginProducts.enabledtxt : LoginProducts.deaible,): Icon(Icons.visibility, color: LoginProducts.selected == Gender.password ? LoginProducts.enabledtxt : LoginProducts.deaible,),
                            onPressed: () {
                              LoginProducts.password.value = !LoginProducts.password.value;
                            }
                        ),
                        hintText: 'パスワード',
                        hintStyle: TextStyle(
                            color: LoginProducts.selected == Gender.password ? LoginProducts.enabledtxt : LoginProducts.deaible
                        ),
                      ),
                      obscureText: LoginProducts.password.value,
                      style: TextStyle(
                          fontFamily: "Font3",
                          color: LoginProducts.selected == Gender.password ? LoginProducts.enabledtxt : LoginProducts.deaible,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    ),
                  )
              ),
              SizedBox(height: height * 0.06),
              FadeAnimation(
                  delay: 3,
                  child: TextButton(
                    onPressed: () {
                      _login();
                    },
                    child: const Text("ログイン",style: TextStyle(
                        fontFamily: "Font3",
                        color: Colors.white,letterSpacing: 0.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical:  10.0, horizontal: 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )
                    ),
                  )
              ),
              SizedBox(height: height * 0.10,),
              FadeAnimation(delay: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SignInButton.mini(
                          buttonType: ButtonType.google,
                          onPressed: () {}
                      ),
                      SignInButton.mini(
                          buttonType: ButtonType.microsoft,
                          onPressed: () {}
                      ),
                      SignInButton.mini(
                          buttonType: ButtonType.apple,
                          onPressed: () {}
                      ),
                      SignInButton.mini(
                          buttonType: ButtonType.yahoo,
                          onPressed: () {}
                      ),
                    ],
                  )
              ),
              SizedBox(height: height * 0.08,),
              FadeAnimation(
                  delay: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("アカウントを持っていない方 ", style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        // decoration: TextDecoration.underline,
                        // decorationThickness: 3
                      )),
                      const Text(" ー＞ ", style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                      )),
                      GestureDetector(
                        onTap: (){
                          Get.offNamed('/SignUp');
                        },
                        child: Text("登 録",style: TextStyle(
                          color:  const Color(0xFF0DF5E4).withOpacity(1),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,

                        )),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    )
    ;
  }

  void _login() {
    FirebaseController.login(email.text, pass.text);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserController>('Firebase_controller', FirebaseController));
    properties.add(DiagnosticsProperty<UserController>('Firebase_controller', FirebaseController));
    properties.add(DiagnosticsProperty<UserController>('Firebase_controller', FirebaseController));
    properties.add(DiagnosticsProperty<UserController>('FirebaseController', FirebaseController));
  }
}