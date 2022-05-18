import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

//クラスインポート


final searchstateprovider = StateProvider.autoDispose((ref){
  return TextEditingController(text: "");
});

class SearchScreen extends HookConsumerWidget{
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final searchController = ref.watch(searchstateprovider);

    final iconlist = [
      "assets/images/sibouko.png",
      "assets/images/kokugo.png",
      "assets/images/eigo.png",
      "assets/images/sugaku.png",
      "assets/images/rekisi.png",
      "assets/images/keizai.png",
      "assets/images/buturi.png",
      "assets/images/kagaku.png",
    ];

    final categorylist = [
      "志望校",
      "国語",
      "英語",
      "数学",
      "歴史",
      "経済",
      "物理",
      "科学",
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child:  AppBar(
          title: SizedBox(
            width: weight * 0.4,
            height: height * 0.07,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: GestureDetector(
        onTap: (){
          final FocusScopeNode currentfocus = FocusScope.of(context);
          if(!currentfocus.hasPrimaryFocus && currentfocus.hasFocus){
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //サーチテキストフィールド
              Container(
                width: weight * 0.95,
                height:  height * 0.07,
                color: Colors.white,
                margin: EdgeInsets.all(weight * 0.05),
                child: TextFormField(
                  autofocus: false,
                  controller: searchController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '質問、ノートを検索',
                    hintStyle: const TextStyle(fontSize: 17, color: Colors.black26),
                    fillColor: Colors.grey[400],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.red
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: weight * 0.02, top: height * 0.01,bottom: height * 0.005),
                child:  const Text("カテゴリー",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(iconlist[index]),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(categorylist[index],
                        style: const TextStyle(
                            fontSize: 20,
                        ),
                      ),
                      onTap: (){
                        print( categorylist[index]);
                        },
                    );
                  },
                  separatorBuilder: (context, index){
                    return Divider(
                      height: height * 0.005,
                      indent: weight * 0.17,
                      endIndent: weight * 0.1,
                      thickness: 1,
                    );
                  },
                  itemCount: iconlist.length
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GoRouter.of(context).go('/AddQuestion');
        },
        label:  const Text("質問する"),
        backgroundColor: Colors.red,
      ),
    );
  }
}