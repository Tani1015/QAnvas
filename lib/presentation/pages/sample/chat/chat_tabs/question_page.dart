import 'package:flutter/material.dart';
import 'package:qanvas/extensions/context_extension.dart';
import 'package:qanvas/gen/assets.gen.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,

        title: SizedBox(
          height: context.height * 0.1,
          width: context.width * 0.3,
          child: Assets.images.qAnvasTitle.image(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            splashColor: Colors.white,
            highlightColor: Colors.white,
          ),
        ],
      ),
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
                        const Text("???????????????????????????"),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: '?????????????????????????????????',
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
                        const Text("40 ?????100 = ?"),
                        const Divider(),
                        const Text("4000??????"),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: '?????????????????????????????????',
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
                        const Text("1192???????????????????????????"),
                        const Divider(),
                        const Text("??????????????????????????????????????????????????????????????????????????????????????????????????????"),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: '?????????????????????????????????',
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


