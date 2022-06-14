import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firevase_practice/utils/authentication.dart';
import 'package:flutter_firevase_practice/utils/firestore/users.dart';
import 'package:flutter_firevase_practice/utils/function_utils.dart';

import '../../model/account.dart';
import '../../utils/widget_utils.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  Account? myAccount = Authentication.myAccount!;
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  File? image;

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage('${myAccount?.imagePath}');
    } else {
      return FileImage(image!);
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount?.name);
    userIdController = TextEditingController(text: myAccount?.userId);
    selfIntroductionController =
        TextEditingController(text: myAccount?.selfIntroduction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('プロフィール編集'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await FunctionUtils.getImageFromGallery();
                  if (result != null) {
                    setState(() {
                      image = File(result.path);
                    });
                  }
                },
                child: CircleAvatar(
                  foregroundImage: getImage(),
                  radius: 40,
                  child: Icon(Icons.add),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: '名前',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      hintText: 'ユーザーID',
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: selfIntroductionController,
                  decoration: InputDecoration(
                    hintText: '自己紹介',
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        userIdController.text.isNotEmpty &&
                        selfIntroductionController.text.isNotEmpty) {
                      String? imagePath = '';
                      if (image == null) {
                        imagePath = myAccount!.imagePath;
                      } else {
                        var result = await FunctionUtils.uploadImage(
                            myAccount!.id, image!);
                        imagePath = result;
                      }
                      Account updateAccount = Account(
                        id: myAccount!.id,
                        name: nameController.text,
                        userId: userIdController.text,
                        selfIntroduction: selfIntroductionController.text,
                        imagePath: imagePath,
                      );
                      Authentication.myAccount = updateAccount;
                      var result =
                          await UserFirestore.updateUser(updateAccount);
                      if (result != null) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
                  child: Text('更新'))
            ],
          ),
        ),
      ),
    );
  }
}