String authErrorString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email ou senha inválidos';
    case 'Invalid session token':
      return 'Token expirado ou invalido !';
    case 'INVALID_TOKEN':
      return 'é necessário informar um token';
    default: //
      return 'Um erro infinito';
  }
}
