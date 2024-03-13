import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ChatScreenRemoto extends StatefulWidget {
  const ChatScreenRemoto({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreenRemoto> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isBotTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Atendimento Remoto'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 167, 25, 32),
      ),
      body: Container(
        color: Colors.white12,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _messages,
                ),
              ),
            ),
            if (_isBotTyping)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                alignment: Alignment.centerLeft,
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text('Bot digitando...'),
                  ],
                ),
              ),
            if (_messages.isEmpty)
              Container(
                height: 250,
                alignment: Alignment.topCenter,
                child: const Text(
                  'Tire suas dúvidas sobre os sistemas revemar',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  border:
                      Border.all(color: const Color.fromARGB(255, 167, 25, 32)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildTextComposer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).canvasColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar uma mensagem',
                  hintStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Color.fromARGB(255, 167, 25, 32),
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    _addMessage(text, true);
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5005/webhooks/rest/webhook'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': text}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _isBotTyping = true;
        setState(() {});

        await Future.delayed(const Duration(milliseconds: 1000));

        for (var data in responseData) {
          if (data.containsKey('image')) {
            _addImage(data['image']); // Método para adicionar e exibir a imagem
          } else {
            _addMessage(data['text'], false);
          }
        }

        _isBotTyping = false;
        setState(() {});
      } else {
        throw Exception('Mensagem não enviada!!');
      }
    } catch (e) {
      _isBotTyping = false;
      setState(() {});
    }
  }

  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: isUser));
    });
  }

  void _addImage(String imageUrl) {
    setState(() {
      _messages.add(ChatMessage(imageUrl: imageUrl, isUser: false));
    });
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final String? imageUrl;
  final bool isUser;

  const ChatMessage({Key? key, this.text, this.imageUrl, required this.isUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isUser
              ? Expanded(
                  child: Container(),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: const CircleAvatar(
                    child: Text('B'),
                    // backgroundImage: NetworkImage(
                    //     'https://repository-images.githubusercontent.com/423180394/51fb7f2b-0bb0-4c3e-a06c-840fa3a910eb'),
                  ),
                ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color.fromARGB(255, 167, 25, 32)
                        : Colors.blue,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          text!,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
          isUser
              ? Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: const CircleAvatar(
                    child: Text('U'),
                  ),
                )
              : Expanded(
                  child: Container(),
                ),
        ],
      ),
    );
  }
}
