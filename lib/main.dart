import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'request.dart';
import 'recog.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File imageFile;
  int _value = 1;

  _openGallery(BuildContext context) async {
    final pictures = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pictures.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final pictures = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(pictures.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context,
      {AlertDialog Function(BuildContext context) builder}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Click Your Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Container();
    }
    else {
      return Image.file(imageFile, width: 400, height: 250);
    }
  }

  // stt.SpeechToText speech;
  // bool isListening = true;
  // String command = "";

  // @override
  // void initState() {
  //   super.initState();
  //   speech = stt.SpeechToText();
  // }
  //
  // speechCommand() async {
  //   bool available = await speech.initialize(
  //     onStatus: (val) => print('onStatus: $val'),
  //     onError: (val) => print('onError: $val'),
  //   );
  //   while (available) {
  //     speech.listen(
  //       listenFor: Duration(minutes: 15),
  //       // partialResults: true,
  //       onResult: (val) => setState(() {
  //         command = val.recognizedWords;
  //         print(command);
  //       }),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Virtual Eye',
          style: TextStyle(
            color: Colors.pink[50],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        color: Colors.pink[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // FutureBuilder(
              //     future: speechCommand(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       return Container();
              //     }
              // ),
              _decideImageView(),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                child: TextRecog(imageFile, _value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 100.0, height: 55.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[800]),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.pink[50]),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.pink[100]),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black38),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: Center(
                          child: Text("Choose\nImage")
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 100.0, height: 55.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[800]),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.pink[50]),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.pink[100]),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black38),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      onPressed: () {
                          ApiService().sendImage(imageFile);
                      },
                      child: Text("Know\nMore"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.pink[800],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.black54,
                        style: BorderStyle.solid,
                      )
                    ),
                    width: 100.0,
                    child: DropdownButton(
                      dropdownColor: Colors.pink[800],
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 32,
                      iconEnabledColor: Colors.pink[50],
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                              child: Text(
                                "English",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink[50],
                                ), // style:
                              ),
                            ),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                              child: Text(
                                "Hindi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink[50],
                                ), // style:
                              ),
                            ),
                          ),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 0.0),
                              child: Text(
                                "Marathi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.pink[50],
                                ), // style:
                              ),
                            ),
                          ),
                          value: 3,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        TextRecog(imageFile, _value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}