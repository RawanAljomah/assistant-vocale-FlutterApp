import 'package:assistant_app/Box.dart';
import 'package:assistant_app/Palette.dart';
import 'package:assistant_app/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:assistant_app/http_service.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  
class _MyHomePageState extends State<MyHomePage> {
  String language ='';
SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Voice Assistant app'),
        actions: [
          Text(language),
         // Icon(Icons.)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ExpansionTile(
              title: Text('Choose language'),
              children: [
                ListTile(
                  title:Text('FRENCH'),
                  onTap:(){   
                    setState(() {
                      language ='FR';
                    });
                  } ,),                 
                ListTile(
                  title:Text('ENGLISH'),
                  onTap:(){   
                    setState(() {
                      language ='EN';
                    });
                  }
                  )],
              ),
              Divider(),
              ExpansionTile(
              title: Text('Choose voice'),
              children: [
                ListTile(title:Text('Man')),
                ListTile(title:Text('Woman'))],
              )
          ],)
        ),
      body: SingleChildScrollView(
          child:
           Column(
            children: [
              Center(child: Container(
                width: 150,height: 150,
                //color: Palette.textcolor, 
                decoration: 
                BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Palette.textcolor,
                  image:DecorationImage(
                    image: AssetImage('assets/ai.jpg')
                  )
                  ),
                
                  )
                  ),
                  Container(
                    child: Text('Hello, how can I help you ?'),
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.zero, 
                    topRight: Radius.circular(20),bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                    color: Palette.boxcolor,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 50),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    Box(couleur: Palette.boxcolor, header: 'ChatGPT',),
                    Box(couleur: Palette.boxcolor, header: 'Dall',),
    
            ],
            ),
            ),
    floatingActionButton: FloatingActionButton(
        child: Icon( _speechToText.isNotListening?Icons.mic:Icons.stop),

        onPressed: ()async{ //traitement non bloquant , il va attendre
          if (await _speechToText.hasPermission && _speechToText.isNotListening ) {
            print('start listenning');
            _startListening();// pour dire que c'est private  
          }else 
          if(_speechToText.isListening){
            print(_lastWords); 
            getGeminiResponse(_lastWords);
            //getGeminiResponse("bonjour");

            print('stop listenning');

            _stopListening();
          }else{
            _initSpeech();//si il n'a pas la permission, on doit reinitialiser
          }
            
    },),
    );
  }
  
}



// ignore: camel_case_types



