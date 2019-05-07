import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/models/Album.dart';
import 'package:flutter_burc_rehberi/models/Article.dart';
import 'package:flutter_burc_rehberi/models/Person.dart';
import 'package:flutter_burc_rehberi/models/burc.dart';
import 'package:http/http.dart' as http;

class BurcListesi extends StatelessWidget {
  static List<Burc> burclar;

  void deneme() {
    List<Burc> burcDeneme = veriKaynaginiHazirla();
  }

  @override
  Widget build(BuildContext context) {
    burclar = veriKaynaginiHazirla();
    burclar.forEach((oAnkiBurc) =>
        debugPrint("${oAnkiBurc.burcIsim} and2 ${oAnkiBurc.burcTarih}"));

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Burç Rehberi",
            style: TextStyle(
                color: Colors.pinkAccent, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
              elevation: 8.0,
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, '/burcDetay/$index'),
                leading: Icon(Icons.settings),
                title: Text("${burclar[index].burcIsim.toString()}"),
                subtitle: Text("${burclar[index].burcTarih.toString()}"),
                trailing: Icon(Icons.add_a_photo),
              ),
            ),
        itemCount: 11,
      ),
    );
  }

  List<Burc> veriKaynaginiHazirla() {
    List<Burc> myBurcList = List<Burc>();

    for (int i = 0; i < 12; i++) {
      var myBurcModel = Burc("burc $i", "burc tarih $i");
      myBurcList.add(myBurcModel);
    }
    return myBurcList;
  }
}

class BurcDetay extends StatefulWidget {
  int oAnkiBurc;
  int maxLines = 1;

  BurcDetay(this.oAnkiBurc) {}

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  String _isim, _soyisim;
  bool _checkBoxState = false;
  bool _radioState = false;
  String sehir = "";
  FocusNode _focusNode;
  int maxLength = 10;
  double valued = 10;
  int stateIndex = 0;
  String dropDownMenuItem;
  TextEditingController _textContreller;
  Color _color;
  bool hata = false;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  final formKey = GlobalKey<FormState>();
  final formKeyIki = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _focusNode.dispose();
    _textContreller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("widgetsx");

