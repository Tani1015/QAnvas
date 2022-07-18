import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/use_cases/sample/item_controller.dart';
import 'package:qanvas/presentation/widgets/thumbnail.dart';


class SearchResultPage extends HookConsumerWidget{
  const SearchResultPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      MaterialPageRoute(
        builder: (_) => const SearchResultPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextController = ref.watch(searchTextEditingController);
    final items = ref.watch(itemProvider);
    final scrollController = useScrollController();

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
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8).copyWith(top: 8),
                child:Text(searchTextController.text,
                  textAlign: TextAlign.start,
                  style:  const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const Divider(height:  0.5),
            ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final data = items[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            data.imageUrl?.url == null
                                ? const SizedBox()
                                : Container(
                              margin: const EdgeInsets.all(15),
                              height: context.height * 0.40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)
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
                            data.comment == null
                                ? const SizedBox()
                                : Text(data.comment![0].comment!)
                          ],
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      )
                    ),
                    onTap: () {
                      //画面遷移　selectSelectNotePage.show(context, index);
                      //
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height:  0.5);
                },
                itemCount: items.length
            )
          ],
        ),
      ),
    );
  }

}