import 'package:all_practices/details_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List name = [
    'Nayeem',
    'Anny',
    'Ahnaf',
    'Sabbir',
    'Azad',
    'khushi',
    'Amer Bow Name',
    'Nayeem',
    'Anny',
    'Ahnaf',
    'Sabbir',
    'Azad',
    'khushi',
    'Amer Bow Name',
    'Sabbir',
    'Azad',
    'khushi',
    'Amer Bow Name',
  ];
  List pic = [
    'https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/10/25/22/22/roses-1770165_1280.png',
    'https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/02/17/19/08/lotus-1205631_1280.jpg',
    'https://cdn.pixabay.com/photo/2013/04/03/21/25/flower-100263_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg',
    'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/10/25/22/22/roses-1770165_1280.png',
    'https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/02/17/19/08/lotus-1205631_1280.jpg',
    'https://cdn.pixabay.com/photo/2013/04/03/21/25/flower-100263_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg',
    'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/10/25/22/22/roses-1770165_1280.png',
  ];
  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Product $index"})
          .toList();
  final List<Map> name1 =
      List.generate(100, (index) => {"name": index, "pic": "name$index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid View Page"), centerTitle: true),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: name.length,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.cyan),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.cyan
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  name: name[index],
                                  pic: pic[index],
                                ),

                              ));
                          print("Click Item Name : ${name[index]}");
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child:
                                  Image.network(pic[index], fit: BoxFit.cover),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(name[index]),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          }),

      ///  This is my gried view in flutter
      // body: GridView.builder(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10,
      //       childAspectRatio: 3/2,
      //
      //     ),
      //   itemCount: name.length,
      //   itemBuilder: (context, index) {
      //      return Container(
      //
      //         width: double.infinity,
      //        color: Colors.orange,
      //         child: Card(
      //           elevation: 5,
      //           child: Container(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(25),
      //               color: Colors.white,
      //
      //             ),
      //             child: Column(
      //               children: [
      //                 Text(pic[index],),
      //                 Text(name[index]),
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     },),
    );
  }
}
