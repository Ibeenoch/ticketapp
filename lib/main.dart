import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/BottomBar.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/account.dart';
import 'package:airlineticket/screens/account/authWidget/login.dart';
import 'package:airlineticket/screens/account/authWidget/signup.dart';
import 'package:airlineticket/screens/account/profile.dart';
import 'package:airlineticket/screens/home/homewidget/AllHotelViews.dart';
import 'package:airlineticket/screens/home/homewidget/AllTicketScreen.dart';
import 'package:airlineticket/screens/hostel/HostelForm.dart';
import 'package:airlineticket/screens/ticket/TicketForm.dart';
import 'package:airlineticket/screens/ticket/ticketScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load the .env file
    await dotenv.load(fileName: ".env");
    print("Env file loaded successfully!");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  String applicationId = dotenv.env["BACK4APP_APP_ID"]!;
  String serverUrl = 'https://parseapi.back4app.com';
  String clientKey = dotenv.env["BACK4APP_CLIENT_ID"]!;

  await Parse().initialize(
    applicationId,
    serverUrl,
    clientKey: clientKey, // Optional
    autoSendSessionId: true,
  );

  runApp(MyApp());
}

// It's handy to then extract the Supabase client in a variable for later uses

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(315, 812), // set the design size
      minTextAdapt: true, // adjust text size base on screen size
      splitScreenMode: true, // split screen for multiple windows
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                final userProvider = UserProvider();
                userProvider.checkUserSession();
                return userProvider;
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                final ticketProvider = Ticketprovider();
                ticketProvider.fetchTickets();
                return ticketProvider;
              },
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const BottomBar(),
            routes: {
              // AppRoutes.homePage: (context) => const BottomBar(),
              AppRoutes.allTickets: (context) => const Allticketscreen(),
              AppRoutes.allHotels: (context) => const Allhotelviews(),
              AppRoutes.ticketScreen: (context) => const Ticketscreen(),
              AppRoutes.loginScreen: (context) => const Login(),
              AppRoutes.signupScreen: (context) => const Signup(),
              AppRoutes.accountScreen: (context) => const Account(),
              AppRoutes.profileScreen: (context) => const Profile(),
              AppRoutes.hostelForm: (context) => const Hostelform(),
              AppRoutes.ticketForm: (context) => const Ticketform(),
            },
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
          ),
        );
      },
    );
  }
}
