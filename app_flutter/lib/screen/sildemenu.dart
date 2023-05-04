// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  
class SideMenu extends StatelessWidget {
 
    const SideMenu({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
        return Drawer(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    UserAccountsDrawerHeader(
                        accountName: Text('AccountName'),
                        accountEmail: Text('email@example.com'),
                        currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.ninenik.com/images/ninenik_page_logo.jpg"
                            ),
                            backgroundColor: Colors.white,
                        ),
                    ),
                    ListTile(
                        leading: Icon(FontAwesomeIcons.home),
                        title: Text('Home'),
                        onTap: () {
                                            
                        },
                    ),                    
                    ListTile(
                        leading: Icon(FontAwesomeIcons.info),
                        title: Text('About Us'),
                        onTap: () {
                         
                        },
                    ),
                    ListTile(
                        leading: Icon(FontAwesomeIcons.user),
                        title: Text('Profile'),
                      
                       
                    ),
                    ListTile(
                        leading: Icon(FontAwesomeIcons.addressCard),
                        title: Text('Contact Us'),
                       
                    ),
                    Divider(),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ListTile(
                                leading: Icon(FontAwesomeIcons.cog),
                                title: Text('Settings'),
                              
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}