class IPGeolocation {
  String? status;
  String? continent;
  String? continentCode;
  String? country;
  String? countryCode;
  String? region;
  String? regionName;
  String? city;
  String? district;
  String? zip;
  double? lat;
  double? lon;
  String? timezone;
  int? offset;
  String? currency;
  String? isp;
  String? org;
  String? fieldAs;
  String? asname;
  String? reverse;
  bool? mobile;
  bool? proxy;
  bool? hosting;
  String? query;

  IPGeolocation({
     this.status,
     this.continent,
     this.continentCode,
     this.country,
     this.countryCode,
     this.region,
     this.regionName,
     this.city,
     this.district,
     this.zip,
     this.lat,
     this.lon,
     this.timezone,
     this.offset,
     this.currency,
     this.isp,
     this.org,
     this.fieldAs,
     this.asname,
     this.reverse,
     this.mobile,
     this.proxy,
     this.hosting,
    this.query,
  });

  factory IPGeolocation.fromJson(Map<String, dynamic> json) {
    return IPGeolocation(
      status: json['status'],
      continent: json['continent'],
      continentCode: json['continentCode'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionName: json['regionName'],
      city: json['city'],
      district: json['district'],
      zip: json['zip'],
      lat: json['lat']?.toDouble(),
      lon: json['lon']?.toDouble(),
      timezone: json['timezone'],
      offset: json['offset'],
      currency: json['currency'],
      isp: json['isp'],
      org: json['org'],
      fieldAs: json['as'],
      asname: json['asname'],
      reverse: json['reverse'],
      mobile: json['mobile'],
      proxy: json['proxy'],
      hosting: json['hosting'],
      query: json['query'],
    );
  }
}
