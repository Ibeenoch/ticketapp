import 'dart:io';

import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/loadingtextAnimation.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Hostelform extends StatefulWidget {
  const Hostelform({super.key});

  @override
  State<Hostelform> createState() => _HostelformState();
}

class _HostelformState extends State<Hostelform> {
  bool isBtnClickedCreate = false;
  String? hostelId;

  TextEditingController name = TextEditingController();
  FocusNode nameF = FocusNode();
  String? nameErr;

  String? generalErr;

  TextEditingController location = TextEditingController();
  FocusNode locationF = FocusNode();
  String? locationErr;

  TextEditingController price = TextEditingController();
  FocusNode priceF = FocusNode();
  String? priceErr;

  TextEditingController details = TextEditingController();
  FocusNode detailsF = FocusNode();
  String? detailsErr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameF.addListener(() {
      if (!nameF.hasFocus) {
        validateName();
      }
    });

    locationF.addListener(() {
      if (!locationF.hasFocus) {
        validateLocation();
      }
    });

    priceF.addListener(() {
      if (!priceF.hasFocus) {
        validatePrice();
      }
    });

    detailsF.addListener(() {
      if (!detailsF.hasFocus) {
        validateDetails();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int index;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      index = args['index'];

      final hostels =
          Provider.of<HostelProvider>(context, listen: false).hotels;
      final hostel = hostels[index];
      setState(() {
        hostelId = hostel.get<String>('objectId');
      });
      print('the hostel is $hostelId');
      if (hostelId != null) {
        name.text = hostel['name'];
        location.text = hostel['location'];
        price.text = hostel['price'];
        details.text = hostel['details'];
      }
    }
  }

  void validateDetails() {
    final detailsText = details.text;

    if (detailsText.isEmpty) {
      detailsErr = 'Hotel details is Required';
    } else {
      detailsErr = null;
    }
  }

  void validatePrice() {
    final priceText = price.text;

    if (priceText.isEmpty) {
      priceErr = 'Hotel price is Required';
    } else {
      priceErr = null;
    }
  }

  void validateLocation() {
    final locationText = location.text;

    if (locationText.isEmpty) {
      locationErr = 'Hotel location is Required';
    } else {
      locationErr = null;
    }
  }

  void validateName() {
    final nameText = name.text;

    if (nameText.isEmpty) {
      nameErr = 'Hotel Name is Required';
    } else {
      nameErr = null;
    }
  }

  List<File> imagesPicked = [];

  Future<void> getMultipleImages() async {
    final _pickImage = ImagePicker();
    final List<XFile> images = await _pickImage.pickMultiImage(
      maxHeight: 250,
      maxWidth: 200,
    );

    if (images != null) {
      for (XFile image in images) {
        imagesPicked.add(File(image.path));
      }
    }
  }

  void handleHostelCreation() async {
    setState(() {
      isBtnClickedCreate = true;
    });
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final hostelProvider = Provider.of<HostelProvider>(context, listen: false);
    final user = userProvider.currentUser;
    final userId = user?.get<String>('objectId');

    try {
      print(
          'all data ${name.text} ${location.text} ${price.text} ${location.text}');
      if (name.text.isEmpty ||
          location.text.isEmpty ||
          price.text.isEmpty ||
          details.text.isEmpty) {
        setState(() {
          generalErr = 'Please add all fields required';
        });
        return;
      }
      print(' imagesPicked ${imagesPicked} $userId');
      await hostelProvider.createHostel(
          name: name.text,
          location: location.text,
          price: price.text,
          details: details.text,
          userId: userId!,
          context: context,
          imagesPicked: imagesPicked);
    } catch (e, stackTrace) {
      print('error creating profile $e and $stackTrace');
      setState(() {
        isBtnClickedCreate = false;
      });
    }
  }

  void handleHostelUpdate() async {
    setState(() {
      isBtnClickedCreate = true;
    });
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final hostelProvider = Provider.of<HostelProvider>(context, listen: false);
    final user = userProvider.currentUser;
    final userId = user?.get<String>('objectId');

    try {
      print(
          'all data $imagesPicked ${name.text} ${location.text} ${price.text} ${location.text} $hostelId $userId');
      if (name.text.isEmpty ||
          location.text.isEmpty ||
          price.text.isEmpty ||
          details.text.isEmpty) {
        setState(() {
          generalErr = 'Please add all fields required';
          isBtnClickedCreate = false;
        });
        return;
      }
      await hostelProvider.updateHostel(
          name: name.text,
          location: location.text,
          price: price.text,
          details: details.text,
          userId: userId!,
          hostelId: hostelId!,
          context: context,
          imagesPicked: imagesPicked);
      setState(() {
        isBtnClickedCreate = false;
      });
    } catch (e, stackTrace) {
      setState(() {
        isBtnClickedCreate = false;
      });
      print('error creating profile $e and $stackTrace');
    }
  }

  @override
  void dispose() {
    name.dispose();
    location.dispose();
    price.dispose();
    details.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      appBar: AppBar(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        title: Text(
          hostelId == null ? 'Add Hotel' : 'Edit Hostel',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          HomeNavBtn(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            labelTitle('Hostel Name'),
            SizedBox(
              height: 7.h,
            ),
            inputs(name, nameF, Icons.location_city, 'Hostel Name',
                nameErr == null ? false : true, 'Hostel Name', false, false),
            if (nameErr != null) errorMessage(nameErr!),
            SizedBox(
              height: 20.h,
            ),
            labelTitle('Hostel Location'),
            SizedBox(
              height: 7.h,
            ),
            inputs(
                location,
                locationF,
                Icons.place,
                'Hostel location',
                locationErr == null ? false : true,
                'Hostel location',
                false,
                false),
            if (locationErr != null) errorMessage(locationErr!),
            SizedBox(
              height: 20.h,
            ),
            labelTitle('Hostel Price'),
            SizedBox(
              height: 7.h,
            ),
            inputs(price, priceF, Icons.monetization_on, 'Hostel price',
                priceErr == null ? false : true, 'Hostel price', true, false),
            if (priceErr != null) errorMessage(priceErr!),
            SizedBox(
              height: 20.h,
            ),
            labelTitle('Hostel Details'),
            SizedBox(
              height: 7.h,
            ),
            inputs(
                details,
                detailsF,
                Icons.description,
                'Hostel details',
                detailsErr == null ? false : true,
                'Hostel details',
                false,
                true),
            if (detailsErr != null) errorMessage(detailsErr!),
            SizedBox(
              height: 20.h,
            ),
            labelTitle('Add Photos'),
            SizedBox(
              height: 7.h,
            ),
            Container(
              width: double.infinity,
              height: 200.h,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                  color: AppStyles.borderBackGroundColor(context),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Container(
                decoration: BoxDecoration(
                    color: AppStyles.defaultBackGroundColor(context),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'upload multiple images',
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getMultipleImages();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyles.cardBlueColor,
                            foregroundColor: Colors.white),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 80),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                              Text(
                                'Upload Images',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                  ],
                )),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (generalErr != null) errorMessage(generalErr!),
            hostelBtn(hostelId),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector hostelBtn(String? hostelId) {
    return GestureDetector(
      onTap: hostelId != null ? handleHostelUpdate : handleHostelCreation,
      child: Container(
          width: double.infinity,
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppStyles.cardBlueColor),
          child: LoadingTextAnimation(
              text: hostelId == null ? 'Create' : 'Edit',
              isClicked: isBtnClickedCreate)),
    );
  }

  Row labelTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          ' * ',
          style: TextStyle(fontSize: 8.sp, color: Colors.red),
        ),
        Text(
          '(required)',
          style: TextStyle(
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }

  Widget inputs(
      TextEditingController controller,
      FocusNode focus,
      IconData icon,
      String hintText,
      bool hasErr,
      String focusname,
      bool useNum,
      bool increaseHeight,
      {int maxLength = 20}) {
    return Container(
      decoration: BoxDecoration(
          color: AppStyles.borderBackGroundColor(context),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: StatefulBuilder(builder: (context, setState) {
          focus.addListener(() {
            setState(() {});
          });

          return Container(
            padding:
                EdgeInsets.only(left: 6.w, bottom: 8.h, right: 8.w, top: 0.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  // height: increaseHeight == true ? 140 : 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppStyles.defaultBackGroundColor(context),
                  ),
                  child: TextField(
                    controller: controller,
                    inputFormatters: increaseHeight == true
                        ? null
                        : [LengthLimitingTextInputFormatter(maxLength)],
                    keyboardType: useNum ? TextInputType.number : null,
                    focusNode: focus,
                    onChanged: (value) {
                      if (focusname == 'name') {
                        //pilot passport, ticketNo, bookingNo, paymentMethod, price
                        // validatePassport();
                      } else {}
                    },
                    style: TextStyle(
                      fontSize: 8.sp,
                    ),
                    cursorColor: AppStyles.cardBlueColor,
                    decoration: InputDecoration(
                        hintText: focus.hasFocus ? '' : hintText,
                        hintStyle:
                            TextStyle(fontSize: 8.sp, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                        prefixIcon: Icon(
                          icon,
                          size: 15.sp,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                                color: hasErr
                                    ? Colors.red
                                    : AppStyles.borderlineColor(context))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                BorderSide(color: AppStyles.cardBlueColor))),
                    autofillHints: null,
                  ),
                ),
              ),
              (focus.hasFocus) // display the label overlapping the top border
                  ? Positioned(
                      top: 3.h,
                      left: 20.w,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppStyles.defaultBackGroundColor(context)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            focusname,
                            style: TextStyle(
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
          );
        }),
      ),
    );
  }
}
