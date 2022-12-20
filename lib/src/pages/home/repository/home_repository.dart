import '../../../const/endpoint.dart';
import '../../../service/provider_manager.dart';

class HomeRespository {
  final HttpManager _httpManager = HttpManager();
  getAllCategories() async {
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.getAllCategoria,
        metod: HttpMetod.post,
      );
      if (result['result'] != null) {
        //Lista
      } else {
        //Algo de errado nao esta certo !
      }
    } catch (e) {}
  }
}
