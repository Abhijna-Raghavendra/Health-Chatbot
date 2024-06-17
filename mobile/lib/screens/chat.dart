import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final List<types.User> _users = [
    const types.User(id: '1'),
    const types.User(id: '2')
  ];
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  final TextEditingController _controller = TextEditingController();
  late Map<String, dynamic>? data =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _users[0],
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    String resp = await response(message.text, data);
    final replyMessage = types.TextMessage(
      author: _users[1],
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: resp,
    );

    setState(() {
      _messages.insert(0, textMessage);
      _messages.insert(0, replyMessage);
    });
    _controller.clear();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            _controller.text = _text;
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: const Text('Health-Chatbot'),
        centerTitle: true,
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _users[0],
        theme: DefaultChatTheme(
          backgroundColor: Colors.transparent,
          primaryColor: Colors.white12,
          inputBackgroundColor: Colors.white12,
          inputMargin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.h),
        ),
        customBottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.h),
          child: Row(
            children: [
              IconButton(
                icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                onPressed: _listen,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _handleSendPressed(types.PartialText(text: value));
                      setState(() {
                        _text = '';
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_text.isNotEmpty) {
                    _handleSendPressed(types.PartialText(text: _text));
                    setState(() {
                      _text = '';
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> response(String message, Map<String, dynamic>? data) async {
  String? uname = (data != null) ? data['username'] : '';
  Map<String, dynamic> m = {'query': message};
  String r = await chat(m);
  return r;
}
