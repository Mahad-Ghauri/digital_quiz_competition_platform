// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:digital_quiz_competition_platform/Controllers/Authentication/authentication_controller.dart';
import 'package:digital_quiz_competition_platform/Providers/language_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/notification_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/sound_provider.dart';
import 'package:digital_quiz_competition_platform/Providers/user_profile_provider.dart';
import 'package:digital_quiz_competition_platform/Views/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:digital_quiz_competition_platform/Providers/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    final imagePath = userProfileProvider.userProfile.profileImagePath;

    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });

      // Update the user profile with the new image path
      final userProfileProvider =
          Provider.of<UserProfileProvider>(context, listen: false);
      await userProfileProvider.updateUserProfile(profileImagePath: image.path);
    }
  }

  Future<void> _saveSettings() async {
    // The providers will handle saving the settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings saved successfully'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final soundProvider = Provider.of<SoundProvider>(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageProvider.translate('settings'),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? Colors.grey.shade900.withOpacity(0.9)
                          : Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildProfileSection(userProfileProvider),
                        const Divider(height: 30),
                        _buildToggleSetting(
                          icon: Icons.notifications,
                          title: languageProvider.translate('notifications'),
                          subtitle:
                              languageProvider.translate('receiveUpdates'),
                          value: notificationProvider.notificationsEnabled,
                          onChanged: (value) {
                            notificationProvider.toggleNotifications(value);
                          },
                        ),
                        _buildToggleSetting(
                          icon: Icons.dark_mode,
                          title: languageProvider.translate('darkMode'),
                          subtitle: languageProvider.translate('switchThemes'),
                          value: themeProvider.isDarkMode,
                          onChanged: (value) {
                            themeProvider.toggleTheme(value);
                          },
                        ),
                        _buildDropdownSetting(
                          icon: Icons.language,
                          title: languageProvider.translate('language'),
                          subtitle:
                              languageProvider.translate('chooseLanguage'),
                          value: languageProvider.currentLanguage,
                          items: _languages,
                          onChanged: (value) {
                            if (value != null) {
                              languageProvider.setLanguage(value);
                            }
                          },
                        ),
                        _buildSliderSetting(
                          icon: Icons.volume_up,
                          title: languageProvider.translate('soundVolume'),
                          subtitle: languageProvider.translate('adjustSound'),
                          value: soundProvider.volume,
                          onChanged: (value) {
                            soundProvider.setVolume(value);
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildSettingItem(
                          icon: Icons.help,
                          title: languageProvider.translate('help'),
                          subtitle: languageProvider.translate('getHelp'),
                          onTap: _showHelpDialog,
                        ),
                        _buildSettingItem(
                          icon: Icons.info,
                          title: languageProvider.translate('about'),
                          subtitle: languageProvider.translate('learnMore'),
                          onTap: _showAboutDialog,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveSettings,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            languageProvider.translate('saveSettings'),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: _confirmLogout,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                languageProvider.translate('logout'),
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                      ],
                    ),
                  ),
                ).animate().slideY(
                    begin: 0.2,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOutQuad),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(UserProfileProvider userProfileProvider) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: _profileImage != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(_profileImage!),
                  )
                : const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(height: 15),
          Text(
            userProfileProvider.userProfile.name,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AuthenticationController().getCurrentUserEmail() ??
                "user@example.com",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton(
            onPressed: () => _editProfile(userProfileProvider),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              languageProvider.translate('editProfile'),
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 500.ms, curve: Curves.easeOutQuad);
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.blue),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSetting({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSetting({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: GoogleFonts.poppins(color: Colors.black87),
              underline: Container(height: 0),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.blue),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(value * 100).round()}%",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            activeColor: Colors.blue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _editProfile(UserProfileProvider userProfileProvider) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final nameController =
        TextEditingController(text: userProfileProvider.userProfile.name);
    final usernameController =
        TextEditingController(text: userProfileProvider.userProfile.username);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          languageProvider.translate('editProfile'),
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage();
                  _editProfile(userProfileProvider);
                },
                child: _profileImage != null
                    ? CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(_profileImage!),
                      )
                    : const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _pickImage();
                  _editProfile(userProfileProvider);
                },
                child: Text(
                  "Change Profile Picture",
                  style: GoogleFonts.poppins(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: nameController,
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: usernameController,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await userProfileProvider.updateUserProfile(
                name: nameController.text,
                username: usernameController.text,
              );

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Profile updated successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final soundProvider = Provider.of<SoundProvider>(context, listen: false);

    // Play a sound effect when opening the dialog
    soundProvider.playSound('dialog_open');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          languageProvider.translate('help'),
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpItem(
                "How to play?",
                "Select a category, answer questions, and earn points for correct answers.",
              ),
              _buildHelpItem(
                "How are points calculated?",
                "Each question has a point value based on difficulty. Faster answers earn bonus points.",
              ),
              _buildHelpItem(
                "How to report a bug?",
                "Contact us at support@quizapp.com with details about the issue.",
              ),
              _buildHelpItem(
                "How to suggest new features?",
                "Send your ideas to feedback@quizapp.com.",
              ),
              const SizedBox(height: 15),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Play a sound effect when clicking the button
                    soundProvider.playSound('button_click');

                    // Show a notification if notifications are enabled
                    final notificationProvider =
                        Provider.of<NotificationProvider>(context,
                            listen: false);
                    if (notificationProvider.notificationsEnabled) {
                      notificationProvider.showNotification(
                        title: 'Support Request',
                        body:
                            'Your support request has been sent. We\'ll get back to you soon.',
                      );
                    }

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Support request sent!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.email),
                  label: Text(
                    "Contact Support",
                    style: GoogleFonts.poppins(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final soundProvider = Provider.of<SoundProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    // Play a sound effect when opening the dialog
    soundProvider.playSound('dialog_open');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          languageProvider.translate('about'),
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.quiz,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Quizizen v1.0.0",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Quizizen is an interactive platform for testing your knowledge across various categories. Challenge yourself with questions from different fields and compete with others on the leaderboard.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade300
                      : Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialButton(Icons.language, "Website", () {
                    soundProvider.playSound('button_click');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening website...'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }),
                  _buildSocialButton(Icons.privacy_tip, "Privacy", () {
                    soundProvider.playSound('button_click');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening privacy policy...'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }),
                  _buildSocialButton(Icons.description, "Terms", () {
                    soundProvider.playSound('button_click');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening terms of service...'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              soundProvider.playSound('button_click');
              Navigator.pop(context);
            },
            child: Text(
              "Close",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, VoidCallback onTap) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: Colors.blue,
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: themeProvider.isDarkMode
                ? Colors.grey.shade300
                : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _confirmLogout() {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final soundProvider = Provider.of<SoundProvider>(context, listen: false);

    // Play a sound effect when opening the dialog
    soundProvider.playSound('dialog_open');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirm Logout",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to log out?",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              soundProvider.playSound('button_click');
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              soundProvider.playSound('button_click');
              Navigator.pop(context);
              _logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Logout",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    try {
      // Save all settings before logging out
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final languageProvider =
          Provider.of<LanguageProvider>(context, listen: false);
      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      final soundProvider = Provider.of<SoundProvider>(context, listen: false);

      // Play a logout sound
      soundProvider.playSound('logout');

      // Show a notification if enabled
      if (notificationProvider.notificationsEnabled) {
        notificationProvider.showNotification(
          title: 'Logged Out',
          body: 'You have been successfully logged out.',
        );
      }

      await AuthenticationController().signOutAndEndSession(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error '),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}
