import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Page',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppStyles.textWhiteBlack(context)),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        backgroundColor: AppStyles.defaultBackGroundColor(context),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: const SafeArea(child: Column()),
    );
  }
}
