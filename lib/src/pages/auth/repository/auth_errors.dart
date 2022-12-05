String authErrorString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email ou senha inválidos';
    case 'Invalid session token':
      return 'Token expirado ou invalido !';
    case 'INVALID_TOKEN':
      return 'é necessário informar um token';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido !';
    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido !';
    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: nOME inválido !';
    case 'INVALID_DATA':
      return 'Ocorreu um erro ao cadastrar usuário: Informacôes inválidas !';
    default:
      return 'Um erro infinito';
  }
}
