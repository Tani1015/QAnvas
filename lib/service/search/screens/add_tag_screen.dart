import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

class FilterPage extends HookConsumerWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    List<User>? selectedUserList =[
    ];

    final weight = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textheight = MediaQuery.of(context).viewInsets.bottom;

    List<User> userList = [
      User(name: "Jon", avatar: ""),
      User(name: "Ethel ", avatar: ""),
      User(name: "Elyse ", avatar: ""),
      User(name: "Nail  ", avatar: ""),
      User(name: "Valarie ", avatar: ""),
      User(name: "Lindsey ", avatar: ""),
      User(name: "Emelyan ", avatar: ""),
      User(name: "Carolina ", avatar: ""),
      User(name: "Catherine ", avatar: ""),
      User(name: "Stepanida  ", avatar: ""),
    ];

    List<User> userList2 = [
      User(name: "Jon", avatar: ""),
      User(name: "Ethel ", avatar: ""),
      User(name: "Elyse ", avatar: ""),
      User(name: "Nail  ", avatar: ""),
      User(name: "Valarie ", avatar: ""),
      User(name: "Lindsey ", avatar: ""),
      User(name: "Emelyan ", avatar: ""),
      User(name: "Carolina ", avatar: ""),
      User(name: "Catherine ", avatar: ""),
      User(name: "  ", avatar: ""),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child: AppBar(
          title: SizedBox(
            width: weight * 0.6,
            height: height * 0.09,
            child: Image.asset("assets/images/QAnvas_title.png"),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: textheight),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: weight,
                height: height * 0.37,
              ),
              SizedBox(
                width: weight ,
                height:  height * 0.5,
                child: FilterListWidget<User>(
                  listData: userList2,
                  //選んだタグ
                  selectedListData: selectedUserList,
                  //apply処理
                  onApplyButtonClick: (list) {
                    // do something with list ..
                    selectedUserList = list;
                  },
                  //itemがlistData
                  choiceChipLabel: (item) {
                    return item!.name;
                  },
                  validateSelectedItem: (list, val) {
                    return list!.contains(val);
                  },
                  onItemSearch: (user, query) {
                    return user.name!.toLowerCase().contains(query.toLowerCase());
                  },
                  selectedItemsText: "個",
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     print(selectedUserList);
      //   },
      // ),
    );
  }
}