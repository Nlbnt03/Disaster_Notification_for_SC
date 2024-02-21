class Disaster
{
  String name;
  double latitude;
  double longitude;
  String time;
  String id;

  Disaster(this.name, this.latitude, this.longitude, this.time, this.id);


  factory Disaster.fromJson(String key,Map<dynamic,dynamic> json)
  {
    return Disaster(json["name"] as String, json["latitude"] as double, json["longitude"] as double, json["time"] as String, key);
  }
}