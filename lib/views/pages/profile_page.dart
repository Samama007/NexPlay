import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:nexplay/controller/image_controller.dart';
import 'package:nexplay/util/theme.dart';
import 'package:nexplay/views/pages/authentication/login_page.dart';
import 'package:nexplay/controller/library_controller.dart';
import 'package:nexplay/views/pages/terms_conditions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LibraryController _libraryController = Get.find();
  final ImageController _imageController = Get.put(ImageController());
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
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Text('My Profile', style: TextStyle(color: foregroundColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.wb_sunny, color: foregroundColor),
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
              print('Theme changed: Is Dark Mode: ${Get.isDarkMode}');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: foregroundColor),
            onPressed: () async {
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
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.setBool('firstTime', false);

              // Get current user email
              String? email = pref.getString('currentUserEmail');

              // Reset login status for the specific user
              if (email != null) {
                await pref.setBool('loginStatus_$email', false);
              }

              // Remove current user email
              await pref.remove('currentUserEmail');

              _auth.signOut();
              Get.offAll(() => const LoginPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    splashColor: backgroundColor,
                    highlightColor: backgroundColor,
                    onTap: () {
                      _imageController.pickImage();
                    },
                    child: Obx(() {
                      return _imageController.profileImage.value != null
                          ? Badge(
                              label: Icon(Icons.camera_alt_outlined, color: backgroundColor, size: 20),
                              backgroundColor: foregroundColor,
                              alignment: Alignment(0.4, 0.7),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(_imageController.profileImage.value!),
                              ),
                            )
                          : const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage('assets/images/profile.png'),
                            );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.username,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: foregroundColor),
                  ),
                  const SizedBox(height: 4),
                  if (_libraryController.libraryItems.isNotEmpty)
                    Text(
                      'LEVEL ${(_libraryController.libraryItems.length / 2).floor() + 1}',
                      style: TextStyle(fontSize: 16, color: foregroundColor),
                    )
                  else
                    Text(
                      'LEVEL 1',
                      style: TextStyle(fontSize: 16, color: foregroundColor),
                    ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(foregroundColor), foregroundColor: WidgetStatePropertyAll(backgroundColor)),
                    icon: Icon(_statusIcon, color: _statusColor),
                    label: Text(_statusText),
                    onPressed: () {
                      _showStatusDialog(context, backgroundColor, foregroundColor, tertiaryColor);
                    },
                  ),
                ],
              ),
            ),
            // Overview Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.videogame_asset, color: tertiaryColor),
                      const SizedBox(width: 8),
                      Text('${_libraryController.libraryItems.length} Game(s)', style: TextStyle(fontSize: 16, color: foregroundColor)),
                      const Spacer(),
                      Icon(Icons.access_time, color: tertiaryColor),
                      const SizedBox(width: 8),
                      Text('4 Years with NexPlay', style: TextStyle(fontSize: 16, color: foregroundColor)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const LinearProgressIndicator(value: 0),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(Icons.language, color: tertiaryColor),
                      ),
                      const SizedBox(width: 16),
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
                          if (value == true) {
                            Get.snackbar(
                              '',
                              '',
                              duration: Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: backgroundColor,
                              colorText: foregroundColor,
                              titleText: Text('Notifications ON', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              messageText: Text('Be the first to hear about weekly sales, exclusive offers and more.', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.w400, fontSize: 12)),
                            );
                          } else {
                            Get.snackbar(
                              '',
                              '',
                              duration: Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: backgroundColor,
                              colorText: foregroundColor,
                              titleText: Text('Notifications OFF', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              messageText: Text('Be the first to hear about weekly sales, exclusive offers and more.', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.w400, fontSize: 12)),
                            );
                          }
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
                          if (value == true) {
                            Get.snackbar(
                              '',
                              '',
                              duration: Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: backgroundColor,
                              colorText: foregroundColor,
                              titleText: Text('Marketing Emails ON', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              messageText: Text('Consent granted to receive marketing emails, weekly updates from NexPlay.', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.w400, fontSize: 12)),
                            );
                          } else {
                            Get.snackbar(
                              '',
                              '',
                              duration: Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: backgroundColor,
                              colorText: foregroundColor,
                              titleText: Text('Marketing Emails OFF', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              messageText: Text('Consent revoked to receive marketing emails, weekly updates from NexPlay.', style: TextStyle(color: foregroundColor, fontWeight: FontWeight.w400, fontSize: 12)),
                            );
                          }
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
                    onTap: () => Get.to(() => const TermsConditions()),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusDialog(BuildContext context, Color backgroundColor, Color foregroundColor, Color tertiaryColor) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              tileColor: foregroundColor,
              leading: const Icon(Icons.circle, color: Colors.green),
              title: Text('Online', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Online', Colors.green, Icons.circle);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: foregroundColor,
              leading: const Icon(Icons.remove_circle_outline, color: Colors.red),
              title: Text('Do not disturb', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Do not disturb', Colors.red, Icons.remove_circle_outline);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: foregroundColor,
              leading: const Icon(Icons.access_time, color: Colors.orange),
              title: Text('Away', style: TextStyle(color: backgroundColor)),
              onTap: () {
                _updateStatus('Away', Colors.orange, Icons.access_time);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: foregroundColor,
              leading: const Icon(Icons.radio_button_unchecked, color: Colors.grey),
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
