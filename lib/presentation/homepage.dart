import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pace/controller/getcontroller.dart';
import 'package:pace/core/constants.dart';
import 'package:pace/presentation/newspage.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final getcontroller = Get.put(Newscontroller());

  @override
  Widget build(BuildContext context) {
    getcontroller.fetchdata;
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
      body: GetBuilder<Newscontroller>(builder: (getdata) {
        return getdata.newslist.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: whitecolor,
              ))
            : ListView.separated(
                itemBuilder: (context, index) {
                  final data = getdata.newslist[index];
                  final title = data['title'];
                  final source = data['source']['name'];
                  final imgurl = data['urlToImage'];
                  final description = data['description'];
                  final String publishedat = data['publishedAt'];
                  final date = publishedat.split('T')[0];
                  print(date);

                  // log(title.toString());
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    child: GestureDetector(
                        onTap: () => Get.to(() => (Newspage(
                              imgurl: imgurl,
                              newstitle: title,
                              source: source,
                              description: description,
                              Date: date,
                            ))),
                        child: Newscardwidget(
                          newstitle: title,
                          source: source,
                          imgurl: imgurl,
                          date: date,
                        )),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox();
                },
                itemCount: getcontroller.newslist.length);
      }),
    );
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imgurl),
            ),
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
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, .3, 0.6, 0.9],
              colors: [
                Color(0xffffff),
                Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                Color.fromARGB(255, 0, 0, 0).withOpacity(0.9)
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
