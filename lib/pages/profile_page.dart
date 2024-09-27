// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:nexplay/authentication/login_page.dart';
import 'package:nexplay/controller/library_controller.dart';
import 'package:nexplay/pages/terms_conditions.dart';
import 'package:nexplay/util/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LibraryController _libraryController = Get.find();
  Language _selectedLanguage = Languages.english;
  String _statusText = 'Online';
  Color _statusColor = Colors.green;
  IconData _statusIcon = Icons.circle;
  bool _switchNotifications = false;
  bool _switchMarketing = false;

  void _updateStatus(String status, Color color, IconData icon) {
    setState(() {
      _statusText = status;
      _statusColor = color;
      _statusIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('My Profile', style: TextStyle(color: foregroundColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.wb_sunny, color: foregroundColor),
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: foregroundColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: backgroundColor,
                    elevation: 20,
                    title: Center(child: Text('Signing Out...', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold))),
                    titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  );
                },
              );
              _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://img.redbull.com/images/c_crop,x_510,y_0,h_1234,w_926/c_fill,w_450,h_600/q_auto:low,f_auto/redbullcom/2020/9/16/qsavzzs1hulerklkkzzp/ac-header'), // Placeholder image, replace with actual image
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Samama007',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: foregroundColor),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'LEVEL 15',
                    style: TextStyle(fontSize: 16, color: foregroundColor),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(foregroundColor), foregroundColor: WidgetStatePropertyAll(backgroundColor)),
                    icon: Icon(_statusIcon, color: _statusColor),
                    label: Text(_statusText),
                    onPressed: () {
                      _showStatusDialog(context);
                    },
                  ),
                ],
              ),
            ),
            // Overview Section
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.videogame_asset, color: tertiaryColor),
                      SizedBox(width: 8),
                      Text('${_libraryController.libraryItems.length} Game(s)', style: TextStyle(fontSize: 16, color: foregroundColor)),
                      Spacer(),
                      Icon(Icons.access_time, color: tertiaryColor),
                      SizedBox(width: 8),
                      Text('4 Years with NexPlay', style: TextStyle(fontSize: 16, color: foregroundColor)),
                    ],
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(value: 0),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(Icons.language, color: tertiaryColor),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: LanguagePickerDropdown(
                          itemBuilder: (Language language) => Text(
                            language.name,
                            style: TextStyle(color: foregroundColor),
                          ),
                          initialValue: _selectedLanguage,
                          onValuePicked: (Language language) {
                            setState(() {
                              _selectedLanguage = language;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: foregroundColor),
                  // Notifications
                  ListTile(
                      leading: Icon(Icons.notifications, color: tertiaryColor),
                      title: Text('Notifications', style: TextStyle(color: foregroundColor)),
                      trailing: Switch(
                        value: _switchNotifications,
                        onChanged: (value) {
                          setState(() {
                            _switchNotifications = value;
                          });
                        },
                        thumbColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return backgroundColor;
                          }
                          return foregroundColor;
                        }),
                        trackColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return foregroundColor;
                          }
                          return backgroundColor;
                        }),
                      )),
                  Divider(color: foregroundColor),
                  // Marketing Emails
                  ListTile(
                      leading: Icon(Icons.email, color: tertiaryColor),
                      title: Text('Marketing emails', style: TextStyle(color: foregroundColor)),
                      trailing: Switch(
                        value: _switchMarketing,
                        onChanged: (value) {
                          setState(() {
                            _switchMarketing = value;
                          });
                        },
                        thumbColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return backgroundColor;
                          }
                          return foregroundColor;
                        }),
                        trackColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return foregroundColor;
                          }
                          return backgroundColor;
                        }),
                      )),
                  Divider(color: foregroundColor),
                  ListTile(
                    leading: Icon(Icons.copy_sharp, color: tertiaryColor),
                    title: Text('Terms and Conditions', style: TextStyle(color: foregroundColor, fontSize: 16)),
                    trailing: Icon(Icons.arrow_outward, color: foregroundColor),
                    onTap: () => Get.to(() => TermsConditions()),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              tileColor: foregroundColor,
              leading: Icon(Icons.circle, color: Colors.green),
              title: Text('Online', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Online', Colors.green, Icons.circle);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: foregroundColor,
              leading: Icon(Icons.remove_circle_outline, color: Colors.red),
              title: Text('Do not disturb', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Do not disturb', Colors.red, Icons.remove_circle_outline);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: foregroundColor,
              leading: Icon(Icons.access_time, color: Colors.orange),
              title: Text('Away', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Away', Colors.orange, Icons.access_time);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: foregroundColor,
              leading: Icon(Icons.radio_button_unchecked, color: Colors.grey),
              title: Text('Invisible', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Invisible', Colors.grey, Icons.radio_button_unchecked);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
