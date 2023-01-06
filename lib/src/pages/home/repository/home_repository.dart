import 'package:sacolao_de_frutas/src/models/categoria_model.dart';

import '../../../const/endpoint.dart';
import '../../../service/provider_manager.dart';
import '../result/home_result.dart';

//Parei aqui, na aula 95 e minuro 9:38
class HomeRespository {
  final HttpManager _httpManager = HttpManager();
  Future<HomeResult<CategoryModel>> getAllCategories() async {
    try {
      final result = await _httpManager.restRequest(
        url: EndPoints.getAllCategoria,
        metod: HttpMetod.post,
      );
      if (result['result'] != null) {

        List<CategoryModel> data =  
        ( List<Map<String,dynamic>>.from(result['result'])).
        map(CategoryModel.fromJson).toList();
      
        return HomeResult<CategoryModel>.sucess(data);
        // return HomeResult<CategoryModel>.
      } else {
        //Algo de errado nao esta certo !
        return HomeResult<CategoryModel>.error(
            'Ocorreu um erro inesperado ao recuperar categorias !');
      }
    } catch (e) {
      print('Error: $e');
      return HomeResult<CategoryModel>.error(
          'Ocorreu um erro inesperado ao recuperar categorias ! $e');
    }
  }
}
