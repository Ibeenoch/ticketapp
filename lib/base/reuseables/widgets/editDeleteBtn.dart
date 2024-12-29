import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/testing.dart';
import 'package:provider/provider.dart';

class EditDeleteBtn extends StatefulWidget {
  final String leftText;
  final String rightText;
  final String ticketId;
  final String userId;

  const EditDeleteBtn({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.ticketId,
    required this.userId,
  });

  @override
  State<EditDeleteBtn> createState() => _EditDeleteBtnState();
}

class _EditDeleteBtnState extends State<EditDeleteBtn> {
  bool isLeft = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;

    final ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            if (user == null) {
              Navigator.pushNamed(context, AppRoutes.accountScreen);
            } else {
              Navigator.pushNamed(context, AppRoutes.ticketForm,
                  arguments: {'ticketId': widget.ticketId});
            }
          },
          child: Container(
            width: size.width * 0.43,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: AppStyles.cardBlueColor),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Text(
              widget.leftText,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            if (user == null) {
              Navigator.pushNamed(context, AppRoutes.accountScreen);
            } else {
              ticketProvider.deleteTicket(
                  widget.ticketId, widget.userId, context);
            }
          },
          child: Container(
            width: size.width * 0.43,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: AppStyles.cardRedColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r))),
            child: Text(
              widget.rightText,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
