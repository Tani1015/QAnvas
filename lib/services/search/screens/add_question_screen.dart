import 'package:spring_button/spring_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//クラスインポート
import '../models/tag_model.dart';
import 'package:qanvas/services/search/controller/search_controller.dart';

class AddQuestionScreen extends StatefulWidget{
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  AddQuestionState createState() => AddQuestionState();
}

class AddQuestionState extends State<AddQuestionScreen>{

  final TextEditingController searchController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final tagProvider = Get.put(SearchController());



  String get searchText => searchController.text.trim();

  refresh(VoidCallback fn){
    if(mounted) setState(fn);
  }

  @override
  void initSate(){
    super.initState();
    searchController.addListener(() => refresh(() { }));
  }

  @override
  void dispose(){
    super.dispose();
    searchController.dispose();
  }

  List<TagModel> filterSearchResultList() {
    if(searchText.isEmpty) return tagProvider.tagsToSelect!;

    List<TagModel> _templist = [];
    for(int index =0; index < tagProvider.tagsToSelect!.length; index++){
      TagModel tagModel = tagProvider.tagsToSelect![index];
      if(tagModel.title!.toLowerCase().trim()
          .contains(searchText.toLowerCase())
      ) {
        _templist.add(tagModel);
      }
    }
    return _templist;
  }

  Widget tagChip({
    tagModel,
    onTap,
    action,
  }) {
    return InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  //タグのカラーを変える
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Text(
                  '${tagModel.title}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {

    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textheight = MediaQuery.of(context).viewInsets.bottom;

    //スクロールコントローラー
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child: AppBar(
          title: SizedBox(
            width: weight * 0.4,
            height: height * 0.07,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.only(bottom: textheight * 0.6),
          child: Column(
            children: <Widget>[
              _question(),
              _buttonWidget(),
              _tagIcon()
            ],
          ),
        ),
      )
    );
  }

  Widget _question() {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: weight * 0.02,bottom: height * 0.01),
            child:  const Text("質問",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
        ),
        Container(
          height: height * 0.2,
          width: weight * 0.9,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(7.0),
            ),
            border: Border.all(
              color: Colors.grey.shade500,
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(weight * 0.02),
          child: TextFormField(
            controller: questionController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0)
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0)
                )
              )
            ),
          ),
        ),
        SizedBox(height: height * 0.03),
      ],
    );
  }

  Widget _buttonWidget() {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: height * 0.1,
          width: weight * 0.45,
          child: SpringButton(
            SpringButtonType.WithOpacity,
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: const Center(
                  child: Text(
                    'グラフを作る',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              Get.toNamed('/AddQuestionNote');
            },
          ),
        ),
        SizedBox(
          height: height * 0.1,
          width: weight * 0.45,
          child: SpringButton(
            SpringButtonType.WithOpacity,
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: const Center(
                  child: Text(
                    '投稿する',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              print("投稿する");
            },
          ),
        )
      ],
    );
  }


  Widget _tagIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => _tagsWidget())
      ],
    );
  }

  Widget _tagsWidget() {
    //端末ごとの高さと横幅を取得
    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left:  weight * 0.06, top: height * 0.01),
            child: const Text(
              'タグ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          tagProvider.tagList!.isNotEmpty
              ? Padding(
                padding: EdgeInsets.only(left: weight * 0.03),
                child: Column(

                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: tagProvider.tagList!
                            .map((tagModel) => tagChip(
                          tagModel: tagModel,
                          onTap: () {
                            //remove tag
                            tagProvider.removeTag(tagModel);
                          },
                          action: 'Remove',
                        ))
                            .toSet()
                            .toList(),
                      ),
                    ]),
              )
              : Container(),
          _buildSearchFieldWidget(),
          _displayTagWidget(),
        ],
      ),
    );
  }

  Widget _buildSearchFieldWidget() {

    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        border: Border.all(
          color: Colors.grey.shade500,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration.collapsed(
                hintText: 'タグを検索',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              style: const TextStyle(
                fontSize: 16.0,
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          searchText.isNotEmpty
              ? InkWell(
                child: Icon(
                  Icons.clear,
                  color: Colors.grey.shade700,
                ),
                onTap: () => searchController.clear(),
              )
              : Icon(
                  Icons.search,
                  color: Colors.grey.shade700,
               ),
          Container(),
        ],
      ),
    );
  }

  _displayTagWidget() {
    //端末ごとの高さと横幅を取得
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: filterSearchResultList().isNotEmpty
          ? _buildSuggestionWidget()
          : ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height * 0.9
              ),
            child: const Text("タグが見つかりません")
            )
          );
  }

  Widget _buildSuggestionWidget() {
    //端末ごとの高さと横幅を取得
    final height = MediaQuery.of(context).size.height;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          if (filterSearchResultList().length != tagProvider.tagList!.length)
            const Text('タグを追加すると答えられやすくなります',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),
            ),
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height * 0.8
              ),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: filterSearchResultList()
                  .where((tagModel) => !tagProvider.tagList!.contains(tagModel))
                  .map((tagModel) => tagChip(
                tagModel: tagModel,
                onTap: () => tagProvider.addTag(tagModel),
                action: 'Add',
              ))
                  .toList(),
            ),
          )
        ]);

  }

}