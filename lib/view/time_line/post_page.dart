import 'package:flutter/material.dart';
import 'package:flutter_firevase_practice/utils/authentication.dart';
import 'package:flutter_firevase_practice/utils/firestore/posts.dart';

import '../../model/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '新規投稿',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: contentController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (contentController.text.isNotEmpty) {
                      Post newPost = Post(
                        content: contentController.text,
                        postAccountId: Authentication.myAccount!.id,
                      );
                      var result = await PostFirestore.addPosts(newPost);
                      if (result == true) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('投稿'))
            ],
          ),
        ));
  }
}
