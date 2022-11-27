String authErrorString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email ou senha inválidos';
    default:
      return 'Um erro infinito';
  }
}
