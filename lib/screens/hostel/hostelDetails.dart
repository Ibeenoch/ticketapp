import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class HostelDetails extends StatefulWidget {
  const HostelDetails({super.key});

  @override
  State<HostelDetails> createState() => _HostelDetailsState();
}

class _HostelDetailsState extends State<HostelDetails> {
  int currentIndex = 0;
  bool isFullDetails = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        currentIndex = args['index'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> getHostel = {};
    final hostelProvider = Provider.of<HostelProvider>(context, listen: false);
    final allHostels = hostelProvider.hotels;

    ParseObject? foundHostel = allHostels[currentIndex];

    getHostel = foundHostel.toJson();

    final String fullDetails = getHostel['details'];
    final String shortDetails = fullDetails.substring(0, 700);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppStyles.defaultBackGroundColor(context),
            expandedHeight: 300,
            pinned: true,
            floating: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4)),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: [
                Positioned.fill(
                  child: Image(
                    image: NetworkImage(getHostel['imageList'][0]),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: size.width * 0.4,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.sp, vertical: 7.sp),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6.r)),
                      child: Text(
                        getHostel['name'],
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.8)),
                      )),
                )
              ],
            )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.all(15.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isFullDetails = !isFullDetails;
                  });
                },
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text:
                            isFullDetails == true ? fullDetails : shortDetails,
                        style: TextStyle(fontSize: 11.sp)),
                    TextSpan(
                        text:
                            isFullDetails == true ? ' Show Less' : ' Show More',
                        style: TextStyle(color: Colors.blue, fontSize: 12.sp))
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Text(
                'More Images',
                style: TextStyle(
                    color: AppStyles.cardBlueColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getHostel['imageList'].length,
                  itemBuilder: (context, index) {
                    String imageUrl = getHostel['imageList'][index];
                    return Container(
                      child: Image(
                        image: NetworkImage(imageUrl),
                        width: 205,
                        height: 150,
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20.h,
            )
          ])),
        ],
      ),
    );
  }
}
