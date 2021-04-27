import 'dart:async';
import 'validators.dart';

// Extendemos a classe base do dart, chamada Object, pois ela é a classe raiz absoluta de todas as classes dentro do dart
// Fazendo isso não irá dar erro informando que não podemos usar um with sem antes ter um extend
class Bloc extends Object with Validators { // with Validators informa que deseja usar mixin/trecho de código, mas devemos usar extends quando queremos misturar classe
  
  // Tornar esse código privado fará com que quando alguem instancie essa classe  final Bloc = Bloc()  , ele não consiga ver e editar diretamente nesses campos
  // Obrigando o programador a, se quiser alterar o email, por exemplo, fazer isso usando o getter de email e não diretamente a variável
  // O getter que criamos há algumas linhas abaixo é para isso, para quando não queremos que o programador saiba que essas variáveis do exemplo _login e _senha existam, e para controlá-las obrigatoriamente ele precisa usar o getter
  final _email = StreamController<String>(); 
  final _senha = StreamController<String>();


  // Adicionar dados na Stream
  // 
  // Sempre que alguém pede o stream de email ( _email.stream ) através do getter de email ( get email ), será fornecido o stream de email, mas antes aplicado uma transformação
  Stream<String> get email => _email.stream.transform(validaEmail); // Esse validaEmail vem lá da classe Validators
  Stream<String> get senha => _senha.stream.transform(validaSenha);
  // Sempre que alguém solicita email ou senha daremos a ele esses dados transformados, dessa forma podem ouvir quaisquer eventos ou dados que cheguem ao stream

  // Alterar dados
  Function(String) get alterarEmail => _email.sink.add;
  Function(String) get alterarSenha => _senha.sink.add;

  // botaoSubmit() { // Depois apagar
  //   _email.stream.listen((value) {
  //       emailOk = True;
  //    });
  //   _senha.stream.listen((value) {
  //     senhaOk = True;
  //   });
  // }

  // Não há nada de especial nesse método além do nome por convenção
  // Método responsável pela limpeza e descarte de variáveis e objetos criados pela classe
  dispose() {
    _email.close();
    _senha.close();
  }
}

// Essa abordagem é chamada de Instância Global Única
// Dessa forma, se qualquer outro arquivo do aplicativo importa esse arquivo, ele terá acesso a essa única instância da classe Bloc
// final bloc = Bloc();