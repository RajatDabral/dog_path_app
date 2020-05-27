// _loginWithFB() async {
//     final loginResult = await facebookLogin.logInWithReadPermissions(['email']);

//     switch (loginResult.status) {
//       case FacebookLoginStatus.loggedIn:
//         final accessToken = loginResult.accessToken;
//         final userId = accessToken.userId;
//         print(userId);
//         final graphResponse = await http.get(
//             "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$accessToken");
//         final profile = json.decode(graphResponse.body);
//         print(profile);
//         setState(() {
//           userProfile = profile;
//           _isLoggedIn = true;
//         });
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         setState(() => _isLoggedIn = false);
//         break;

//       case FacebookLoginStatus.error:
//         setState(() => _isLoggedIn = false);
//     }
//   }

//   Future<void> _logOut() async {}







///-------Image Text widget ------
///

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:dog_path_app/providers/dog_path_provider.dart';

// class ImageTextWidget extends StatefulWidget {
//   /// getting index from HomeScreenWidget from the parent Listview Builder
//   ImageTextWidget({this.index});
//   final int index;

//   @override
//   _ImageTextWidgetState createState() => _ImageTextWidgetState();
// }

// class _ImageTextWidgetState extends State<ImageTextWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height * .40;
//     final width = MediaQuery.of(context).size.width;

//     return Container(
//       height: height,
//       width: width,
//       child: Column(
//         children: [
//           _buildImage(height, width),
//           _buildText(height, width),
//         ],
//       ),
//     );
//   }

//   Widget _buildImage(double height, double width) {
//     final dogP = Provider.of<DogPathProvider>(context, listen: false).dogPath;
//     final subP = dogP[widget.index].subpaths;

//     return Container(
//       height: height * .75,
//       width: width,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: dogP[widget.index].subpaths.length,
//         itemBuilder: (ctx, ind) => Image(
//           image: NetworkImage(subP[ind].imageUrl),
//           fit: BoxFit.fill,
//           width: width,
//         ),
//       ),
//     );
//   }

//   Widget _buildText(double height, double width) {
//     final dogP = Provider.of<DogPathProvider>(context, listen: false).dogPath;
//     final subP = dogP[widget.index].subpaths;

//     return Container(
//       height: height * .20,
//       width: width,
//       color: Colors.black,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: dogP[widget.index].subpaths.length,
//         itemBuilder: (ctx, ind) {
//           return Padding(
//             padding: const EdgeInsets.only(left: 15.0),
//             child: Row(
//               children: [
//                 Text(
//                   subP[ind].subTitle,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Icon(
//                   Icons.arrow_forward,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