    _focusNode = new FocusNode();
    _textContreller = new TextEditingController(text: "");
    _focusNode.addListener(() {
      //focusolayı her değiştiğinde hangi widgeta eklediysek orasıyla oynuyor:
      setState(() {
        if (_focusNode.hasFocus) {
          _color = Colors.red;
          maxLength = 60;
          widget.maxLines = 3;
        } else {
          _color = Colors.greenAccent;
          widget.maxLines = 1;
          maxLength = 10;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }

      // TODO according to DartDoc num.parse() includes both (double.parse and int.parse)
      return double.parse(s, (e) => null) != null ||
          int.parse(s, onError: (e) => null) != null;
    }

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              setState(
                () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    debugPrint("isim $_isim soyisim $_soyisim");
                  }

                  if (key0.currentState.validate()) {}

                  FocusScope.of(context).requestFocus(_focusNode);
                  //debugPrint("${_textContreller.text}");
                  //_textContreller.text = "ali tosun";
                },
              );
            },
            child: Text("Focus"),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Burç Detay",
          style:
              TextStyle(color: Colors.pinkAccent, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: formKey,
        autovalidate: true,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Divider(
                height: 10,
              ),
              InkWell(
                child: RaisedButton(
                  child: Text("hero+inkwell"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => heroDeneme(),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                child: RaisedButton(
                  child: Text("inkwell"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => heroDenemeIki(),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                child: RaisedButton(
                  child: Text("fotoğraf json"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => heroDenemeUc(),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                child: RaisedButton(
                  child: Text("Stack deneme"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => heroDenemeDort(),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                focusNode: _focusNode,
                keyboardAppearance: Brightness.dark,
                maxLength: maxLength,
                maxLines: widget.maxLines,
                cursorRadius: Radius.circular(10),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box),
                    labelText: "Kullanıcı Adı",
                    filled: true,
                    labelStyle: TextStyle(
                        color: _color,
                        fontStyle: FontStyle.italic,
                        fontSize: 24),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                validator: (gelenVeri) {
                  if (isNumeric(gelenVeri)) {
                    if (int.parse(gelenVeri) < 1900) {
                      return "1900 yilindan büyük değer gir";
                    } else {
                      return null;
                    }
                  }
                },
                onSaved: (gelenVeri) => _isim = gelenVeri,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                maxLength: maxLength,
                maxLines: 1,
                cursorRadius: Radius.circular(10),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box),
                    helperStyle: TextStyle(color: _color),
                    labelText: "Kullanıcı Adı",
                    filled: true,
                    labelStyle: TextStyle(
                        color: _color,
                        fontStyle: FontStyle.italic,
                        fontSize: 24),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    )),
                validator: (gelenVeri) {
                  if (gelenVeri.isEmpty) {
                    return "boş bırakılamaz";
                  } else
                    return null;
                },
                onSaved: (gelenVeri) => _soyisim = gelenVeri,
              ),
              CheckboxListTile(
                  value: _checkBoxState,
                  onChanged: (state) {
                    setState(() {
                      _checkBoxState = state;
                    });
                  }),
              RadioListTile<String>(
                  value: "Konya",
                  groupValue: sehir,
                  onChanged: (gelenVeri) {
                    setState(() {
                      sehir = gelenVeri;
                      debugPrint(sehir);
                    });
                  }),
              RadioListTile<String>(
                  value: "İzmir",
                  groupValue: sehir,
                  onChanged: (gelenVeri) {
                    setState(() {
                      sehir = gelenVeri;
                      debugPrint(sehir);
                    });
                  }),
              RadioListTile<String>(
                  value: "Ankara",
                  groupValue: sehir,
                  title: Text("Ankara"),
                  onChanged: (gelenVeri) {
                    setState(() {
                      sehir = gelenVeri;
                      debugPrint(sehir);
                    });
                  }),
              Slider(
                value: valued,
                onChanged: (gelenDeger) {
                  setState(() {
                    valued = gelenDeger;
                  });
                },
                min: 0.0,
                max: 15.0,
                label: valued.toString(),
                divisions: 15,
                activeColor: Colors.red,
              ),
              Text("Seçilen Değer $valued"),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text("ali"),
                    value: "Ali",
                  ),
                  DropdownMenuItem<String>(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Kırmızı"),
                        )
                      ],
                    ),
                    value: "Kirmizi",
                  ),
                ],
                onChanged: (T) {
                  setState(() {
                    dropDownMenuItem = T;
                    debugPrint(dropDownMenuItem);
                  });
                },
                value: dropDownMenuItem,
              ),
              RaisedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019, 4, DateTime.now().day - 30),
                          lastDate: DateTime(2019, 4, DateTime.now().day + 30))
                      .then((onValue) {
                    debugPrint(onValue.microsecondsSinceEpoch.toString());
                    debugPrint(onValue.toString());

                    var dateTimes = DateTime.parse(
                        onValue.microsecondsSinceEpoch.toString());
                    debugPrint(dateTimes.toString());
                  });
                },
                child: Text("tarih"),
                color: Colors.greenAccent,
              ),
              Stepper(
                steps: [
                  Step(
                    state: _stateOlustur(0),
                    title: Text("Kullanıcı Adı"),
                    content: TextFormField(
                      key: key0,
                      decoration: InputDecoration(
                          labelText: "Kullanıcı İsmi",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      validator: (gelenVeri) {
                        if (gelenVeri.length < 6) {
                          return "6 karakterden küçük olamaz";
                        }
                      },
                    ),
                  ),
                  Step(
                    state: _stateOlustur(1),
                    isActive: true,
                    title: Text("Kullansıcı Adı"),
                    content: TextFormField(
                      key: key1,
                      decoration: InputDecoration(
                          labelText: "Kullanıcı İsmi",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      validator: (gelenVeri) {
                        if (gelenVeri.length < 6) {
                          return "6 karakterden küçük olamaz";
                        }
                      },
                    ),
                  ),
                  Step(
                    state: _stateOlustur(2),
                    isActive: true,
                    title: Text("Kullanıcı Adı"),
                    content: TextFormField(
                      key: key2,
                      decoration: InputDecoration(
                          labelText: "Kullanıcı İsmi",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      validator: (gelenVeri) {
                        if (gelenVeri.length < 6) {
                          return "6 karakterden küçük olamaz";
                        }
                      },
                    ),
                  ),
                ],
                onStepContinue: () {
                  setState(() {
                    checkValidate();
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (stateIndex == 0) {

                    }
                    else {
                      stateIndex--;
                    }
                    hata = false;
                  });
                },
                currentStep: stateIndex,
                /*    onStepTapped: (currenState) {
                  setState(() {
                    stateIndex = currenState.toInt();
                  });

                },*/
              )
            ],
          ),
        ),
      ),
    );
  }

  _stateOlustur(int gelenState) {
    //current state = stateIndex

    if (gelenState == stateIndex) {
      if (!hata) {
        return StepState.editing;
      } else {
        return StepState.error;
      }
    } else
      return StepState.indexed;
  }

  void checkValidate() {
    switch (stateIndex) {
      case 0:
        if (key0.currentState.validate()) {
          stateIndex++;
          hata = false;
        } else {
          hata = true;
        }
        break;

      case 1:
        if (key1.currentState.validate()) {
          stateIndex++;
          hata = false;
        } else {
          hata = true;
        }

        break;

      case 2:
        if (key2.currentState.validate()) {
          hata = false;
        } else {
          hata = true;
        }

        break;
    }
  }
}

