import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:dog_path_app/providers/dog_path_provider.dart';

class ImageTextWidget extends StatefulWidget {
  /// getting index from HomeScreenWidget from the parent Listview Builder
  ImageTextWidget({this.index});
  final int index;

  @override
  _ImageTextWidgetState createState() => _ImageTextWidgetState();
}

class _ImageTextWidgetState extends State<ImageTextWidget> {
  ScrollController _scrollImageController;
  ScrollController _scrollTextController;
  int _indexFromImage = 0;
  int _itemCount = 0;
  int _imageIndex = 0;
  int _selectedIndex = 0;
  int previousImageSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollImageController = ScrollController();
    _scrollTextController = ScrollController();

    _scrollImageController.addListener(
        () => _scrollListenerWithItemCount(_itemCount, _indexFromImage));
    _scrollTextController.addListener(
        () => _scrollListenerWithItemCount(_itemCount, _indexFromImage));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollImageController.removeListener(
        () => _scrollListenerWithItemCount(_itemCount, _indexFromImage));
    _scrollImageController.dispose();

    _scrollTextController.removeListener(
        () => _scrollListenerWithItemCount(_itemCount, _indexFromImage));
    _scrollTextController.dispose();
  }

  void _scrollListenerWithItemCount(int items, int ind) {
    final width = MediaQuery.of(context).size.width;

    //

    //
    int itemCount = items;
    double scrollOffset = _scrollImageController.position.pixels;
    double viewportHeight = _scrollImageController.position.viewportDimension;
    double scrollRange = _scrollImageController.position.maxScrollExtent -
        _scrollImageController.position.minScrollExtent;

    previousImageSelectedIndex = _selectedIndex;

    _selectedIndex =
        (scrollOffset / (scrollRange + viewportHeight) * itemCount).floor();

    if (previousImageSelectedIndex < _selectedIndex) {
      setState(() {
        print(
            "selected index : $_selectedIndex , previous: $previousImageSelectedIndex, FORWARD ANIMATION");
        // _animateForward(previousImageSelectedIndex, width, _selectedIndex);
      });
    } else if (previousImageSelectedIndex > _selectedIndex) {
      setState(() {
        print(
            "selected index : $_selectedIndex , previous: $previousImageSelectedIndex, BACKWARD ANIMATION");
            // _animateBackward(previousImageSelectedIndex, width, _selectedIndex);
      });
    }
  }

  void _animateForward(int currentIndex, double width, int selectedIndex) {
    _scrollImageController.animateTo(
      currentIndex == 0 ? width : width * currentIndex,
      duration: Duration(milliseconds: 1500),
      curve: Curves.fastOutSlowIn,
    );

    num currentOffset = _scrollTextController.offset;
    num indexDiff = currentIndex - selectedIndex;
    if (indexDiff < 2) {
      print(currentIndex - selectedIndex);
      currentOffset += width / 2 * (currentIndex - selectedIndex);
      // print("orginal offset: ${_scrollTextController.offset}");
      // print("current offsets: $currentOffset");
    } else if (indexDiff > 2 && indexDiff < 4) {
      print(currentIndex - selectedIndex);
      currentOffset += (width / 4) * indexDiff;
    } else {
      print(currentIndex - selectedIndex);

      currentOffset = currentOffset + width / 2;
    }

    _scrollTextController.animateTo(
      currentOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.linear,
    );
  }

  void _animateBackward(int currentIndex, double width, int selectedIndex) {
    _scrollImageController.animateTo(
      currentIndex == 0 ? width * currentIndex : width,
      duration: Duration(milliseconds: 1500),
      curve: Curves.fastOutSlowIn,
    );

    _scrollTextController.animateTo(
      currentIndex == 0 ? width * .30 : 0.0,
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * .40;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          _buildImage(height, width),
          _buildText(height, width),
        ],
      ),
    );
  }

  ///Returns the [paths] in [Text] using [Listview]
  ///inside a [Container]
  ///

  Widget _buildText(double height, double width) {
    final dogP = Provider.of<DogPathProvider>(context, listen: false).dogPath;
    final subP = dogP[widget.index].subpaths;

    return Container(
      height: height * .20,
      width: width,
      padding: EdgeInsets.only(left: 20),
      color: Colors.black,
      child: ListView.builder(
        controller: _scrollTextController,
        scrollDirection: Axis.horizontal,
        itemCount: dogP[widget.index].subpaths.length,
        itemBuilder: (ctx, ind) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    // _textIndex = ind;                         //CHEKING WHY
                    // print("index is: $ind & SelectedIndex is: $_selectedIndex");

                    if (ind > _selectedIndex) {
                      _animateForward(ind, width, _selectedIndex);
                      _selectedIndex = ind;

                      print("ANIMATED FORWARD");

                      //
                      // _textIndex = _selectedIndex;
                      // print(
                      // "index is: $ind & SelectedIndex is: $_selectedIndex");
                    } else if (ind < _selectedIndex) {
                      _animateBackward(ind, width, _selectedIndex);
                      _selectedIndex = ind;
                      print("ANIMATED BACKWARD");

                      // print(
                      // "index is: $ind & SelectedIndex is: $_selectedIndex");
                    }
                  });
                },
                child: Text(
                  subP[ind].subTitle,
                  style: TextStyle(
                    color: _selectedIndex == ind
                        ? Colors.white
                        : Color(0xff778fab),
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Opacity(
                opacity: (ind == subP.length - 1) ? 0.0 : 1.0,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ///Returns the [Images] using [Listview] dynamically
  ///inside a [Container]
  ///uses a ScrollController, which controlls how the list will animate & the cur

  Widget _buildImage(double height, double width) {
    //TESTNG_________
    //
    const fakeUrl =
        "https://www.sftravel.com/sites/sftraveldev.prod.acquia-sites.com/files/SanFrancisco_0.jpg";
    const url =
        "https://cdn.pixabay.com/photo/2014/07/10/10/20/golden-gate-bridge-388917_960_720.jpg";
    //
    final dogP = Provider.of<DogPathProvider>(context, listen: false).dogPath;
    final subP = dogP[widget.index].subpaths;
    _itemCount = subP.length;
    return Container(
      height: height * .75,
      width: width,
      child: ListView.builder(
        controller: _scrollImageController,
        scrollDirection: Axis.horizontal,
        itemCount: subP.length,
        itemBuilder: (ctx, ind) {
          _indexFromImage = ind;
          return Image(
            image: subP[ind].imageUrl == fakeUrl
                ? NetworkImage(url)
                : NetworkImage(
                    subP[ind].imageUrl,
                  ),
            fit: BoxFit.fill,
            width: width,
          );
        },
      ),
    );
  }
}
