import 'package:flutter/foundation.dart';

class DogPath {
  DogPath({
    @required this.id,
    @required this.title,
    this.subpaths,
  });
  final String id;
  final String title;
  final List<SubPaths> subpaths;
}

class SubPaths {
  SubPaths({
    this.subId,
    this.subTitle,
    this.imageUrl,
  });
  final String subId;
  final String subTitle;
  final String imageUrl;
}
