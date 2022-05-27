import 'package:flutter/material.dart';
import 'package:capex_mobile/router.dart';
import 'package:capex_mobile/providers/ProfileAuthentication.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({this.onSignedOut, this.email, this.uid, this.fullname});
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      ProfileAuth authProvider =
          Provider.of<ProfileAuth>(context, listen: false);

      authProvider.signOut();
      _logout(context);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _buildLogoutDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  _signOut(context)
                      .then((result) => Navigator.pushReplacementNamed(
                          context, "/login-page"))
                      .catchError((err) => print(err));
                }),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        );
      },
      context: context,
    );
  }

  String fullname;
  String email;
  String uid;

  void _logout(context) {
    Navigator.of(context).pushNamed("login-page");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    final List _drawerMenu = [
      {
        "icon": Icons.history,
        "text": "Transaction",
        "route": MyRidesRoute,
      },
      {
        "icon": Icons.local_activity,
        "text": "Promotions",
        "route": PromotionRoute
      },
      {
        "icon": Icons.star_border,
        "text": "My favourites",
        "route": FavoritesRoute
      },
      {
        "icon": Icons.credit_card,
        "text": "My payments",
        "route": PaymentRoute,
      },
      /*{
        "icon": Icons.notifications,
        "text": "Notification",
        
      },*/
      {
        "icon": Icons.chat,
        "text": "Support",
        "route": ChatRiderRoute,
      },
      {
        "icon": Icons.exit_to_app,
        "text": "Logout",
        /*"route": LoginPage,*/
        "action": 'logout',
      }
    ];

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width * 0.2),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              height: 170.0,
              color: _theme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/537-5372558_flat-man-icon-png-transparent-png.png"),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        this.fullname ?? "fullname",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ProfileRoute);
                        },
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "+639178811708",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 15.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: ListView(
                  children: _drawerMenu.map((menu) {
                    return GestureDetector(
                      onTap: () {
                        if (menu["action"] == "logout") {
                          _buildLogoutDialog(context, "");
                        }
                        if (menu["route"] != "") {
                          Navigator.of(context).pushNamed(menu["route"]);
                        }
                      },
                      child: ListTile(
                        leading: Icon(menu["icon"]),
                        title: Text(
                          menu["text"],
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
