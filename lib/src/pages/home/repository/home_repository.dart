import 'package:sacolao_de_frutas/src/models/category_model.dart';

import '../../../const/endpoint.dart';
import '../../../service/provider_manager.dart';
import '../result/home_result.dart';

class HomeRespository {
  final HttpManager _httpManager = HttpManager();
  getAllCategories() async {
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.getAllCategoria,
        metod: HttpMetod.post,
      );
      if (result['result'] != null) {
        List<CategoryModel> data =
            (result['result'] as List<Map<String, dynamic>>)
                .map(CategoryModel.fromJson)
                .toList();

        return HomeResult<CategoryModel>.sucess(data);
      } else {
        //Algo de errado nao esta certo !
        return HomeResult<CategoryModel>.error(
            'Ocorreu um erro inesperado ao recuperar categorias !');
      }
    } catch (e) {}
  }
}
