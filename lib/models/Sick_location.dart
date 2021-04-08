import 'package:testapp/others/constants.dart';
import 'package:testapp/others/network.dart';

import 'location.dart';

class SickLocation {
  String address, url;
  UserLocation location;

  SickLocation();

  getLocationData() async {
    location = UserLocation(longitude: 0, latitude: 0);
    await location.getLocation().then((value) {
      location = value;
    });
    String uri =
        'https://api.opencagedata.com/geocode/v1/json?q=${location.latitude}+${location.longitude}&key=$kOpenCageApiKey';
    NetworkHelper networkHelper = NetworkHelper(uri);
    var data;
    await networkHelper.getData().then((value) {
      data = value;
    });
    this.url = data['results'][0]['annotations']['OSM']['url'];
    this.address = data['results'][0]['formatted'];
    return this;
  }
}
