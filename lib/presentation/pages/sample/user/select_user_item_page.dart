import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/entities/sample/comment/comment.dart';
import 'package:qanvas/model/entities/sample/item/item.dart';
import 'package:qanvas/model/use_cases/sample/item_controller.dart';
import 'package:qanvas/model/use_cases/sample/search_item_controller.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/widgets/rounded_button.dart';
import 'package:qanvas/presentation/widgets/thumbnail.dart';


class SelectUserItemPage extends HookConsumerWidget{
  const SelectUserItemPage (this.data, {Key? key}) : super(key: key);

  final Item data;

  static Future<void> show(BuildContext context, Item data) {
    return Navigator.of(context,rootNavigator: true).push<void>(
      MaterialPageRoute(
        builder: (_) => SelectUserItemPage (data),
      ),
    );
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final newCommentList = useState<List<Comment>>([]);

    useEffectOnce(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(data.comment != null) {
          newCommentList.value = data.comment!;
        }
      });
      return null;
    });

    return Scaffold(
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
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
              children: [
                data.imageUrl?.url == null
                    ? const SizedBox()
                    : Container(
                  margin: const EdgeInsets.all(15),
                  height: context.height * 0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200)
                  ),
                  child: Thumbnail(
                    height: context.height * 0.4,
                    width: context.width * 0.8,
                    url: data.imageUrl?.url,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(data.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40).copyWith(top: 5).copyWith(bottom: 10),
                      child: Text(data.question!),
                    )
                  ],
                ),
                const Divider(height: 1),
                data.comment != null
                    ? ValueListenableBuilder(
                    valueListenable: newCommentList,
                    builder: (context,List<Comment> newCommentListValue,_){
                      if(newCommentListValue == null){
                        return const SizedBox();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child:Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(newCommentListValue[index].comment!),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: newCommentListValue.length,
                      );
                    }
                ) : const SizedBox(),
              ]
          )
      ),
    );
  }

}