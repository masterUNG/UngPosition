import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungposition/models/user_model.dart';
import 'package:ungposition/utility/my_constant.dart';
import 'package:ungposition/widget/show_progress.dart';
import 'package:ungposition/widget/title_h1.dart';

class ListFriend extends StatefulWidget {
  @override
  _ListFriendState createState() => _ListFriendState();
}

class _ListFriendState extends State<ListFriend> {
  List<UserModel> userModels = [];
  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllUser();
  }

  Future<Null> readAllUser() async {
    String path = '${MyConstant().domain}/ungposition/getAllData.php';
    await Dio().get(path).then((value) {
      setState(() {
        load = false;
      });
      for (var item in json.decode(value.data)) {
        UserModel model = UserModel.fromMap(item);
        setState(() {
          userModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/updateLocation'),
        child: Text('Update'),
      ),
      body: load
          ? ShowProgress()
          : ListView.builder(
              itemCount: userModels.length,
              itemBuilder: (context, index) => Card(
                color:
                    index % 2 == 0 ? Colors.grey.shade200 : MyConstant().light,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleH1(userModels[index].name),
                      Text('Gender = ${userModels[index].gender}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Lat = ${userModels[index].lat}'),
                          Text('Lng = ${userModels[index].lng}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
