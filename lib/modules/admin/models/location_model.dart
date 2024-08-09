class Locations {
  final String? country;
  final String? state;
  final String? district;
  final String? city;

  Locations({
    this.country,
    this.state,
    this.district,
    this.city,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      country: json['country'],
      state: json['state'],
      district: json['district'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'state': state,
      'district': district,
      'city': city,
    };
  }
}
