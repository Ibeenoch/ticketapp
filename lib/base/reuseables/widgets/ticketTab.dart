import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

class Tickettab extends StatefulWidget {
  final String leftText;
  final String rightText;

  const Tickettab({super.key, required this.leftText, required this.rightText});

  @override
  State<Tickettab> createState() => _TickettabState();
}

class _TickettabState extends State<Tickettab> {
  bool isLeft = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isLeft = true;
            });
          },
          child: Container(
            width: size.width * 0.44,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: isLeft ? AppStyles.cardBlueColor : Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              widget.leftText,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isLeft ? Colors.white : AppStyles.cardBlueColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isLeft = false;
            });
          },
          child: Container(
            width: size.width * 0.44,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: isLeft ? Colors.white : AppStyles.cardBlueColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Text(
              widget.rightText,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isLeft ? AppStyles.cardBlueColor : Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:powerapp/base/reuseables/styles/App_styles.dart';

// class Tickettab extends StatelessWidget {
//   final String leftText;
//   final String rightText;


//   const Tickettab({super.key, required this.leftText, required this.rightText});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         Container(
//           width: size.width * 0.44,
//           decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   bottomLeft: Radius.circular(12)),
//               color: Colors.white),
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Text(
//             leftText,
//             style: TextStyle(
//                 fontWeight: FontWeight.w500, color: AppStyles.cardBlueColor),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Container(
//           width: size.width * 0.44,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           decoration: BoxDecoration(
//               color: AppStyles.cardBlueColor,
//               borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(12),
//                   bottomRight: Radius.circular(12))),
//           child: Text(
//             rightText,
//             style: const TextStyle(
//                 fontWeight: FontWeight.w500, color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }
