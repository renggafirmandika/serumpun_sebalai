import 'package:flutter/material.dart';
import 'package:serumpun_sebalai/models/berita.dart';
import 'package:serumpun_sebalai/page/berita_tile.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
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
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color(0xFF5b8fcb),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
