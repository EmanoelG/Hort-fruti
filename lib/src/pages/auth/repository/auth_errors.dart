import '../../../service/error_type.dart';

String authErrorString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return ErrorAppType.invalidCredentials;
    case 'Invalid session token':
      return ErrorAppType.invalidTokenSession;
    case 'INVALID_TOKEN':
      return ErrorAppType.invalidToken;

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido !';
    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido !';
    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: nOME inválido !';
    case 'INVALID_DATA':
      return 'Ocorreu um erro ao cadastrar usuário: Informacôes inválidas !';
    case 'sem conexao de internet':
      return ErrorAppType.notAcessInternet;
    default:
      return 'Um erro ';
  }
}


