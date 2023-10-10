import 'package:serumpun_sebalai/models/berita.dart';

class DaftarBerita {
  List<Berita> _daftarBerita = [
    Berita(
      judul:
          'Data BPS, Cabai Rawit Masuk 5 Besar Komoditas Penyumbang Inflasi, Perlu Perhatikan Pasokan',
      imagePath: 'assets/berita2.jpg',
      url:
          'https://bangka.tribunnews.com/2023/07/20/data-bps-cabai-rawit-masuk-5-besar-komoditas-penyumbang-inflasi-perlu-perhatikan-pasokan',
    ),
    Berita(
      judul:
          'Pj Gubernur Suganda: Bazar Hasil Perikanan Sebagai Upaya Pengendalian Inflasi',
      imagePath: 'assets/berita1.jpg',
      url:
          'https://bangka.tribunnews.com/2023/04/15/pj-gubernur-suganda-bazar-hasil-perikanan-sebagai-upaya-pengendalian-inflasi',
    ),
  ];

  DaftarBerita(this._daftarBerita);

  List<Berita> get daftarBerita => _daftarBerita;
}