void asd() {}

class heroDeneme extends StatefulWidget {
  @override
  _heroDenemeState createState() => _heroDenemeState();
}

class _heroDenemeState extends State<heroDeneme> {
  Future<List<Article>> gonderileriGetir() async {
    http.Response gonderi =
        await http.get("https://jsonplaceholder.typicode.com/posts");
    /*   debugPrint("gonder to string"+gonderi.body);
    debugPrint("gonderi stringinin json a çevir"+jsonDecode(gonderi.body).toString());*/

    if (gonderi.statusCode == 200) {
      return (jsonDecode(gonderi.body) as List)
          .map((article) => Article.fromJsonMap(article))
          .toList();
    } else {
      throw Exception("başarısız");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gonderileriGetir().then((readArticle) {
      debugPrint(readArticle[0].title.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("deneme article"),
      ),
      body: FutureBuilder(
          future: gonderileriGetir(),
          builder: (context, AsyncSnapshot<List<Article>> sonucList) {
            if (sonucList.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Text(
                        "User id:" + sonucList.data[index].userId.toString()),
                    title: Text(sonucList.data[index].body.toString()),
                    subtitle: Text(sonucList.data[index].title.toString()),
                    leading: CircleAvatar(
                      child: Text(
                        sonucList.data[index].id.toString(),
                      ),
                    ),
                  );
                },
                itemCount: sonucList.data.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class heroDenemeIki extends StatefulWidget {
  @override
  _heroDenemeIkiState createState() => _heroDenemeIkiState();
}

class _heroDenemeIkiState extends State<heroDenemeIki> {
  List<Person> listModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veriKaynaginiOku().then((onValue) {
      setState(() {
        listModel = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> deneme = [
      {'id': "Ali", 'numara': "1562"},
      {'id': "Esra", 'numara': "2452"}
    ];

    deneme.forEach((mapEleman) => debugPrint(mapEleman['numara']));

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: listModel != null
          ? ListView.builder(
              itemBuilder: (context, index) => Text.rich(
                    TextSpan(text: listModel[index].adi),
                  ),
              itemCount: listModel.length,
            )
          : CircularProgressIndicator(),
    );
  }

  Future<List<Person>> veriKaynaginiOku() async {
    String gelenVeri = await DefaultAssetBundle.of(context)
        .loadString("assets/data/araba.json");
    List<Person> myList2 = [];

    //jsonDecode(gelenVeri) => her bir elemanı map olan bir liste içerir.
    List<Person> myList = (jsonDecode(gelenVeri) as List)
        .map((mapEleman) => Person.fromJsonMap(mapEleman))
        .toList();
    (jsonDecode(gelenVeri) as List)
        .forEach((mapEleman) => myList2.add(Person.fromJsonMap(mapEleman)));

    return myList2;
  }
}

class heroDenemeUc extends StatefulWidget {
  @override
  _heroDenemeUcState createState() => _heroDenemeUcState();
}

class _heroDenemeUcState extends State<heroDenemeUc> {
  Future<Album> getSingleAlbum() async {
    http.Response album =
        await http.get("https://jsonplaceholder.typicode.com/photos/2");
    debugPrint("albüm to string" + album.body);
    debugPrint(
        "albüm stringinin json a çevir" + jsonDecode(album.body).toString());

    if (album.statusCode == 200) {
      return Album.fromJsonMap(jsonDecode(album.body));
    } else {
      throw Exception("albüm cekilemedi");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingleAlbum().then((Album) => debugPrint("albümmm" + Album.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tek resim deneme"),
      ),
      body: FutureBuilder(
          future: getSingleAlbum(),
          builder: (context, snapShotData) {
            if (snapShotData.connectionState == ConnectionState.done) {
              return ExpansionTile(
                title: Text(
                  snapShotData.data.title,
                ),
                children: <Widget>[
                  Container(
                    child: Image.network(
                      snapShotData.data.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class heroDenemeDort extends StatefulWidget {
  @override
  _heroDenemeDortState createState() => _heroDenemeDortState();
}

class _heroDenemeDortState extends State<heroDenemeDort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("scaffold deneme"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.height * 0.04,
            bottom: MediaQuery.of(context).size.height * 0.08,
            right: MediaQuery.of(context).size.height * 0.04,
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  Text(
                    "Ali Tosun Post",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              elevation: 10,
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
            ),
          )
        ],
      ),
    );
  }
}
