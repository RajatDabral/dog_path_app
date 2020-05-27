import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dog_path_app/services/auth.dart';
import 'package:dog_path_app/widgets/home_screen_widget.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _logOut(BuildContext context) async {
    final authProvider = Provider.of<AuthBase>(context, listen: false);
    authProvider.updateLoggedState(false);
    await authProvider.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff393939),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff393939),
        title: Text(
          'Dog\'s Path',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logOut(context),
          ),
        ],
      ),
      body: HomeScreenWidget(),
    );
  }
}

// child: GridView.builder(
//     scrollDirection: Axis.horizontal,
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 1,
//     ),
//     itemCount: dogP[index].subpaths.length,
//     itemBuilder: (ctx, ind) {
//       return GridTile(
//         child: Image.network(
//           dogP[index].subpaths[ind].imageUrl,
//           fit: BoxFit.fill,
//         ),
//       );
//     }),
