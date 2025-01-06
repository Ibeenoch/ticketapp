import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController mainsearch = TextEditingController();
  FocusNode mainsearch_F = FocusNode();
  List<String> matchingWords = [];
  String? source;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainsearch_F.addListener(() {});
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      source = args['source'];
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mainsearch.dispose();
    super.dispose();
  }

  Future<List<String>> mainsearchInput(String val) async {
    List<String> matchingWordsArr = [];
    final ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
    final hotelProvider = Provider.of<HostelProvider>(context, listen: false);

    try {
      await ticketProvider.searchTicket(val);
      await hotelProvider.searchHotel(val);

      final ticketsFound = ticketProvider.tickets;
      final hotelsFound = hotelProvider.hotels;
      final totalFound = [...ticketsFound, ...hotelsFound];

      for (final object in totalFound) {
        final fieldsToCheck = [
          'name',
          'location',
          'details',
          'price',
          'departure_country',
          'arrival_country',
          'flight_month',
          'flight_day',
          'departure_time_minutes',
          'departure_time_hrs',
          'flight_duration_hrs',
          'flight_duration_minutes',
          'pilot',
          'bookingNo',
          'ticketNo',
          'passport',
          'paymentMethod'
        ];

        for (final field in fieldsToCheck) {
          final fieldValue = object.get<String>(field);

          if (fieldValue != null && fieldValue.isNotEmpty) {
            // Split field into individual words
            final words = fieldValue.split(RegExp(r'\s+'));

            for (final word in words) {
              // Add only words that start with the input value

              if (word.toLowerCase().startsWith(val.toLowerCase())) {
                print('true $word   $val');
                matchingWordsArr.add(word);
              }
            }
          }
        }
      }

      return matchingWordsArr;
    } catch (e) {
      print('Error in mainsearchInput: $e');
      throw new Exception(e.toString());
    }
  }

  void getSearchResult(String search) async {
    Navigator.pushNamed(context, AppRoutes.searchResult,
        arguments: {'search': search});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          HomeNavBtn(),
        ],
        centerTitle: true,
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        leading: GestureDetector(
            onTap: () {
              source == 'Home'
                  ? Navigator.pushNamed(context, AppRoutes.homePage)
                  : Navigator.pushNamed(context, AppRoutes.searchHome);
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
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.r)),
                child: TextField(
                  controller: mainsearch,
                  focusNode: mainsearch_F,
                  autofocus: true,
                  cursorColor: AppStyles.cardBlueColor,
                  style: TextStyle(
                      fontSize: 10.sp, color: AppStyles.cardBlueColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'search for Hotel, Ticket',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppStyles.cardBlueColor,
                        size: 14.sp,
                      )),
                  onChanged: (value) async {
                    List<String> foundedWords = [];
                    if (value.isNotEmpty) {
                      foundedWords = await mainsearchInput(value);
                      setState(() {
                        matchingWords = foundedWords
                            .toSet()
                            .toList(); // to remove duplicate words
                      });
                    } else {
                      foundedWords = []; // clear suggestion if input is empty;
                      setState(() {
                        matchingWords = foundedWords;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height,
                child: ListView.builder(
                  itemCount: matchingWords.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: AppStyles.borderBackGroundColor(context),
                      child: ListTile(
                        title: InkWell(
                          onTap: () {
                            getSearchResult(matchingWords[index]);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: 12.sp,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                matchingWords[index],
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppStyles.textWhiteBlack(context)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
