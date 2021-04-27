// import 'dart:js';

import 'package:bloooc/blocs/bloc.dart';
import 'package:bloooc/blocs/provider.dart';
import 'package:flutter/material.dart';

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
    return StreamBuilder(
      stream: bloc.email, // Os dados que estamos observando se há mudnaça
      builder: (context,  snapshot) {
        // Aqui criaremos e retornaremos um widget toda vez que o fluxo muda (toda vez que mudanças são observadas)
        return TextField( // ANTES return
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'seu@email.com',
            labelText: 'Endereço de email',
            errorText: snapshot.error,
          ),
          onChanged: bloc.alterarEmail, // Não preciso sequer passar parâmetro dentro de um ()
          // Posso passar o onChanged também conforme abaixo, mas como fazemos acima reduz a quantidade de código necessário 
          // onChanged: (novoValor) {
          //   bloc.alterarEmail(novoValor);
          // },
        );
      },
    );
  }

  Widget campoSenha(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.senha,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.alterarSenha,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Senha',
            labelText: 'Senha',
            // Assim é como podemos recuperar uma entrada de dados do usuário para poder validá-la. Não faremos mais errorText: 'Email inválido'
            errorText: snapshot.error,
          ),
        );
      }
    );
  }

  Widget botaoSubmit() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 25.0),
        padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
        child: Text('Login'),
        color: Colors.blue,
      ),
      onTap: () {},
    );
  }
}
