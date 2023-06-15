import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';
import '../model/data_model.dart';

class DataRepository {
  final _apiService = NetworkApiServices();
  Future<List<Datum>> dataApi(
    String pageNo,
  ) async {
    dynamic response = await _apiService.getApi(AppUrl.dataApi + pageNo);

    return List<Datum>.from(response["data"].map((x) => Datum.fromJson(x)));
  }
}
