import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dog_path_app/widgets/image_text_widget.dart';
import 'package:dog_path_app/providers/dog_path_provider.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  int selectedTile;
  Widget build(BuildContext context) {
    final dogP = Provider.of<DogPathProvider>(context).dogPath;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListView.builder(
          itemCount: dogP.length,
          itemBuilder: (ctx, index) {
            return Column(
              key: Key(dogP[index].id),
              children: [
                ..._topHead(ctx, index),
                ImageTextWidget(
                  index: index,
                ),
                // imageText(ctx, index),
              ],
            );
          }),
    );
  }

  List<Widget> _topHead(BuildContext ctx, int index) {
    final pathP = Provider.of<DogPathProvider>(ctx);
    final dogP = pathP.dogPath[index];
    return [
      Container(
        margin: EdgeInsets.only(
          left: 12.0,
          right: 2.0,
          bottom: 2.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dogP.title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 4.0),
                Text(
                  "${dogP.subpaths.length} Sub Paths",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
            Container(
              child: FlatButton(
                child: Text('Open Path'),
                textColor: Color(0xff778fab),
                color: Colors.black,
                onPressed: () {},
              ),
            )
          ],
        ),
      )
    ];
  }

  ///TESTING THIS
  ///
  // Widget imageText(BuildContext context, int index) {
  //   final height = MediaQuery.of(context).size.height * .40;
  //   final width = MediaQuery.of(context).size.width;

  //   final dogP = Provider.of<DogPathProvider>(context).dogPath;
  //   final subP = dogP[index].subpaths;

  //   return Container(
  //     height: height,
  //     width: width,
  //     child: AnimatedList(
  //       scrollDirection: Axis.horizontal,
  //       initialItemCount: subP.length,
  //       itemBuilder: (ctx, ind, animate) => Column(

  //         children: [
  //           Container(
  //             height: height * .75,
  //             width: width,
  //             color: Colors.red,
  //             child: Image(
  //               image: NetworkImage(subP[ind].imageUrl),
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //           Container(
  //             height: height * .25,
  //             width: width,
  //             color: Colors.black,
  //             child: Text(
  //               subP[ind].subTitle,
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
