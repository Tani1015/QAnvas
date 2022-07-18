import 'package:flutter/material.dart';
import 'package:qanvas/extensions/context_extension.dart';

class AppBarSearchExample extends StatefulWidget {
  const AppBarSearchExample({Key? key}) : super(key: key);

  @override
  _AppBarSearchExampleState createState() => _AppBarSearchExampleState();
}

class _AppBarSearchExampleState extends State<AppBarSearchExample> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: Colors.grey.shade200,
                    width: context.width * 0.8,
                    height: context.height * 0.2,
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:  const [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("#1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                        const Text("質問を入力できます"),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: '答えを入力してください',
                            labelStyle: TextStyle(
                              fontSize: 12,
                            )
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: Colors.grey.shade200,
                    width: context.width * 0.8,
                    height: context.height * 0.2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  const [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("#2",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text("40 ×　100 = ?"),
                        const Divider(),
                        const Text("4000です"),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: '答えを入力してください',
                              labelStyle: TextStyle(
                                fontSize: 12,
                              )
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: Colors.grey.shade200,
                    width: context.width * 0.8,
                    height: context.height * 0.3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  const [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("#3",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text("1192年にできた幕府は？"),
                        const Divider(),
                        const Text("鎌倉幕府です。源の頼朝が征夷大将軍に任命され、鎌倉幕府が成立しました"),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: '答えを入力してください',
                              labelStyle: TextStyle(
                                fontSize: 12,
                              )
                          ),
                          keyboardType: TextInputType.multiline,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


