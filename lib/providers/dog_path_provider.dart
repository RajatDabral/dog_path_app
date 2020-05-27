import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dog_path_app/model/dog_path.dart';

class DogPathProvider with ChangeNotifier {
  List<DogPath> _dogPath = [];

  List<DogPath> get dogPath {
    return [..._dogPath];
  }

  Future<void> getPath() async {
    const url = "[api_path_here]";
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      data.forEach(
        (dMap) {
          if (int.parse(dMap['id']) < 15) {
            //API has different keys & values for 15th id.
            List<SubPaths> subPList = [];
            dMap['sub_paths'].forEach(
              (sMap) {
                subPList.add(
                  SubPaths(
                    subId: sMap['id'],
                    subTitle: sMap['title'],
                    imageUrl: sMap['image'],
                  ),
                );
              },
            );
            _dogPath.add(
              DogPath(
                id: dMap['id'],
                title: dMap['title'],
                subpaths: subPList,
              ),
            );
          } else
            return;
        },
      );
    } on SocketException {
      print('No internet');
      // throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
