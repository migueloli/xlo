import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/ad.dart';

class HomeBloc {

  final BehaviorSubject<String> _searchController = BehaviorSubject<String>();
  Stream<String> get outSearch => _searchController.stream;

  final BehaviorSubject<List<Ad>> _adsController = BehaviorSubject<List<Ad>>.seeded([]);
    Stream<List<Ad>> get outAds => _adsController.stream;

  void setSearch(String search) {
    _searchController.add(search);
  }

  void addAd(Ad ad) {
    _adsController.add(_adsController.value..add(ad));
  }

  void dispose() {
    _searchController.close();
    _adsController.close();
  }

}