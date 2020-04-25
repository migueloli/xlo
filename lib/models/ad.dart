import 'address.dart';

class Ad {

  List<dynamic> images;
  String title;
  String description;
  Address address;
  num price;
  bool hidePhone;

  @override
  String toString() => '$images, $title, $description, $address, $price, $hidePhone';

}