import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

class AbaConversa extends StatefulWidget {
  @override
  _AbaConversaState createState() => _AbaConversaState();
}

class _AbaConversaState extends State<AbaConversa> {
  
  List<Conversa> listaConversas = [
    Conversa(
      "Ana Clara",
      "Olá, tudo bem?",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=a416e7fd-c23a-4bbd-8b2c-afdc29b1656f"
    ),
    Conversa(
      "Pedro Silva",
      "Me manda o link daquela série",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=42a60611-525f-49e0-b27e-7896b437d66d"
    ),
    Conversa(
      "Marcela",
      "Obrigado",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=e43e07ad-6312-4a7f-a359-682f41a85ec1"
    ),
    Conversa(
      "José Renato",
      "Não vai acreditar no que eu tenho para te contar...",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=0901f4ef-cdef-4cee-b53b-7252c7e7d901"
    ),
    Conversa(
      "Jamilton Damasceno",
      "Já fez o curso hoje?",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-c85b9.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=b55f52ad-0c95-4ec4-84a6-5a31f5b170ee"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, indice) {

        Conversa conversa = listaConversas[indice];

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