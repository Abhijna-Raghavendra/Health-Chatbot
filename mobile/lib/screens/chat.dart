// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile/utils.dart';
// import 'package:uuid/uuid.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<types.Message> _messages = [];

//   final List<types.User> _users = [
//     const types.User(
//       id: '1',
//     ),
//     const types.User(
//       id: '2',
//     )
//   ];

//   void _handleSendPressed(types.PartialText message) async {
//     final textMessage = types.TextMessage(
//       author: _users[0],
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );
//     String resp = await response(message.text);
//     final replyMessage = types.TextMessage(
//       author: _users[1],
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: resp,
//     );

//     setState(() {
//       _messages.insert(0, textMessage);
//       _messages.insert(0, replyMessage);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/home');
//           },
//         ),
//         title: const Text('Health-Chatbot'),
//         centerTitle: true,
//       ),
//       body: Chat(
//         messages: _messages,
//         onSendPressed: _handleSendPressed,
//         user: _users[0],
//         theme: DefaultChatTheme(
//           backgroundColor: Colors.transparent,
//           primaryColor: Colors.white12,
//           //inputBorderRadius: BorderRadius.all(Radius.circular(18.r)),
//           inputBackgroundColor: Colors.white12,
//           inputMargin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.h),
//         ),
//       ),
//     );
//   }
// }

// Future<String> response(String message) async {
//   String r = await chat(message);
//   return r;
// }

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

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _users[0],
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    String resp = await response(message.text);
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

Future<String> response(String message) async {
  String r = await chat(message);
  return r;
}

// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile/utils.dart';
// import 'package:uuid/uuid.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<types.Message> _messages = [];
//   final List<types.User> _users = [
//     const types.User(id: '1'),
//     const types.User(id: '2')
//   ];
//   final stt.SpeechToText _speechToText = stt.SpeechToText();
//   bool _isListening = false;
//   String _text = '';
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _initSpeechToText();
//   }

//   Future<void> _initSpeechToText() async {
//     bool hasPermission = await _requestMicrophonePermission();
//     if (hasPermission) {
//       bool available = await _speechToText.initialize(
//         onStatus: (val) => _onSpeechStatus(val),
//         onError: (val) => _onSpeechError(val),
//       );
//       if (!available) {
//         print("The user has denied the use of speech recognition.");
//       }
//     }
//   }

//   Future<bool> _requestMicrophonePermission() async {
//     PermissionStatus status = await Permission.microphone.request();
//     if (status.isGranted) {
//       return true;
//     } else if (status.isDenied || status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//     return false;
//   }

//   void _handleSendPressed(types.PartialText message) async {
//     final textMessage = types.TextMessage(
//       author: _users[0],
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );
//     String resp = await response(message.text);
//     final replyMessage = types.TextMessage(
//       author: _users[1],
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: resp,
//     );

//     setState(() {
//       _messages.insert(0, textMessage);
//       _messages.insert(0, replyMessage);
//     });
//     _controller.clear();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speechToText.initialize(
//         onStatus: (val) => _onSpeechStatus(val),
//         onError: (val) => _onSpeechError(val),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speechToText.listen(
//           onResult: (val) => setState(() {
//             _text = val.recognizedWords;
//             _controller.text = _text;
//             _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
//           }),
//           pauseFor: Duration(seconds: 3), // Time to wait after the user stops speaking
//           listenFor: Duration(minutes: 1), // Maximum duration to listen for
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speechToText.stop();
//     }
//   }

//   void _onSpeechStatus(String status) {
//     if (status == "notListening") {
//       setState(() {
//         _isListening = false;
//       });
//     }
//   }

//   void _onSpeechError(String error) {
//     setState(() {
//       _isListening = false;
//     });
//     print("Speech recognition error: $error");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/home');
//           },
//         ),
//         title: const Text('Health-Chatbot'),
//         centerTitle: true,
//       ),
//       body: Chat(
//         messages: _messages,
//         onSendPressed: _handleSendPressed,
//         user: _users[0],
//         theme: DefaultChatTheme(
//           backgroundColor: Colors.transparent,
//           primaryColor: Colors.white12,
//           inputBackgroundColor: Colors.white12,
//           inputMargin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.h),
//         ),
//         customBottomWidget: Padding(
//           padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.h),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                 onPressed: _listen,
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   onChanged: (value) {
//                     setState(() {
//                       _text = value;
//                     });
//                   },
//                   onSubmitted: (value) {
//                     if (value.isNotEmpty) {
//                       _handleSendPressed(types.PartialText(text: value));
//                       setState(() {
//                         _text = '';
//                       });
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Type your message',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(18.r),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () {
//                   if (_text.isNotEmpty) {
//                     _handleSendPressed(types.PartialText(text: _text));
//                     setState(() {
//                       _text = '';
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<String> response(String message) async {
//   String r = await chat(message);
//   return r;
// }

