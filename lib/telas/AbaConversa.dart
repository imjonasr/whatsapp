import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

class AbaConversa extends StatefulWidget {
  @override
  _AbaConversaState createState() => _AbaConversaState();
}

class _AbaConversaState extends State<AbaConversa> {
  
  List<Conversa> _listaConversas = List();

  @override
  void initState() {
    super.initState();

    Conversa conversa = Conversa();

    conversa.nome = "Ana Clara";
    conversa.mensagem = "Olá, tudo bem?";
    conversa.caminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=a416e7fd-c23a-4bbd-8b2c-afdc29b1656f";

    _listaConversas.add(conversa);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listaConversas.length,
      itemBuilder: (context, indice) {

        Conversa conversa = _listaConversas[indice];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage( conversa.caminhoFoto ),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            conversa.mensagem,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );

      },
    );
  }
}