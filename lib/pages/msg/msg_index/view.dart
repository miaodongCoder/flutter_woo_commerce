import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MsgIndexPage extends StatefulWidget {
  const MsgIndexPage({Key? key}) : super(key: key);

  @override
  State<MsgIndexPage> createState() => _MsgIndexPageState();
}

class _MsgIndexPageState extends State<MsgIndexPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MsgIndexViewGetX();
  }
}

class _MsgIndexViewGetX extends GetView<MsgIndexController> {
  const _MsgIndexViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("MsgIndexPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MsgIndexController>(
      init: MsgIndexController(),
      id: "msg_index",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("msg_index")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
