import 'package:airlineticket/base/data/services/ticketServices.dart';
import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/resources/time.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/reuseableDropDown.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Ticketform extends StatefulWidget {
  const Ticketform({super.key});

  @override
  State<Ticketform> createState() => _TicketformState();
}

class _TicketformState extends State<Ticketform> {
  String? _selectedCountry;
  FocusNode selectedCountry_f = FocusNode();
  String? selectedCountryErr;
  final List<Map<String, String>> _countries = abbreviatedCountries;

  String? _selectedArrivalCountry;
  FocusNode selectedArrivalCountry_f = FocusNode();
  String? selectedArrivalCountryErr;
  final List<Map<String, String>> _arrivalcountries = abbreviatedCountries;

  String? _durationHour;
  FocusNode durationHour_f = FocusNode();
  String? durationHourErr;
  final List<int> durationHourList = time24Hrs;

  String? _durationMinutes;
  FocusNode durationMinutes_f = FocusNode();
  String? durationMinutesErr;
  final List<int> durationMinutesList = time60Mins;

  String? _durationMonth;
  FocusNode durationMonth_f = FocusNode();
  String? durationMonthErr;
  final List<String> durationMonthList = months;

  String? _durationDay;
  FocusNode durationDay_f = FocusNode();
  String? durationDayErr;
  final List<String> durationDayList = days;

  String? _departureHour;
  FocusNode departureHour_f = FocusNode();
  String? departureHourErr;
  final List<int> departureHourList = time24Hrs;

  String? _departureMinutes;
  FocusNode departureMinutes_f = FocusNode();
  String? departureMinutesErr;
  final List<String> departureMinutesList = timesDoubleZero;

  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedCountry_f.addListener(() {
      if (!selectedCountry_f.hasFocus) {
        validateSelectedCountry();
      }
    });

    selectedArrivalCountry_f.addListener(() {
      if (!selectedArrivalCountry_f.hasFocus) {
        validateSelectedArrivalCountry();
      }
    });

    durationHour_f.addListener(() {
      if (!durationHour_f.hasFocus) {
        validatedurationHour();
      }
    });

    durationMonth_f.addListener(() {
      if (!durationMonth_f.hasFocus) {
        validatedurationMonth();
      }
    });

    durationDay_f.addListener(() {
      if (!durationDay_f.hasFocus) {
        validatedurationDay();
      }
    });

    departureHour_f.addListener(() {
      if (!departureHour_f.hasFocus) {
        validateDepartureHour();
      }
    });

