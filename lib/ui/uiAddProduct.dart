import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _textFieldControllerName = TextEditingController();
  TextEditingController _textFieldControllerSize = TextEditingController();
  TextEditingController _textFieldControllerDesc = TextEditingController();
  String _fit;
  String _weather;
  String _rating;
  File _cameraImage;

  Future _pickImageFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera);

    setState(() {
      _cameraImage = image;
    });
  }

  void initState() {
    super.initState();
    _textFieldControllerName.text = "";
    _textFieldControllerSize.text = "";
    _textFieldControllerDesc.text = "";
    _fit = "";
    _weather = "";
    _rating = "";
  }

//todo dynamic list
  static const menuItems = <String>[
    'Shirts',
    'T-shirts',
    'Pants',
    'Shorts',
    'Dress',
    'Skirt',
    'Suit',
    'Sport',
    'Jackets/Hoodies',
    'Underwear',
    'Swim',
    'Shoes',
    'Accessories',
    'Other',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String _btnSelectedVal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new RawMaterialButton(
                onPressed: () {
                      _pickImageFromCamera();
                }, //add pic
                child:_cameraImage == null ? new Icon(
                  Icons.camera_enhance,
                  color: Colors.blue,
                  size: 35.0,
                ): new Icon(
                  Icons.camera_alt,
                  color: Colors.red,
                  size: 35.0,
                ),
                shape: new CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(15.0),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Select Catagory:'),
                trailing: DropdownButton(
                  value: _btnSelectedVal,
                  hint: Text('Catagory'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _btnSelectedVal = newValue;
                      if (_btnSelectedVal == 'Add Catagory') {
                        //todo add new cat
                      }
                    });
                  }),
                  items: _dropDownMenuItems,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textFieldControllerName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Item Name',
                  labelText: 'Item Name',
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textFieldControllerSize,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Size',
                  labelText: 'Size',
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textFieldControllerDesc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownFormField(
                value: _fit,
                hintText: 'Fit',
                titleText: 'Fit',
                onSaved: (value) {
                  setState(() {
                    _fit = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _fit = value;
                  });
                },
                dataSource: [
                  {
                    "display": "Snug",
                    "value": "Snug",
                  },
                  {
                    "display": "Tight",
                    "value": "Tight",
                  },
                  {
                    "display": "Comfortable",
                    "value": "Comfortable",
                  },
                  {
                    "display": "Loose",
                    "value": "Loose",
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownFormField(
                value: _weather,
                hintText: 'Weather',
                titleText: 'Weather',
                onSaved: (value) {
                  setState(() {
                    _weather = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _weather = value;
                  });
                },
                dataSource: [
                  {
                    "display": "All",
                    "value": "All",
                  },
                  {
                    "display": "Cold",
                    "value": "Cold",
                  },
                  {
                    "display": "Chilly",
                    "value": "Chilly",
                  },
                  {
                    "display": "Mild",
                    "value": "Mild",
                  },
                  {
                    "display": "Hot",
                    "value": "Hot",
                  },
                  {
                    "display": "Other",
                    "value": "Other",
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownFormField(
                value: _rating,
                hintText: 'Rating',
                titleText: 'Rating',
                onSaved: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
                dataSource: [
                  {
                    "display": "1",
                    "value": "1",
                  },
                  {
                    "display": "2",
                    "value": "2",
                  },
                  {
                    "display": "3",
                    "value": "3",
                  },
                  {
                    "display": "4",
                    "value": "4",
                  },
                  {
                    "display": "5",
                    "value": "5",
                  },
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('SAVE'),
                  color: Colors.blue,
                  highlightColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: 'SAVE PRESSED',
                      toastLength: Toast.LENGTH_LONG,
                    );
                    //addProduct('$_btnSelectedVal','${_textFieldControllerName.text}','${_textFieldControllerPrice.text}','${_textFieldControllerStock.text}','${_textFieldControllerWeight.text}' );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
