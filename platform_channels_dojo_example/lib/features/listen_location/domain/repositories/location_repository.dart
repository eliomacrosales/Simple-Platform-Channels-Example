abstract class LocationRepository {
  Future<void> startLocationGPS();
  Future<void> stopLocationGPS();
  Stream<Map<String, double>> listenChanges();
}
