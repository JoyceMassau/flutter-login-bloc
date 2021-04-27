import 'dart:async'; // Transformadores de Stream são uma classe que faz parte do dart async

class Validators {

  // atribui a validação a uma variável da classe em lugar de criar uma função validando e ter que chamá-la toda vez
  final validaEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('Insira um email válido');
      }
    },
  );

  // No transformador podemos passar os tipos para entrada / saída de dados <String, String>
  final validaSenha = StreamTransformer<String, String>.fromHandlers(
    handleData: (senha, sink) {
      if (senha == null) {
        sink.addError('Campo obrigatório');
      } else {
        sink.add(senha);
      }
    },
  );
}