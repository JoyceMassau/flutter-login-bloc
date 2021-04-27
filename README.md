# flutter-login-bloc


#### Erro: The argument type 'Object?' can't be assigned to the parameter type 'String?'

**Referência:** https://stackoverflow.com/questions/65302065/turn-off-null-safety-for-previous-flutter-project
**Solução:** Alterar no pubspec.yaml para uma versão de sdk anterior à 2.12

Se estava
```dart
sdk: ">=2.12.0 <3.0.0"
```

Alterar para
```dart
sdk: ">=2.11.0 <3.0.0"
```


#### Instância Global Única

Essa abordagem, de no arquivo bloc.dart exportar uma instância, é chamada de Instância Global Única
Dessa forma, se qualquer outro arquivo do aplicativo importa esse arquivo, ele terá acesso a essa única instância da classe Bloc

```dart
class Bloc extends Object with Validators { 
 ...
}

final bloc = Bloc();
```


#### Erro: Missing concrete implementation of 'InheritedWidget.updateShouldNotify'

**Referência:** https://youtu.be/UQt7qVzc0P0?t=88

"InheritedWidget" é a classe base para widgets que propagam informações de forma na árvore. Quando usamos isto, obrigatoriamente precisamos notificar a mudança, criando um "updateShouldNotify"

```dart
bool updateShouldNotify(_) => true;
```


#### Erro: The method 'inheritFromWidgetOfExactType' isn't defined for the type 'BuildContext'

**Referência:**

- https://stackoverflow.com/questions/65749767/error-the-method-inheritfromwidgetofexacttype-isnt-defined-for-the-class-bu
- https://www.youtube.com/watch?v=UQt7qVzc0P0&list=PLlJ4oeCH4sLcP_nyGl1gcu3UlazRldK9E&index=15

Esse método foi descontinuado nas versões mais recentes do Flutter, sendo substituído pelo dependOnInheritedWidgetOfExactType


#### O contexto do widget e funcionamento do Provider

Essa função faz com que um widget abaixo de outro na hierarquia de widgets consiga controlar o widget pai do qual ele herdou. E seu widget pai conhece o contexto do widget pai que ele herdou e assim sucessivamente até encontrar um widget de Provider

```dart
static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).bloc;
}
```

Cada Widget dentro tem seu contexto, exemplo: 

- A tela de login tem um contexto e conhece o seu próprio contexto;
- O widget de Container tem um contexto e conhece o seu próprio contexto e o contexto anterior, acima dele na hierarquia;
- O widget de Column tem um contexto e conhece o seu próprio contexto e o contexto anterior, acima dele na hierarquia;
- Cada botão tem seus próprios contextos e conhece também o contexto anterior, acima dele na hierarquia.

 
#### Usando o Provider em todo o App e não apenas na tela de Login

Para poder utilizar o provider em todo o app é necessário embrulhar o widget de materialApp nele

Antes

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
```

Depois

```dart
class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Provider(
            child: MaterialApp(
                title: 'Login',
                home: Scaffold(
                    body: LoginScreen(),
                ),
            ),
        );
    }
}
```


#### Alterando a Instância Global Única

**Referência:** https://youtu.be/k0vVN8CS0hk?t=152

Antes, ao final da classe Bloc, dentro do arquivo bloc.dart, passávamos uma instância global única. Todavia, vamos apagar essa linha e fazer de outra forma

Ao apagar, começarão a dar alguns erros no arquivo login_screen.dart onde se utilizava a instância. Neste arquivo, vamos escrever, passando como parâmetro o contexto do widget da tela de Login:

```dart
class LoginScreen extends StatelessWidget {
    Widget build(BuildContext context) {
        final bloc = Provider.of(context);
    }
}
```

O provider tem uma função estática que, ao passarmos o contexto do widget como fizemos, obtemos as informações da hierarquia de widgets da instância mais próxima de um provider

```dart
class Provider extends InheritedWidget {
    ...
    static Bloc of(BuildContext context) { 
        return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).bloc;
    }
}
```

Para utilizar esse provider para atualizar os campos do formulário precisamos estar cientes de que em muitos lugares o contexto está disponível dentro do método de construção do widget (Build). Então, só aqui dentro podemos realmente usar esse contexto para obter a referência ao bloc
Todavia, não precisamos do bloc dentro do método de Build. Precisamos dele dentro do campo de e-mail e de senha para através disso alcançar a hierarquia e passar para outras partes do widget que precisem de acesso a ele. Para isso, podemos passar como parâmetro dos widgets, passando o tipo como Bloc

```dart
class LoginScreen extends StatelessWidget {
    Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
            children: [
                campoEmail(bloc),
                campoSenha(bloc),
                botaoSubmit(),
            ],
        ),
    );
}

  Widget campoEmail(Bloc bloc) {
    ...
  }

  Widget campoSenha(Bloc bloc) {
    ...
  }
}
```

#### Usando rxdart

Poderíamos em lugar dele usar o package Async ou desenvolver uma solução personalizada, porém essas abordagens tem maior complexidade ou não entregam tudo o que seja necessário ao Aoo
O Rxdart tem funções auxiliares para realizar exatamente o que precisamos

** Referência:** http://reactivex.io/languages.html