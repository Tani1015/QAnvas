import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/extensions/context_extension.dart';
import 'package:qanvas/model/use_cases/sample/search_item_controller.dart';
import 'package:qanvas/presentation/pages/sample/search/make_question_page.dart';
import 'package:qanvas/presentation/pages/sample/search/search_result_page.dart';

class SearchScreen extends HookConsumerWidget{
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final searchTextController = ref.watch(searchTextEditingController);

    final iconlist = [
      "assets/images/kokugo.png",
      "assets/images/eigo.png",
      "assets/images/sugaku.png",
      "assets/images/rekisi.png",
      "assets/images/keizai.png",
      "assets/images/buturi.png",
      "assets/images/kagaku.png",
    ];

    final categorylist = [
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
          preferredSize: Size.fromHeight(context.height * 0.08),
          child:  AppBar(
            title: SizedBox(
              width: context.width * 0.4,
              height: context.height * 0.07,
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
                    width: context.width * 0.95,
                    height:  context.height * 0.07,
                    color: Colors.white,
                    margin: EdgeInsets.all(context.width * 0.05),
                    child: TextFormField(
                      autofocus: false,
                      controller: searchTextController,
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
                      onFieldSubmitted: (submitted) {
                        SearchResultPage.show(context);
                      },
                    ),
                  ),
                  SizedBox(height: context.height * 0.03),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: context.width * 0.02, top: context.height * 0.01,bottom: context.height * 0.005),
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
                          height: context.height * 0.005,
                          indent: context.width * 0.17,
                          endIndent: context.width * 0.1,
                          thickness: 1,
                        );
                      },
                      itemCount: iconlist.length
                  ),
                ]
            ),
          ),
        ),
        floatingActionButton:FloatingActionButton.extended(
            onPressed: () {
              MakeQuestionPage.show(context);
            },
            heroTag: "search",
            label:  const Text("質問する"),
            backgroundColor: Colors.red,
          ),
    );
  }
}