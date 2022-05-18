import 'package:flutter/material.dart';

class MovieBrowserModel extends ChangeNotifier {
  Drawer myDrawer({required BuildContext context}) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('flutter_inappbrowser example'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('InAppBrowser'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/InAppBrowser');
            },
          ),
          ListTile(
            title: Text('ChromeSafariBrowser'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ChromeSafariBrowser');
            },
          ),
          ListTile(
            title: Text('InAppWebView'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('HeadlessInAppWebView'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/HeadlessInAppWebView');
            },
          ),
        ],
      ),
    );
  }
}