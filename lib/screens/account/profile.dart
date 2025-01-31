import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/utils/timeFormatter.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/authWidget/biometrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? fingerPrintId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> _registerBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canCheckBiometrics = await auth.canCheckBiometrics;

    if (!canCheckBiometrics) {
      // device does not support biometrics
      return false;
    }

    try {
      final bool isAutheticated = await auth.authenticate(
          localizedReason: 'Please autheticate to enable biometrics',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      return isAutheticated;
    } catch (e) {
      print('Error during biometric registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during biometric registration: $e'),
      ));
      return false;
    }
  }

  Future<void> registerBiometricAndSaveUser(String fingerPrintId) async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;

    // set/update fingerprint id in the back4app db
    currentUser.set('fingerPrintId', fingerPrintId);

    // save the updated user
    final response = await currentUser.save();
    if (response.success) {
      print("Fingerprint ID saved successfully!");
    } else {
      print("Error saving fingerprint ID: ${response.error?.message}");
    }
  }

  Future<void> enableFingerPrint() async {
    try {
      final bool isAutheticated = await _registerBiometric();

      if (isAutheticated) {
        // generate random a unique finger id
        var uuid = Uuid();
        String fingerPrintId = uuid.v4();

        // save biometric locally
        final prefs = await SharedPreferences.getInstance();

        // Save the fingerprint ID
        await prefs.setString('fingerPrintId', fingerPrintId);
        // Flag to indicate biometric authentication is enabled
        await prefs.setBool('isBiometricEnabled', true);

        // optionally, save the fingerprint Id to the server in back4app
        registerBiometricAndSaveUser(fingerPrintId);
        // final user = Provider.of<UserProvider>(context, listen: false);
        // final userUpate = user.currentUser;
        // print('userUpate $userUpate');

        // notify user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Biometric Authetication is now enabled')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Biometric authentication failed!')),
        );
      }
    } catch (e) {
      print('Error registering Fingerprint Bio metrics:  $e ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error registering Fingerprint Bio metrics:  $e')),
      );
    }
  }

  Future<void> logout() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.logOut(context);
    Navigator.pushNamed(context, AppRoutes.accountScreen);
  }

  void navigateToTicket() async {
    Navigator.pushNamed(
      context,
      AppRoutes.ticketForm,
    );
  }

  void navigateToHostel() async {
    Navigator.pushNamed(
      context,
      AppRoutes.hostelForm,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).currentUser;

    String getfullname = 'guest';

    final user = userProvider;

    if (user != null) {
      setState(() {
        getfullname = user.get('fullname');
        fingerPrintId = userProvider?.get<String>('fullname');
      });
    }
    String fullname = getfullname;

    List<String> namePart = fullname.split(' ');
    String firstName = namePart[0];
    String lastName = namePart[1];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppStyles.defaultBackGroundColor(context),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                topRow(user),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userName(firstName, context, lastName),
                    homeIcon(context)
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                sections(
                    context,
                    Icons.airplane_ticket,
                    AppStyles.backGroundOfkakiContainer(context),
                    AppStyles.backGroundOfkakiIconContainer(context),
                    'Create Ticket',
                    Icons.keyboard_arrow_right,
                    AppStyles.backGroundOfkakiContainer(context),
                    AppStyles.backGroundOfkakiIconContainer(context),
                    navigateToTicket),
                SizedBox(
                  height: 10.h,
                ),
                sections(
                    context,
                    Icons.hotel_sharp,
                    AppStyles.backGroundOfkakiContainer(context),
                    AppStyles.backGroundOfkakiIconContainer(context),
                    'Create Hostels',
                    Icons.keyboard_arrow_right,
                    AppStyles.backGroundOfkakiContainer(context),
                    AppStyles.backGroundOfkakiIconContainer(context),
                    navigateToHostel),
                SizedBox(
                  height: 10.h,
                ),
                sections(
                    context,
                    Icons.settings,
                    AppStyles.backGroundOfkakiContainer(context),
                    AppStyles.backGroundOfkakiIconContainer(context),
                    'Settings',
                    Icons.keyboard_arrow_right,
                    AppStyles.backGroundOfkakiContainer(context),
                    AppStyles.backGroundOfkakiIconContainer(context),
                    () {}),
                SizedBox(
                  height: 10.h,
                ),
                fingerPrint(context),
                SizedBox(
                  height: 20.h,
                ),
                logOut(context),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget fingerPrint(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Biometrics(
          onTap: enableFingerPrint,
          icon: Icon(
            Icons.fingerprint,
            size: 30.w,
            color: fingerPrintId == null
                ? AppStyles.backGroundOfkakiIconContainer(context)
                : Colors.green,
          ),
          text: fingerPrintId == null
              ? 'Enable Fingerprint'
              : 'Fingerprint Enabled',
          isEnabled: fingerPrintId != null,
        ),
      ],
    );
  }

  Column userName(String firstName, BuildContext context, String lastName) {
    return Column(
      children: [
        Text(
          '$firstName',
          style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: AppStyles.textWhiteBlack(context)),
        ),
        Text(
          '$lastName',
          style: TextStyle(
              fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  Widget homeIcon(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final user =
                Provider.of<UserProvider>(context, listen: false).currentUser;

            Navigator.pushNamed(context, AppRoutes.accountScreen, arguments: {
              'user': user,
            });
          },
          child: Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppStyles.backGroundColorWhiteAndDeepBlue(context)),
            child: Icon(
              Icons.edit,
              size: 30.sp,
              color: AppStyles.backGroundOfkakiIconContainer(context),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.homePage);
          },
          child: Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppStyles.backGroundColorWhiteAndDeepBlue(context)),
            child: Icon(
              Icons.home,
              size: 30.sp,
              color: AppStyles.backGroundOfkakiIconContainer(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget logOut(BuildContext context) {
    return GestureDetector(
      onTap: logout,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            color: AppStyles.backGroundColorWhiteAndDeepBlue(context)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout,
              size: 16.sp,
              color: AppStyles.backGroundOfkakiIconContainer(context),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              'Logout',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.backGroundOfkakiIconContainer(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget sections(
      BuildContext context,
      IconData leftIcon,
      Color leftbgColor,
      Color leftIconColor,
      String text,
      IconData rightIcon,
      Color rightbgColor,
      Color rightIconColor,
      VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: AppStyles.backGroundColorWhiteAndDeepBlue(context),
          borderRadius: BorderRadius.circular(15.r)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: leftbgColor),
                    child: Icon(
                      leftIcon,
                      size: 14.sp,
                      color: leftIconColor,
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppStyles.textWhiteBlack(context)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: rightbgColor),
              child: Icon(
                rightIcon,
                size: 15.sp,
                color: rightIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding topRow(ParseUser? user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 73.r,
            backgroundColor: AppStyles.cardBlueColor,
            child: CircleAvatar(
              backgroundImage: NetworkImage(user?.get('profile_img')),
              radius: 70.r,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Joined',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                formatMongoDbTimestamp(user?.get('createdAt')),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.textWhiteBlack(context)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
