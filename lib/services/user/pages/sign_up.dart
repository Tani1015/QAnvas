import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//クラスインポート
import 'package:qanvas/utils/animation.dart';
import 'package:qanvas/services/user/controller/user_controller.dart';
import '../data/signup_data.dart';

class SignUpPage extends GetWidget<UserController>{

  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final firebaseController = Get.put(UserController());

  SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    final products = Get.put(SignUpProduct());


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: weight,
          height: height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: weight * 0.04),
                  child: const Icon(Icons.arrow_back_outlined,color: Colors.white,size: 35.0,),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),

              FadeAnimation(
                delay: 1,
                child: SizedBox(
                  height:  height * 0.13,
                  width:   weight * 0.6,
                  child: Image.asset('assets/images/QAnvas_title.png'),
                ),
              ),
              SizedBox(
                  height: height * 0.05
              ),
              FadeAnimation(
                delay: 2,
                child: Container(
                  width: weight * 0.9,
                  height:height * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: products.selected == Gender.fullName ?  products.enabled : products.background,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child:  TextField(
                    controller: name,
                    onTap: (){
                      products.nameselect();
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border:InputBorder.none,
                      prefixIcon: Icon(Icons.person_outlined,color: products.selected == Gender.fullName ? products.enabledTxt : products.deaible,),
                      hintText: 'ニックネーム',
                      hintStyle: TextStyle(
                        color:  products.selected == Gender.fullName ? products.enabledTxt : products.deaible,
                      ),
                    ),
                    style:  TextStyle(color:  products.selected == Gender.fullName ? products.enabledTxt : products.deaible,fontWeight:FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

              FadeAnimation(
                delay: 2,
                child: Container(
                  width: weight * 0.9,
                  height:height * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: products.selected == Gender.email ?  products.enabled : products.background,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child:  TextField(
                    controller: email,
                    onTap: (){
                      products.emailselect();
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border:InputBorder.none,
                      prefixIcon: Icon(Icons.email_outlined,color: products.selected == Gender.email ? products.enabledTxt : products.deaible,),
                      hintText: 'eメール',
                      hintStyle: TextStyle(
                        color:  products.selected == Gender.email ? products.enabledTxt : products.deaible,
                      ),
                    ),
                    style:  TextStyle(color:  products.selected == Gender.email ? products.enabledTxt : products.deaible,fontWeight:FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              FadeAnimation(
                delay: 2,
                child: Container(
                  width: weight * 0.9,
                  height:height * 0.071,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: products.selected == Gender.password ? products.enabled : products.background
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Obx (() => TextField(
                    controller: pass,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onTap: (){
                      products.passselect();
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border:InputBorder.none,
                        prefixIcon: Icon(Icons.lock_open_outlined,color: products.selected == Gender.password ? products.enabledTxt : products.deaible,),
                        suffixIcon: IconButton(
                            icon: products.password.value ?  Icon(Icons.visibility_off,color: products.selected == Gender.password ? products.enabledTxt : products.deaible,): Icon(Icons.visibility,color: products.selected == Gender.password ? products.enabledTxt : products.deaible,) ,
                            onPressed: () {
                              products.password.value = !products.password.value;
                            }
                        ),
                        hintText: 'パスワード',
                        hintStyle: TextStyle(
                            color: products.selected == Gender.password ? products.enabledTxt : products.deaible
                        )
                    ),
                    obscureText: products.password.value,
                    style:  TextStyle(color: products.selected == Gender.password ? products.enabledTxt : products.deaible,fontWeight:FontWeight.bold),
                  ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              FadeAnimation(
                delay: 2,
                child: Container(
                  width: weight * 0.9,
                  height:height * 0.071,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: products.selected == Gender.confirmpassword ? products.enabled : products.background
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Obx( () => TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onTap: (){
                      products.confpassselect();
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border:InputBorder.none,
                        prefixIcon: Icon(Icons.lock_open_outlined,color: products.selected == Gender.confirmpassword ? products.enabledTxt : products.deaible,),
                        suffixIcon: IconButton(
                            icon: products.confPassword.value ?  Icon(Icons.visibility_off,color: products.selected == Gender.confirmpassword ? products.enabledTxt : products.deaible,): Icon(Icons.visibility,color: products.selected == Gender.confirmpassword ? products.enabledTxt : products.deaible,) ,
                            onPressed: () {
                              products.confPassword.value = !products.confPassword.value;
                            }
                        ),
                        hintText: '確認用パスワード',
                        hintStyle: TextStyle(
                            color: products.selected == Gender.confirmpassword ? products.enabledTxt : products.deaible
                        )
                    ),
                    obscureText: products.confPassword.value ,
                    style:  TextStyle(color: products.selected == Gender.confirmpassword ? products.enabledTxt : products.deaible,fontWeight:FontWeight.bold),
                  ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              FadeAnimation(
                delay: 3,
                child: TextButton(
                    onPressed: (){
                      _RegisterUser();
                    },
                    child: const Text("アカウント登録",style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    style:  TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 80),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                        )
                    )
                ),
              ),
              SizedBox(
                  height: height * 0.09
              ),
              FadeAnimation(
                delay: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("アカウントをお持ちの方 ー＞ ",style: TextStyle(
                      color:   Colors.blueGrey,
                      letterSpacing: 0.5,
                    )),
                    GestureDetector(
                      onTap: (){
                        Get.offNamed("/SignIn");
                      },
                      child: Text("ログイン",style: TextStyle(
                        color:  const Color(0xFF0DF5E4).withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _RegisterUser() {
    firebaseController.createUser(name.text, email.text, pass.text);
  }

}