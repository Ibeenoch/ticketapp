import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:powerapp/screens/customSvg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(
                  icon: CustomSvg(svgpath: 'assets/icons/direction-alt.svg'),
                ),
                Tab(
                  icon: CustomSvg(svgpath: 'assets/icons/direction-as.svg'),
                ),
                Tab(
                  icon: CustomSvg(svgpath: 'assets/icons/direction-da.svg'),
                )
              ]),
            ),
            body: const TabBarView(children: [
              ParentImageContainer(),
              Text(
                'data Two',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'data Three',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              )
            ]),
          )),
    );
  }
}

//  Scaffold(
//         body: Center(
//       child: Column(
//         children: [ParentImageContainer()],
//       ),
//     ));

class ParentImageContainer extends StatelessWidget {
  const ParentImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 300,
      color: Colors.amber,
      child: Stack(
        children: [
          Center(
            child: Text(
              'child',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(12),
              child: const Text(
                "View More",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Positioned(
          //   top: 20,
          //   left: 0,
          //   child: (FirstLayerImage(img: 'assets/images/lake.jpg')),
          // ),
        ],
      ),
    );
  }
}

class FirstLayerImage extends StatelessWidget {
  FirstLayerImage({super.key, required this.img, this.rounded});

  final String img;
  final String? rounded;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: rounded != null
          ? BorderRadius.circular(double.tryParse(rounded!) ?? 0)
          : BorderRadius.zero,
      child: Image.asset(
        img,
        width: 150,
        height: 80,
        fit: BoxFit.contain,
      ),
    );
  }
}
