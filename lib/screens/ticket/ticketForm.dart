import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/resources/time.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Ticketform extends StatefulWidget {
  const Ticketform({super.key});

  @override
  State<Ticketform> createState() => _TicketformState();
}

class _TicketformState extends State<Ticketform> {
  bool isBtnClicked = false;
  String? ticketId;
  // received the ticket provider after calling it from the init state
  Ticketprovider? ticketProvider;
  // received the user provider after calling it from the init state
  UserProvider? userProvider;
  String myselectedCountry = '';
  String myselectedArrivalCountry = '';
  String mydurationMonth = '';
  String mydurationHour = '';
  String mydurationMinutes = '';
  String mydurationDay = '';
  String mydepartureHour = '';
  String mydepartureMinutes = '';

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

  TextEditingController _pilot = TextEditingController();
  FocusNode pilot_f = FocusNode();
  String? pilotErr;

  TextEditingController _passport = TextEditingController();
  FocusNode passport_f = FocusNode();
  String? passportErr;

  TextEditingController _ticketNo = TextEditingController();
  FocusNode ticketNo_f = FocusNode();
  String? ticketNoErr;

  TextEditingController _bookingNo = TextEditingController();
  FocusNode bookingNo_f = FocusNode();
  String? bookingNoErr;

  TextEditingController _paymentMethod = TextEditingController();
  FocusNode paymentMethod_f = FocusNode();
  String? paymentMethodErr;

