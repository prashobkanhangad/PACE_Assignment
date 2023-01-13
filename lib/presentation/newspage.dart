import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pace/core/constants.dart';

class Newspage extends StatelessWidget {
  final String newstitle;
  final String source;
  final String imgurl;
  final String description;
  final String Date;
  const Newspage(
      {super.key,
      required this.newstitle,
      required this.source,
      required this.imgurl,
      required this.description,
      required this.Date});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: screensize.width,
              height: screensize.height,
              // color: Color.fromARGB(255, 23, 18, 2),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(imgurl),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.4, 0.6, 0.9],
                  colors: [
                    Color(0xffffff),
                    Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                    Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                    Color.fromARGB(255, 0, 0, 0)
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                        height: 42,
                        width: 42,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 21,
                              backgroundColor:
                                  const Color(0x000000).withOpacity(0.2),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: ktitletextcolor,
                                )),
                          ],
                        )),
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          newstitle,
                          style: TextStyle(
                              fontSize: 29,
                              color: ktitletextcolor,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Row(
                          children: [
                            Text(
                              source,
                              style: TextStyle(
                                fontSize: 20,
                                color: ktimetextcolor,
                                fontFamily: 'roboto',
                              ),
                            ),
                            Spacer(),
                            Text(
                              Date,
                              style: TextStyle(
                                fontSize: 20,
                                color: ktimetextcolor,
                                fontFamily: 'roboto',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          description ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: ksubtitletextcolor,
                            fontFamily: 'roboto',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
