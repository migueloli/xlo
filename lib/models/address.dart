class Address {

  String place;
  String district;
  String city;
  String postalCode;
  String federativeUnit;

  Address({
    this.place,
    this.district,
    this.city,
    this.postalCode,
    this.federativeUnit,
  });

  factory Address.fromMap(Map<String, dynamic> map) => Address(
    place: map['logradouro'],
    district: map['bairro'],
    city: map['localidade'],
    postalCode: map['cep'],
    federativeUnit: map['uf'],
  );

  @override
  String toString() {
    return "$place, $district, $city, $postalCode, $federativeUnit";
  }

}