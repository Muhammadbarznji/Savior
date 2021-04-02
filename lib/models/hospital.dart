import 'package:testapp/others/constants.dart';
import 'package:testapp/others/network.dart';
import 'location.dart';

class HospitalData {
  UserLocation userLocation;
  List<Hospital> hospitalList;
  HospitalData();
  getNearbyHospital() async {
    this.hospitalList = List<Hospital>();
    userLocation = UserLocation();

    await userLocation.getLocation().then((value) {
      this.userLocation = value;
    });
    String url;
    int radius = 3000;
/*    for(int i = 0 ; i < 35000; i+=500){
      url =
        'https://api.tomtom.com/search/2/nearbySearch/.JSON?key=$kTomsApiKey&lat=${userLocation.latitude}&lon=${userLocation.longitude}&radius=$radius&limit=50&categorySet=7321';
      if(url != null){
        break;
      }
    }*/
    url =
    'https://api.tomtom.com/search/2/nearbySearch/.JSON?key=$kTomsApiKey&lat=36.2014791&lon=44.0576414&radius=$radius&limit=10&categorySet=7321';

    //print('information about location: '+url);
    NetworkHelper networkHelper = NetworkHelper(url);
    var data;
    await networkHelper.getData().then((value) {
      data = value;
    });
    var hospitals = data['results'];
    this.hospitalList = [];
    for (var h in hospitals) {
      String locationUrl = '', placeName = '';
      double locationLat = h['position']['lat'];
      double locationLon = h['position']['lon'];
      String uri =
          'https://api.opencagedata.com/geocode/v1/json?q=$locationLat+$locationLon&key=3f25f5e3f6ee4254bb53b6948c0b8c30';
      NetworkHelper _networkHelper = NetworkHelper(uri);
      var _data = await _networkHelper.getData();
      var hosData = _data['results'][0];
      placeName = hosData['components']['road'];
      locationUrl = hosData['annotations']['OSM']['url'];
      uri =
          'https://api.tomtom.com/routing/1/calculateRoute/${userLocation.latitude},${userLocation.longitude}:$locationLat,$locationLon/json?key=G5IOmgbhnBgevPJeglEK2zGJyYv6TG1Z';
      NetworkHelper _network = NetworkHelper(uri);
      var distanceData = await _network.getData();
      double hospitalDistance =
          distanceData['routes'][0]['summary']['lengthInMeters'] / 1000;

      Hospital hospital = Hospital(h['poi']['name'], h['position']['lat'],
          h['position']['lon'],h['poi']['phone'], locationUrl, placeName, hospitalDistance);

      try {
        this.hospitalList.add(hospital);
      } catch (e) {
        print(e);
      }
    }
    return this;
  }
}

class Hospital {
  String hospitalName, hospitalLocationUrl, hospitalPlace,phoneNumber;
  double hospitalLocationLatitude, hospitalLocationLongitude, hospitalDistance;

  Hospital(this.hospitalName, this.hospitalLocationLatitude,
      this.hospitalLocationLongitude,this.phoneNumber,
      [this.hospitalLocationUrl, this.hospitalPlace, this.hospitalDistance]);
}
