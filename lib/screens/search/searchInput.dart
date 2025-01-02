import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController mainsearch = TextEditingController();
  FocusNode mainsearch_F = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainsearch_F.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mainsearch.dispose();
    super.dispose();
  }

  Future<void> mainsearchInput(String val) async {
    try {
      print('mainsearching $val');
    } catch (e) {
      print('error mainsearching $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      appBar: AppBar(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.homePage);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.r)),
                    child: TextField(
                      controller: mainsearch,
                      focusNode: mainsearch_F,
                      cursorColor: AppStyles.cardBlueColor,
                      style: TextStyle(
                          fontSize: 10.sp, color: AppStyles.cardBlueColor),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'mainsearch for Hotel, Ticket',
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppStyles.cardBlueColor,
                            size: 14.sp,
                          )),
                      onChanged: (value) {
                        mainsearchInput(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
