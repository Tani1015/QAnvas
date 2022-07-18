import 'package:flutter/material.dart';
import 'package:qanvas/presentation/pages/sample/sample_chat/chat_page.dart';
import 'package:qanvas/presentation/pages/sample/sample_chat/room_question.dart';
import 'package:qanvas/extensions/context_extension.dart';

class Roominfo extends StatefulWidget {
  const Roominfo({Key? key, required this.chatRoom}) : super(key: key);

  final String chatRoom;
  @override
  RoomState createState() => RoomState();
}

class RoomState extends State<Roominfo> with TickerProviderStateMixin{

  TabController? _tabController;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    setState(() {
      _tabController?.addListener(handleTabChange);
    });
    super.didChangeDependencies();
  }

  handleTabChange(){
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context ) {
    final _kTabPages = <Widget>[
      ChatScreen(widget.chatRoom),
      const AppBarSearchExample()
    ];
    final _kTabs = <Tab>[
      const Tab(text: 'チャット'),
      const Tab(text: '質問'),
    ];

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: DefaultTabController(
          length: _kTabs.length,
          child: Scaffold(

              appBar:  AppBar(
                title: SizedBox(
                  width: context.width * 0.4,
                  height: context.height * 0.07,
                  child: Image.asset("assets/images/QAnvas_title.png"),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  tabs: _kTabs,
                  labelColor: Colors.black,
                  controller: _tabController,
                ),
              ),
            body: TabBarView(
              controller: _tabController,
              children: _kTabPages,
            ),
          ),
        ),
      ),
    );
  }
}