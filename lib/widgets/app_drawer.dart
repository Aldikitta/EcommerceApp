import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff3C5570),
              Color(0xff182331),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0, 1],
          ),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Hello Friend!'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.shop,
                size: 26,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                'Shop',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.payment,
                size: 26,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                'Orders',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     CustomRoute(builder: (ctx) => OrdersScreen(),),);
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.edit,
                size: 26,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                'Manage Products',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 26,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                // Navigator.of(context)
                //     .pushReplacementNamed(UserProductsScreen.routeName);
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
