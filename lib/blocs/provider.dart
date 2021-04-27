import 'package:bloooc/blocs/bloc.dart';
import 'package:flutter/cupertino.dart';

// Classe base para widgets que propagam informações de forma na árvore
// Quando usamos "InheritedWidget" obrigatoriamente precisamos notificar a mudança, criando um "updateShouldNotify"
class Provider extends InheritedWidget {
  final bloc = Bloc();

  // Para assegurar que esse provider vai aceitar um widget filho que aparecerá debaixo de si, definimos o construtor
  Provider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true; //O (_) indica que vou receber um argumento, mas não me importa saber que argumento é esse


  // Se não passamos como "BuildContext", ao passar o cursor sobre context temos que é do tipo dynamic
  // Se passarmos o "BuildContext" conseguimos pegar exatamente o tipo do contexto
  static Bloc of(BuildContext context) { 

    // Essa função faz com que um widget abaixo de outro na hierarquia de widgets consiga controlar o widget pai do qual ele herdou
    // E seu widget pai conhece o contexto do widget pai que ele herdou e assim sucessivamente até encontrar um widget de Provider
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).bloc;
    // return context.dependOnInheritedWidgetOfExactType<Provider>().bloc;
  }
}