  TextEditingController _price = TextEditingController();
  FocusNode price_f = FocusNode();
  String? priceErr;

  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
        userProvider = Provider.of<UserProvider>(context, listen: false);
      });
    });

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

    pilot_f.addListener(() {
      if (!pilot_f.hasFocus) {
        validatePilot();
      }
    });

    passport_f.addListener(() {
      if (!passport_f.hasFocus) {
        validatePassport();
      }
    });

    ticketNo_f.addListener(() {
      if (!ticketNo_f.hasFocus) {
        validateTicketNo();
      }
    });

    bookingNo_f.addListener(() {
      if (!bookingNo_f.hasFocus) {
        validateBookingNo();
      }
    });

    paymentMethod_f.addListener(() {
      if (!paymentMethod_f.hasFocus) {
        validatePaymentMethod();
      }
    });

    price_f.addListener(() {
      if (!price_f.hasFocus) {
        validatePrice();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      ticketId = args["ticketId"];

      if (ticketId != null) {
        final allTickets = context.watch<Ticketprovider>().tickets;

        ParseObject? findTicket = allTickets.firstWhere(
            (ticket) => ticket.get<String>("objectId") == ticketId, orElse: () {
          throw Exception("Ticket not found");
        });

        final currentTicket = findTicket.toJson();
        print(
            'the ticket that needs update is: $currentTicket, the ticketId is $ticketId');

        if (currentTicket != null) {
          myselectedCountry = currentTicket['departure_country'];
          myselectedArrivalCountry = currentTicket['arrival_country'];
          mydurationMonth = currentTicket['flight_month'] ?? '';
          mydurationHour = currentTicket['flight_duration_hrs'] ?? '';
          mydurationMinutes = currentTicket['flight_duration_minutes'] ?? '';
          mydurationDay = currentTicket['flight_day'] ?? '';
          mydepartureHour = currentTicket['departure_time_hrs'] ?? '';
          mydepartureMinutes = currentTicket['departure_time_minutes'] ?? '';
          _pilot.text = currentTicket['pilot'] ?? '';
          _passport.text = currentTicket['passport'] ?? '';
          _ticketNo.text = currentTicket['ticketNo'] ?? '';
          _bookingNo.text = currentTicket['bookingNo'] ?? '';
          _paymentMethod.text = currentTicket['paymentMethod'] ?? '';
          _price.text = currentTicket['price'] ?? '';
          print('updated departure country is $_durationMonth');
        }
      }
    }
  }

  void validatePrice() {
    final priceText = _price.text;
    if (priceText.isEmpty) {
      setState(() {
        priceErr = 'Price is required';
      });
    } else {
      setState(() {
        priceErr = null;
      });
    }
  }

  void validatePaymentMethod() {
    final paymentMethod = _paymentMethod.text;
    if (paymentMethod.isEmpty) {
      setState(() {
        paymentMethodErr = 'Payment Method is required';
      });
    } else {
      setState(() {
        paymentMethodErr = null;
      });
    }
  }

  void validateBookingNo() {
    final bookingNo = _bookingNo.text;
    if (bookingNo.isEmpty) {
      setState(() {
        bookingNoErr = 'Booking No is required';
      });
    } else {
      setState(() {
        bookingNoErr = null;
      });
    }
  }

  void validateTicketNo() {
    final ticketNo = _ticketNo.text;
    if (ticketNo.isEmpty) {
      setState(() {
        ticketNoErr = 'Ticket is required';
      });
    } else {
      setState(() {
        ticketNoErr = null;
      });
    }
  }

  void validatePassport() {
    final passport = _passport.text;
    if (passport.isEmpty) {
      setState(() {
        passportErr = 'Passport is required';
      });
    } else {
      setState(() {
        passportErr = null;
      });
    }
  }

  void validatePilot() {
    final pilot = _pilot.text;
    if (pilot.isEmpty) {
      setState(() {
        pilotErr = 'Pilot is required';
      });
    } else {
      setState(() {
        pilotErr = null;
      });
    }
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
    setState(() {
      isBtnClicked = true;
    });
    try {
      await ticketProvider!.createTicket(
          departure_country: _selectedCountry!,
          arrival_country: _selectedArrivalCountry!,
          flight_duration_hrs: _durationHour!,
          flight_duration_minutes: _durationMinutes!,
          flight_month: _durationMonth!,
          flight_day: _durationDay!,
          userId: userId!,
          departure_time_hrs: _departureHour!,
          departure_time_minutes: _departureMinutes!,
          pilot: _pilot.text,
          passport: _passport.text,
          ticketNo: _ticketNo.text,
          bookingNo: _bookingNo.text,
          paymentMethod: _paymentMethod.text,
          price: _price.text,
          context: context);
    } catch (e) {
      print('Error creating ticket $e');
      setState(() {
        isBtnClicked = false;
      });
    }
    setState(() {
      isBtnClicked = false;
    });
  }

  void updateTicket() async {
    setState(() {
      isBtnClicked = true;
    });
    try {
      setState(() {
        _selectedCountry = _selectedCountry ?? myselectedCountry;
        _selectedArrivalCountry =
            _selectedArrivalCountry ?? myselectedArrivalCountry;
        _durationHour = _durationHour ?? mydurationHour;
        _durationMinutes = _durationMinutes ?? mydurationMinutes;
        _durationMonth = _durationMonth ?? mydurationMonth;
        _durationDay = _durationDay ?? mydurationDay;
        _departureHour = _departureHour ?? mydepartureHour;
        _departureMinutes = _departureMinutes ?? mydepartureMinutes;
      });
      print(
          'my new selected country $_selectedCountry $_selectedArrivalCountry $_durationHour $_durationMinutes $_durationMonth $_durationDay $_departureHour $_departureMinutes');
      await ticketProvider!.updateTicket(
          departure_country: _selectedCountry!,
          arrival_country: _selectedArrivalCountry!,
          flight_duration_hrs: _durationHour!,
          flight_duration_minutes: _durationMinutes!,
          flight_month: _durationMonth!,
          flight_day: _durationDay!,
          ticketId: ticketId!,
          userId: userId!,
          departure_time_hrs: _departureHour!,
          departure_time_minutes: _departureMinutes!,
          pilot: _pilot.text,
          passport: _passport.text,
          ticketNo: _ticketNo.text,
          bookingNo: _bookingNo.text,
          paymentMethod: _paymentMethod.text,
          price: _price.text,
          context: context);
    } catch (e) {
      print('Error creating ticket $e');
      setState(() {
        isBtnClicked = false;
      });
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
    pilot_f.dispose();
    passport_f.dispose();
    ticketNo_f.dispose();
    bookingNo_f.dispose();
    paymentMethod_f.dispose();
    price_f.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = userProvider!.currentUser;

    final String user_id = user?.get('objectId');
    userId = user_id;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      appBar: AppBar(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        actions: const [
          HomeNavBtn(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        ticketId == null ? 'Create Ticket' : 'Edit Ticket',
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
                    ticketId == null
                        ? inputCountryWithoutId(
                            'choose depature country',
                            selectedCountryErr,
                            selectedCountry_f,
                            _countries,
                            _selectedCountry,
                            (String? newValue) {
                              setState(() {
                                _selectedCountry = newValue;
                                print('_selectedCountry is $_selectedCountry');
                              });
                            },
                          )
                        : inputCountry(
                            myselectedCountry,
                            'choose depature country',
                            selectedCountryErr,
                            selectedCountry_f,
                            _countries,
                            _selectedCountry,
                            (String? newValue) {
                              // Callback to update _departureMinutes
                              setState(() {
                                _selectedCountry = newValue;
                                print('_selectedCountry is $_selectedCountry');
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
                    ticketId == null
                        ? inputCountryWithoutId(
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
                          )
                        : inputCountry(
                            myselectedArrivalCountry,
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
                    ticketId == null
                        ? Container(
                            child: inputTimeNumWithoutId(
                                'Hours Expected',
                                durationHourErr,
                                durationHour_f,
                                durationHourList,
                                _durationHour, (String? newValue) {
                              setState(() {
                                _durationHour = newValue;
                              });
                            }),
                          )
                        : Container(
                            child: inputTimeNum(
                                mydurationHour,
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
                    ticketId == null
                        ? Container(
                            child: inputTimeNumWithoutId(
                                'Minutes Expected',
                                durationMinutesErr,
                                durationMinutes_f,
                                durationMinutesList,
                                _durationMinutes, (String? newValue) {
                              setState(() {
                                _durationMinutes = newValue;
                              });
                            }),
                          )
                        : Container(
                            child: inputTimeNum(
                                mydurationMinutes,
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
                    ticketId == null
                        ? Container(
                            child: inputTimeStrWithoutId(
                                'Select Flight Month',
                                durationMonthErr,
                                durationMonth_f,
                                durationMonthList,
                                _durationMonth, (String? newValue) {
                              setState(() {
                                _durationMonth = newValue;
                              });
                            }),
                          )
                        : Container(
                            child: inputTimeStr(
                                mydurationMonth,
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
                    if (durationMonthErr != null &&
                        durationMonthErr!.isNotEmpty)
                      errorMessage(durationMonthErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Flight Date (Day)'),

                    SizedBox(
                      height: 5.h,
                    ),
                    ticketId == null
                        ? Container(
                            child: inputTimeStrWithoutId(
                                'Select Flight Day',
                                durationDayErr,
                                durationDay_f,
                                durationDayList,
                                _durationDay, (String? newValue) {
                              setState(() {
                                _durationDay = newValue;
                              });
                            }),
                          )
                        : Container(
                            child: inputTimeStr(
                                mydurationDay,
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
                    ticketId == null
                        ? Container(
                            child: inputTimeNumWithoutId(
                                'Select Departure Hour',
                                departureHourErr,
                                departureHour_f,
                                departureHourList,
                                _departureHour, (String? newValue) {
                              setState(() {
                                _departureHour = newValue;
                              });
                            }),
                          )
                        : Container(
                            child: inputTimeNum(
                                mydepartureHour,
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
                    if (departureHourErr != null &&
                        departureHourErr!.isNotEmpty)
                      errorMessage(departureHourErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Departure Time (Minutes)'),

                    SizedBox(
                      height: 5.h,
                    ),
                    ticketId == null
                        ? Container(
                            child: inputTimeStrWithoutId(
                                'Select Departure Minutes',
                                departureMinutesErr,
                                departureMinutes_f,
                                departureMinutesList,
                                _departureMinutes, (String? newValue) {
                              setState(() {
                                _departureMinutes = newValue;
                              });
                            }),
                          )
                        : Container(
                            child: inputTimeStr(
                                mydepartureMinutes,
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
                      height: 10.h,
                    ),
                    labelTitle(context, 'Pilot Name'),
                    inputs(_pilot, pilot_f, Icons.person_off, 'Pilot Name',
                        pilotErr != null ? true : false, 'Pilot Name', false),
                    if (pilotErr != null) errorMessage(pilotErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Passport No'),
                    inputs(
                        _passport,
                        passport_f,
                        Icons.book,
                        'Passport No',
                        passportErr != null ? true : false,
                        'Passport No',
                        true),
                    if (passportErr != null) errorMessage(passportErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Ticket No'),
                    inputs(
                        _ticketNo,
                        ticketNo_f,
                        Icons.calendar_view_day_sharp,
                        'Ticket No',
                        ticketNoErr != null ? true : false,
                        'Ticket No',
                        true),
                    if (ticketNoErr != null) errorMessage(ticketNoErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Booking No'),
                    inputs(
                        _bookingNo,
                        bookingNo_f,
                        Icons.calendar_view_day_sharp,
                        'Booking No',
                        bookingNoErr != null ? true : false,
                        'Booking No',
                        false,
                        maxLength: 6),
                    if (bookingNoErr != null) errorMessage(bookingNoErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Payment Method'),
                    inputs(
                        _paymentMethod,
                        paymentMethod_f,
                        Icons.calendar_view_day,
                        'Payment Method',
                        paymentMethodErr != null ? true : false,
                        'Payment Method',
                        true,
                        maxLength: 4),
                    if (paymentMethodErr != null)
                      errorMessage(paymentMethodErr!),
                    SizedBox(
                      height: 10.h,
                    ),
                    labelTitle(context, 'Price'),
                    inputs(
                        _price,
                        price_f,
                        Icons.price_change_outlined,
                        'Price',
                        priceErr != null ? true : false,
                        'Price',
                        true),
                    if (priceErr != null) errorMessage(priceErr!),
                    SizedBox(
                      height: 20.h,
                    ),
                    //pilot passport, ticketNo, bookingNo, paymentMethod, price

                    submitTicket(),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector submitTicket() {
    return GestureDetector(
      onTap: ticketId == null ? handleTicketCreation : updateTicket,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppStyles.cardBlueColor,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: isBtnClicked
            ? Container(
                height: 15.h,
                width: 15.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                ticketId == null ? 'Create' : 'Update',
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
    String initialText,
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
        value: selectedVal ?? initialText,
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
            child: Container(
                color: AppStyles.defaultBackGroundColor(context),
                child: Text(country['name'] ?? '')),
          );
        }).toList(),
        onChanged: (String? newValue) {
          onValueChanged(newValue);
          print(
              'new changed val map is $newValue the country is $_selectedCountry $selectedVal ');
        },
      ),
    );
  }

  Widget inputCountryWithoutId(
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
            child: Container(
                color: AppStyles.defaultBackGroundColor(context),
                child: Text(country['name'] ?? '')),
          );
        }).toList(),
        onChanged: (String? newValue) {
          onValueChanged(newValue);
          print(
              'new changed val map is $newValue the country is $_selectedCountry $selectedVal ');
        },
      ),
    );
  }

  Widget inputTimeNum(
    String initialText,
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
        // value: selectedVal == '' ? initialText: selectedVal,
        value: selectedVal ?? initialText,
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
              child: Container(
                color: AppStyles.defaultBackGroundColor(context),
                child: Text(
                  country.toString(),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val int is $newValue, $selectedVal ');
          onValueChanged(newValue);
        },
      ),
    );
  }

  Widget inputTimeNumWithoutId(
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
              child: Container(
                color: AppStyles.defaultBackGroundColor(context),
                child: Text(
                  country.toString(),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val int is $newValue, $selectedVal ');
          onValueChanged(newValue);
        },
      ),
    );
  }

  Widget inputTimeStr(
    String initialText,
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
        value: selectedVal ?? initialText,
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
              child: Container(
                color: AppStyles.defaultBackGroundColor(context),
                child: Text(
                  country,
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val str is $newValue $selectedVal ');
          onValueChanged(newValue);
        },
      ),
    );
  }

  Widget inputTimeStrWithoutId(
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
              child: Container(
                color: AppStyles.defaultBackGroundColor(context),
                child: Text(
                  country,
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print('new changed val str is $newValue $selectedVal ');
          onValueChanged(newValue);
        },
      ),
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
      {int maxLength = 9}) {
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
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppStyles.defaultBackGroundColor(context),
                  ),
                  child: TextField(
                    controller: controller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(maxLength)
                    ],
                    keyboardType: useNum ? TextInputType.number : null,
                    focusNode: focus,
                    onChanged: (value) {
                      if (focusname == 'Email') {
                        //pilot passport, ticketNo, bookingNo, paymentMethod, price

                        validatePassport();
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
                        contentPadding: EdgeInsets.symmetric(vertical: 9.h),
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
