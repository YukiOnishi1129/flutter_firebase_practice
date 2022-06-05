import 'package:flutter/material.dart';

import '../../model/account.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  //インスタンス作成
  Account myAccount = Account(
    id: '1',
    name: 'Flutterラボ',
    selfIntroduction: 'こんばんは',
    userId: 'flutter_labo',
    imagePath:
        'https://yt3.ggpht.com/ngVd2-zv5o3pGUCfiVdZXCHhnq_g1Lo1Y8DbrmB9O8G7DG0IWUQJgsacqsI_LRvZE8JTsbQIuQ=s900-c-k-c0x00ffffff-no-rj',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('タイムライン'),
      ),
    );
  }
}
