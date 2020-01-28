import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbaConversa extends StatefulWidget {
  @override
  _AbaConversaState createState() => _AbaConversaState();
}

class _AbaConversaState extends State<AbaConversa> {
  
  List<Conversa> _listaConversas = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _idUsuarioLogado;

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();

    Conversa conversa = Conversa();

    conversa.nome = "Ana Clara";
    conversa.mensagem = "Olá, tudo bem?";
    conversa.caminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=a416e7fd-c23a-4bbd-8b2c-afdc29b1656f";

    _listaConversas.add(conversa);
  }

  Stream<QuerySnapshot> _adicionarListenerConversas() {
    final stream = db.collection("conversas")
      .document(_idUsuarioLogado)
      .collection("ultima_conversa")
      .snapshots();

    stream.listen((dados){
      _controller.add( dados );
    });
  }

  _recuperarDadosUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    _adicionarListenerConversas();

  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot> (
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando conversas"),
                  CircularProgressIndicator(),
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasError) {
              return Text("Erro ao carregar os dados!");
            } else {
              
              QuerySnapshot querySnapshot = snapshot.data;

              if( querySnapshot.documents.length == 0 ) {
                return Center(
                  child: Text(
                    "Você não tem nenhuma mensagem ainda :(",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return ListView.builder(
              itemCount: _listaConversas.length,
              itemBuilder: (context, indice) {

                List<DocumentSnapshot> conversas = querySnapshot.documents.toList();
                DocumentSnapshot item = conversas[indice];

                String urlImagem = item["caminhoFoto"];
                String tipo = item["tipoMensagem"];
                String mensagem = item["mensagem"];
                String nome = item["nome"];

                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: urlImagem != null 
                    ? NetworkImage( urlImagem )
                    : null,
                  ),
                  title: Text(
                    nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    tipo == "texto"
                    ? mensagem
                    : "Imagem...",
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
      },
    );
    
  }
}