    departureMinutes_f.addListener(() {
      if (!departureMinutes_f.hasFocus) {
        validateDepartureMinutes();
      }
    });
  }

  void validateSelectedCountry() {
    if (_selectedCountry!.isEmpty) {
      setState(() {
        selectedCountryErr = 'Departure Country is required';
      });
    } else {
      setState(() {
        selectedCountryErr = null;
      });
    }
  }

  void validateSelectedArrivalCountry() {
    if (_selectedArrivalCountry!.isEmpty) {
      setState(() {
        selectedArrivalCountryErr = 'Arrival Country is required';
      });
    } else {
      setState(() {
        selectedArrivalCountryErr = null;
      });
    }
  }

  void validatedurationHour() {
    if (_durationHour!.isEmpty) {
      setState(() {
        durationHourErr = 'Duration hour is required';
      });
    } else {
      setState(() {
        durationHourErr = null;
      });
    }
  }

  void validatedurationMinute() {
    if (_durationMinutes!.isEmpty) {
      setState(() {
        durationMinutesErr = 'Duration minute is required';
      });
    } else {
      setState(() {
        durationMinutesErr = null;
      });
    }
  }

  void validatedurationMonth() {
    if (_durationMonth!.isEmpty) {
      setState(() {
        durationMonthErr = 'Duration Month is required';
      });
    } else {
      setState(() {
        durationMonthErr = null;
      });
    }
  }

  void validatedurationDay() {
    if (_durationDay!.isEmpty) {
      setState(() {
        durationDayErr = 'Duration day is required';
      });
    } else {
      setState(() {
        durationDayErr = null;
      });
    }
  }

  void validateDepartureHour() {
    if (_departureHour!.isEmpty) {
      setState(() {
        departureHourErr = 'Departure Hour is required';
      });
    } else {
      setState(() {
        departureHourErr = null;
      });
    }
  }

  void validateDepartureMinutes() {
    if (_departureMinutes!.isEmpty) {
      setState(() {
        departureMinutesErr = 'Duration day is required';
      });
    } else {
      setState(() {
        departureMinutesErr = null;
      });
    }
  }

  void handleTicketCreation() async {
    print('_selectedCountry: $_selectedCountry');
    print('_selectedArrivalCountry: $_selectedArrivalCountry');
    print('_durationHour: $_durationHour');
    print('_durationMinutes: $_durationMinutes');
    print('_durationMonth: $_durationMonth');
    print('_durationDay: $_durationDay');
    print('userId: $userId');
    print('_departureHour: $_departureHour');
    print('_departureMinutes: $_departureMinutes');

    try {
      await TicketServices().createTicket(
          departure_country: _selectedCountry!,
          arrival_country: _selectedArrivalCountry!,
          flight_duration_hrs: _durationHour!,
          flight_duration_minutes: _durationMinutes!,
          flight_month: _durationMonth!,
          flight_day: _durationDay!,
          userId: userId!,
          departure_time_hrs: _departureHour!,
          departure_time_minutes: _departureMinutes!,
          context: context);
    } catch (e) {
      print('Error creating ticket $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectedCountry_f.dispose();
    selectedArrivalCountry_f.dispose();
    durationHour_f.dispose();
    durationMinutes_f.dispose();
    durationMonth_f.dispose();
    durationDay_f.dispose();
    departureHour_f.dispose();
    departureMinutes_f.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    final String user_id = user?.get('objectId');
    userId = user_id;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Expanded(
            child: ListView(
              children: [
                Center(
                  child: Text(
                    'Create Tickets',
                    style: TextStyle(
                        color: AppStyles.textWhiteBlack(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),

                labelTitle(context, 'Departure Country'),
                SizedBox(
                  height: 5.h,
                ),

                inputCountry(
                  'choose depature country',
                  selectedCountryErr,
                  selectedCountry_f,
                  _countries,
                  _selectedCountry,
                  (String? newValue) {
                    // Callback to update _departureMinutes
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  },
                ),
                if (selectedCountryErr != null &&
                    selectedCountryErr!.isNotEmpty)
                  errorMessage(selectedCountryErr!),
                SizedBox(
                  height: 10.h,
                ),
                labelTitle(context, 'Arrival Country'),

                SizedBox(
                  height: 5.h,
                ),

                inputCountry(
                  'choose arrival country',
                  selectedArrivalCountryErr,
                  selectedArrivalCountry_f,
                  _arrivalcountries,
                  _selectedArrivalCountry,
                  (String? newValue) {
                    // Callback to update _departureMinutes
                    setState(() {
                      _selectedArrivalCountry = newValue;
                    });
                  },
                ),
                if (selectedArrivalCountryErr != null &&
                    selectedArrivalCountryErr!.isNotEmpty)
                  errorMessage(selectedArrivalCountryErr!),
                SizedBox(
                  height: 10.h,
                ),
                labelTitle(context, 'Flight Duration (Hours)'),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  child: inputTimeNum(
                      'Hours Expected',
                      durationHourErr,
                      durationHour_f,
                      durationHourList,
                      _durationHour, (String? newValue) {
                    setState(() {
                      _durationHour = newValue;
                    });
                  }),
                ),
                if (durationHourErr != null && durationHourErr!.isNotEmpty)
                  errorMessage(durationHourErr!),
                SizedBox(
                  height: 10.w,
                ),
                labelTitle(context, 'Flight Duration (Minutes)'),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  child: inputTimeNum(
                      'Minutes Expected',
                      durationMinutesErr,
                      durationMinutes_f,
                      durationMinutesList,
                      _durationMinutes, (String? newValue) {
                    setState(() {
                      _durationMinutes = newValue;
                    });
                  }),
                ),
                if (durationMinutesErr != null &&
                    durationMinutesErr!.isNotEmpty)
                  errorMessage(durationMinutesErr!),
                SizedBox(
                  height: 10.h,
                ),
                labelTitle(context, 'Flight Date (Month)'),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  child: inputTimeStr(
                      'Select Flight Month',
                      durationMonthErr,
                      durationMonth_f,
                      durationMonthList,
                      _durationMonth, (String? newValue) {
                    setState(() {
                      _durationMonth = newValue;
                    });
                  }),
                ),
                if (durationMonthErr != null && durationMonthErr!.isNotEmpty)
                  errorMessage(durationMonthErr!),
                SizedBox(
                  height: 10.h,
                ),
                labelTitle(context, 'Flight Date (Day)'),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  child: inputTimeStr(
                      'Select Flight Day',
                      durationDayErr,
                      durationDay_f,
                      durationDayList,
                      _durationDay, (String? newValue) {
                    setState(() {
                      _durationDay = newValue;
                    });
                  }),
                ),
                if (durationDayErr != null && durationDayErr!.isNotEmpty)
                  errorMessage(durationDayErr!),
                SizedBox(
                  height: 10.h,
                ),
                labelTitle(context, 'Departure Time (Hours)'),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  child: inputTimeNum(
                      'Select Departure Hour',
                      departureHourErr,
                      departureHour_f,
                      departureHourList,
                      _departureHour, (String? newValue) {
                    setState(() {
                      _departureHour = newValue;
                    });
                  }),
                ),
                if (departureHourErr != null && departureHourErr!.isNotEmpty)
                  errorMessage(departureHourErr!),
                SizedBox(
                  height: 10.h,
                ),
                labelTitle(context, 'Departure Time (Minutes)'),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  child: inputTimeStr(
                      'Select Departure Minutes',
                      departureMinutesErr,
                      departureMinutes_f,
                      departureMinutesList,
                      _departureMinutes, (String? newValue) {
                    setState(() {
                      _departureMinutes = newValue;
                    });
                  }),
                ),
                if (departureMinutesErr != null &&
                    departureMinutesErr!.isNotEmpty)
                  errorMessage(departureMinutesErr!),
                SizedBox(
                  height: 20.h,
                ),

                submitTicket(),
                SizedBox(
                  height: 30.h,
                ),

                //  {
                //   'from': { departure_country arrival_country flight_time_hrs flight_duration_minutes flight_month flight_day userId departure_time_hrs  departure_time_minutes

                //     'code': "NYC",
                //     'name': "New York City",
                //   },
                //   'to': {
                //     'code': "LND",
                //     'name': "London",
                //   },
                //   'flying_time': "8h 30m",
                //   'date': "1st May",
                //   'depature_time': "8:00am",
                //   'number': 23,
                // },
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector submitTicket() {
    return GestureDetector(
      onTap: handleTicketCreation,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppStyles.cardBlueColor,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Text(
          'Create',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget labelTitle(BuildContext context, String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              color: AppStyles.textWhiteBlack(context),
              fontSize: 12.sp,
              fontWeight: FontWeight.normal),
        ),
        Text(
          ' * ',
          style: TextStyle(
              color: Colors.red,
              fontSize: 10.sp,
              fontWeight: FontWeight.normal),
        ),
        Text(
          '(required)',
          style: TextStyle(
              color: Colors.grey,
              fontSize: 9.sp,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget inputCountry(
    String labelText,
    String? errMsg,
    FocusNode focusNode,
    List<Map<String, String>> countries,
    String? selectedVal,
    Function(String?) onValueChanged,
  ) {
    return Container(
      height: 45.h,
      child: DropdownButtonFormField(
        style: TextStyle(
            fontSize: 10.sp, color: AppStyles.textWhiteBlack(context)),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 10.sp,
                color: errMsg != null && errMsg!.isNotEmpty
                    ? Colors.red
                    : AppStyles.cardBlueColor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: errMsg != null && errMsg!.isNotEmpty
                        ? Colors.red
                        : AppStyles.cardBlueColor)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: focusNode.hasFocus
                      ? AppStyles.cardBlueColor
                      : Colors.grey),
            )),
        focusNode: focusNode,
        items: countries.map((country) {
          return DropdownMenuItem(
            value: country['code'] ?? '',
            child: Text(country['name'] ?? ''),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val map is $newValue');
          onValueChanged(newValue);
        },
      ),
    );
  }

  Widget inputTimeNum(
    String labelText,
    String? errMsg,
    FocusNode focusNode,
    List<int> countries,
    String? selectedVal,
    Function(String?) onValueChanged,
  ) {
    return Container(
      height: 45.h,
      child: DropdownButtonFormField(
        style: TextStyle(
            fontSize: 10.sp, color: AppStyles.textWhiteBlack(context)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 10.sp,
              color: errMsg != null && errMsg!.isNotEmpty
                  ? Colors.red
                  : AppStyles.cardBlueColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: errMsg != null && errMsg!.isNotEmpty
                      ? Colors.red
                      : AppStyles.cardBlueColor)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:
                    focusNode.hasFocus ? AppStyles.cardBlueColor : Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        ),
        focusNode: focusNode,
        isDense: true, // Make the dropdown smaller
        isExpanded: false, // Prevent auto-expanding
        items: countries.map((country) {
          return DropdownMenuItem(
            value: country.toString(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                country.toString(),
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val int is $newValue');
          onValueChanged(newValue);
        },
      ),
    );
  }

  Widget inputTimeStr(
    String labelText,
    String? errMsg,
    FocusNode focusNode,
    List<String> countries,
    String? selectedVal,
    Function(String?) onValueChanged,
  ) {
    return Container(
      height: 45.h,
      child: DropdownButtonFormField(
        style: TextStyle(
            fontSize: 10.sp, color: AppStyles.textWhiteBlack(context)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 10.sp,
              color: errMsg != null && errMsg!.isNotEmpty
                  ? Colors.red
                  : AppStyles.cardBlueColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: errMsg != null && errMsg!.isNotEmpty
                      ? Colors.red
                      : AppStyles.cardBlueColor)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:
                    focusNode.hasFocus ? AppStyles.cardBlueColor : Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        ),
        focusNode: focusNode,
        isDense: true, // Make the dropdown smaller
        isExpanded: false, // Prevent auto-expanding
        items: countries.map((country) {
          return DropdownMenuItem(
            value: country,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                country,
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val str is $newValue');
          onValueChanged(newValue);
        },
      ),
    );
  }
}
