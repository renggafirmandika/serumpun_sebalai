import 'package:flutter/material.dart';
//import 'package:serumpun_sebalai/models/daftarberita.dart';
import 'package:serumpun_sebalai/page/berita_tile.dart';
import 'package:serumpun_sebalai/page/chart1.dart';
import 'package:serumpun_sebalai/page/chart2.dart';
import 'package:serumpun_sebalai/page/chart3.dart';
import 'package:serumpun_sebalai/page/chart4.dart';
import 'package:serumpun_sebalai/utils/userSettings.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../models/berita.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => BerandaState();
}

class BerandaState extends State<Beranda> {
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey searchKey = GlobalKey();
  GlobalKey grafikKey = GlobalKey();
  GlobalKey beritaKey = GlobalKey();
  GlobalKey settingsKey = GlobalKey();
  GlobalKey navigationKey = GlobalKey();

  final _controller = PageController();
  //ZoomPanBehavior? _zoomPanBehavior;

  List<Berita> daftarBerita = [
    Berita(
      judul:
          'Data BPS, Cabai Rawit Masuk 5 Besar Komoditas Penyumbang Inflasi, Perlu Perhatikan Pasokan',
      imagePath: 'assets/berita2.jpg',
      url:
          'https://bangka.tribunnews.com/2023/07/20/data-bps-cabai-rawit-masuk-5-besar-komoditas-penyumbang-inflasi-perlu-perhatikan-pasokan',
    ),
    Berita(
      judul:
          'Selama Lebaran Harga Bahan Pokok di Babel Stabil, BPS Apresiasi Tim Pengendalian Inflasi Daerah',
      imagePath: 'assets/berita3.jpg',
      url:
          'https://bangka.tribunnews.com/2023/05/03/selama-lebaran-harga-bahan-pokok-di-babel-stabil-bps-apresiasi-tim-pengendalian-inflasi-daerah',
    ),
    Berita(
      judul:
          'Harga Sayur di Pasar Pangkalpinang Naik Pasca Idul Adha, Berikut Rincian Harganya',
      imagePath: 'assets/berita4.jpg',
      url:
          'https://bangka.tribunnews.com/2023/07/03/harga-sayur-di-pasar-pangkalpinang-naik-pasca-idul-adha-berikut-rincian-harganya',
    ),
    Berita(
      judul:
          'Pj Gubernur Suganda: Bazar Hasil Perikanan Sebagai Upaya Pengendalian Inflasi',
      imagePath: 'assets/berita1.jpg',
      url:
          'https://bangka.tribunnews.com/2023/04/15/pj-gubernur-suganda-bazar-hasil-perikanan-sebagai-upaya-pengendalian-inflasi',
    ),
  ];

  @override
  void initState() {
    // _zoomPanBehavior = ZoomPanBehavior(
    //   enablePinching: true,
    //   zoomMode: ZoomMode.x,
    //   enablePanning: true,
    // );
    Future.delayed(const Duration(seconds: 1), () {
      _checkTutorial();
    });
    super.initState();
  }

  _checkTutorial() async {
    var statusWilayah = await UserSettings.getFlagTutorial();
    if (statusWilayah == "") {
      _showTutorialCoachMark();
    }
  }

  void _showTutorialCoachMark() {
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      pulseEnable: false,
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      //search bar
      TargetFocus(
        identify: "search-key",
        keyTarget: searchKey,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return CoachmarkDesc(
                  text:
                      "Anda dapat menggunakan fitur 'Search' untuk mencari data yang Anda butuhkan",
                  onNext: () {
                    controller.next();
                  },
                  onSkip: () {
                    controller.skip();
                  },
                );
              }),
        ],
      ),

      //grafik
      TargetFocus(
        identify: "grafik-key",
        keyTarget: grafikKey,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return CoachmarkDesc(
                  text:
                      "Fitur 'Grafik' menampilkan data terkini dalam bentuk grafik. Swipe untuk melihat grafik data lainnya.",
                  onNext: () {
                    controller.next();
                  },
                  onSkip: () {
                    controller.skip();
                  },
                );
              }),
        ],
      ),

      //berita
      TargetFocus(
        identify: "berita-key",
        keyTarget: beritaKey,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return CoachmarkDesc(
                  text:
                      "Fitur 'Berita' menampilkan berita terkini terkait inflasi yang di-crawl dari berbagai sumber media massa.",
                  next: 'Finish',
                  onNext: () async {
                    controller.next();
                    await UserSettings.setFlagTutorial("1");
                  },
                  onSkip: () {
                    controller.skip();
                  },
                );
              }),
        ],
      ),

      //navbar
      // TargetFocus(
      //   identify: "navigation-key",
      //   keyTarget: navigationKey,
      //   shape: ShapeLightFocus.RRect,
      //   radius: 5,
      //   contents: [
      //     TargetContent(
      //         align: ContentAlign.top,
      //         builder: (context, controller) {
      //           return CoachmarkDesc(
      //             text:
      //                 "Data dan menu lainnya dapat diakses melalui Navigation Bar.",
      //             next: 'Finish',
      //             onNext: () {
      //               controller.next();
      //             },
      //             onSkip: () {
      //               controller.skip();
      //             },
      //           );
      //         }),
      //   ],
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8aa4d5), Color(0xFF6097d0)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Drawer(
            child: Container(
              color: const Color(0xFF87a5d6),
              child: ListView(
                children: const [
                  DrawerHeader(
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: const Text('Beranda'),
        //   backgroundColor: const Color(0xFF5b8fcb),
        // ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Container(
                    key: searchKey,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cari',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color(0xFF5b8fcb),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        key: grafikKey,
                        children: [
                          SizedBox(
                            height: 300,
                            child: PageView(
                              controller: _controller,
                              children: const [
                                Chart1(),
                                Chart2(),
                                Chart4(),
                                Chart3(),
                              ],
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Color(0xFF659dd4),
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          key: beritaKey,
                          height: 200,
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: const Color(0xFF5b8fcb),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Berita Seputar Inflasi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 240,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: ListView.builder(
                                  itemCount: daftarBerita.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    Berita berita = daftarBerita[index];
                                    return BeritaTile(
                                      berita: berita,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc({
    super.key,
    required this.text,
    this.skip = "Skip",
    this.next = "Next",
    this.onSkip,
    this.onNext,
  });

  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;

  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}

class _CoachmarkDescState extends State<CoachmarkDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onSkip,
                child: Text(
                  widget.skip,
                  style: const TextStyle(
                    color: Color(0xFF5b8fcb),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5b8fcb),
                ),
                child: Text(widget.next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
