import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace/controller/getcontroller.dart';
import 'package:pace/core/constants.dart';
import 'package:pace/db/model.dart';
import 'package:pace/presentation/newspage.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final getcontroller = Get.put(Newscontroller());

  @override
  Widget build(BuildContext context) {
    print('main builder');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kappbarbackgroundcolor,
          title: const Text(
            'HEADLINES',
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 29,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
            valueListenable: getcontroller.newsnotifier,
            builder:
                (BuildContext ctx, List<Newsmodel> newnewslist, Widget? child) {
              return newnewslist.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                      color: whitecolor,
                    ))
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        // Timer.periodic(const Duration(milliseconds: 1000), (timer) {
                        getcontroller.addnewsdata(index);
                        // }
                        // );

                        final hivedata = newnewslist[index];
                        final hivesourse = hivedata.sourse;
                        final hiveimgurl = hivedata.imgurl;
                        final hivedate = hivedata.date;
                        final hivedescription = hivedata.description;
                        final hivenewstitle = hivedata.newstitle;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: GestureDetector(
                              onTap: () => Get.to(
                                    () => (Newspage(
                                      imgurl: hiveimgurl,
                                      newstitle: hivenewstitle,
                                      source: hivesourse,
                                      description: hivedescription,
                                      Date: hivedate,
                                    )),
                                  ),
                              child: Newscardwidget(
                                newstitle: hivenewstitle,
                                source: hivesourse,
                                imgurl: hiveimgurl,
                                date: hivedate,
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox();
                      },
                      itemCount:
                          newnewslist.length < 40 ? newnewslist.length : 40);
            }));
  }
}

class Newscardwidget extends StatelessWidget {
  final String newstitle;
  final String source;
  final String imgurl;
  final String date;

  const Newscardwidget(
      {Key? key,
      required this.newstitle,
      required this.source,
      required this.imgurl,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 190,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 0.1,
              ), //BoxShadow
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: imgurl),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, .3, 0.6, 0.9],
              colors: [
                const Color(0xffffff),
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9)
              ],
            ),
          ),
          height: 190,
          width: double.maxFinite,
          child: Column(
            children: [
              const Spacer(),
              Text(
                newstitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20, color: ktitletextcolor, fontFamily: 'roboto'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  children: [
                    Text(
                      source ?? '',
                      style: TextStyle(
                          fontSize: 12,
                          color: ktitletextcolor,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(date,
                        style: TextStyle(
                            fontSize: 12,
                            color: ktimetextcolor,
                            fontFamily: 'roboto'))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
