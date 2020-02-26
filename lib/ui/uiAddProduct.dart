import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mythreads/services/db.dart';
import 'package:mythreads/ui/uiAppHome.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  final db = DatabaseHelper.instance;
TextEditingController _textFieldControllerDialog = TextEditingController();
  TextEditingController _textFieldControllerName = TextEditingController();
  TextEditingController _textFieldControllerDesc = TextEditingController();
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
    _textFieldControllerName.text = null;//NOT NULL
    _textFieldControllerDesc.text = null;
    _btnSelectedValCat=null;//NOT NULL
    _btnSelectedValRating=null;
    _btnSelectedValWeather=null;
    _btnSelectedValFit=null;
    _btnSelectedValSize=null;
  }
List<DropdownMenuItem<String>> catList=List();
List<DropdownMenuItem<String>> fitList=List();
List<DropdownMenuItem<String>> weatherList=List();
List<DropdownMenuItem<String>> sizeList=List();

static const ratingList = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
];

  String _btnSelectedValCat;
  String _btnSelectedValWeather;
  String _btnSelectedValFit;
  String _btnSelectedValSize;
  String _btnSelectedValRating;
  final List<DropdownMenuItem<String>> _dropDownMenuItemsRating = ratingList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _query(),
        builder: (context, snapshot) {
    return Scaffold(
      resizeToAvoidBottomInset: false,//double check
      appBar: AppBar(
        title: Text('Add Item'),
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
                controller: _textFieldControllerDesc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text('Select Category:'),
                trailing: DropdownButton(
                  value: _btnSelectedValCat,
                  hint: Text('Category',textAlign: TextAlign.center,),
                  onChanged: ((String newValue) {
                      if (newValue == 'Add New Category') {
                        _showDialog(context,'Category','e.g. Pants').then((val) {
                    catList.add(
          DropdownMenuItem<String>(
          value: '$val',
          child: Text('$val')));
                });    
                      }
                      else{
                        setState(() {
_btnSelectedValCat = newValue;
                          });
                      }
                  }),
                  items: catList,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text('Select Size:'),
                trailing: DropdownButton(
                  value: _btnSelectedValSize,
                  hint: Text('Size'),
                  onChanged: ((String newValue) {
                    if (newValue == 'Add New Size') {
                        _showDialog(context,'Size','e.g. 34').then((val) {
                          sizeList.add(
                            DropdownMenuItem<String>(
                            value: '$val',
                             child: Text('$val')));
                           });
                          }else{
                        setState(() {
                          _btnSelectedValSize = newValue;
                          });
                      }
                  }),
                  items: sizeList,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text('Select Fit:'),
                trailing: DropdownButton(
                  value: _btnSelectedValFit,
                  hint: Text('Fit'),
                  onChanged: ((String newValue) {
                    if (newValue == 'Add New Fit') {
                        _showDialog(context,'Fit','e.g. Loose').then((val) {
                          fitList.add(
                            DropdownMenuItem<String>(
                            value: '$val',
                             child: Text('$val')));
                           });
                          }else{
                        setState(() {
                          _btnSelectedValFit = newValue;
                          });
                      }
                  }),
                  items: fitList,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                title: Text('Select Weather:'),
                trailing: DropdownButton(
                  value: _btnSelectedValWeather,
                  hint: Text('Weather'),
                  onChanged: ((String newValue) {
                    if (newValue == 'Add New Weather') {
                        _showDialog(context,'Weather','e.g. Cold').then((val) {
                          weatherList.add(
                            DropdownMenuItem<String>(
                            value: '$val',
                             child: Text('$val')));
                           });
                          }else{
                        setState(() {
                          _btnSelectedValWeather = newValue;
                          });
                      }
                  }),
                  items: weatherList,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child:ListTile(
                title: Text('Select Rating:'),
                trailing: DropdownButton(
                  value: _btnSelectedValRating,
                  hint: Text('Rating'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _btnSelectedValRating = newValue;
                    });
                  }),
                  items: _dropDownMenuItemsRating,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
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
                    
                    if(_textFieldControllerName.text !=null && _btnSelectedValCat!=null && _cameraImage !=null){
                     print('SAVE IF: ${_textFieldControllerName.text} $_btnSelectedValCat $_btnSelectedValSize $_btnSelectedValFit $_btnSelectedValWeather $_btnSelectedValRating ${_textFieldControllerDesc.text} !$_cameraImage!');//${_cameraImage.uri}
                    _insert(_textFieldControllerName.text,_btnSelectedValCat,_btnSelectedValSize,_btnSelectedValFit,_btnSelectedValWeather,_btnSelectedValRating,_textFieldControllerDesc.text,_cameraImage.uri);
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
                    }else{
                  print('SAVE ELSE: ${_textFieldControllerName.text} $_btnSelectedValCat $_btnSelectedValSize $_btnSelectedValFit $_btnSelectedValWeather $_btnSelectedValRating ${_textFieldControllerDesc.text} !$_cameraImage!');//${_cameraImage.uri}

Fluttertoast.showToast(
                  msg: 'Please complete Photo, Name and Category fields',
                  toastLength: Toast.LENGTH_LONG,
                );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
        
    );
        },
    );
  }

_query() async {
  //print('_query add item method called');
  //print('_query called catList: ${catList.length} ');//${catList[1].value}
  
List<String> tempCatList=List();
List<String> tempSizeList=List();
List<String> tempFitList=List();
List<String> tempWeatherList=List();

  if(catList.length==0){

    //print('_query called and fetching');
final allRows = await db.queryAllRows();
//print('ADD PRODUCT allrows $allRows');
//add to lists for menu options

// sizeList.clear();
// weatherList.clear();
// fitList.clear();
// catList.clear();

//find all catagories in db
allRows.forEach((row) {
  for(int i = 0;i<catList.length;i++){
  tempCatList.add('${catList[i].value}');
}
      if (!tempCatList.toString().contains('${row['cat']}')) {
      // if (!catList.toString().contains('${row['cat']}')) {
        //catList.add('${row['cat']}');
        catList.add(
          DropdownMenuItem<String>(
          value: '${row['cat']}',
          child: Text('${row['cat']}')));
      }
    });
catList.add(
          DropdownMenuItem<String>(
          value: 'Add New Category',
          child: Text('Add New Category')));
//find all sizes in db
allRows.forEach((row) {
  for(int i = 0;i<sizeList.length;i++){
  tempSizeList.add('${sizeList[i].value}');
}
      if (!tempSizeList.toString().contains('${row['size']}')) {
      // if (!sizeList.toString().contains('${row['size']}')) {
        //sizeList.add('${row['size']}');
        sizeList.add(
          DropdownMenuItem<String>(
          value: '${row['size']}',
          child: Text('${row['size']}')));
      }
    });
sizeList.add(
          DropdownMenuItem<String>(
          value: 'Add New Size',
          child: Text('Add New Size')));
//find all weather in db
allRows.forEach((row) {
  for(int i = 0;i<weatherList.length;i++){
  tempWeatherList.add('${weatherList[i].value}');
}
      if (!tempWeatherList.toString().contains('${row['weather']}')) {
      // if (!weatherList.toString().contains('${row['weather']}')) {
        //weatherList.add('${row['weather']}');
        weatherList.add(
          DropdownMenuItem<String>(
          value: '${row['weather']}',
          child: Text('${row['weather']}')));
      }
    });
weatherList.add(
          DropdownMenuItem<String>(
          value: 'Add New Weather',
          child: Text('Add New Weather')));
//find all fit in db
allRows.forEach((row) {
  for(int i = 0;i<fitList.length;i++){
  tempFitList.add('${fitList[i].value}');
}
      if (!tempFitList.toString().contains('${row['fit']}')) {
      // if (!fitList.toString().contains('${row['fit']}')) {
        //fitList.add('${row['fit']}');
        fitList.add(
          DropdownMenuItem<String>(
          value: '${row['fit']}',
          child: Text('${row['fit']}')));
      }
    });
fitList.add(
          DropdownMenuItem<String>(
          value: 'Add New Fit',
          child: Text('Add New Fit')));
  }//if
}

  void _insert(_textFieldControllerName,_btnSelectedValCat,_btnSelectedValSize,_btnSelectedValFit,_btnSelectedValWeather,_btnSelectedValRating,_textFieldControllerDesc,_cameraImage) async {
    
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : '$_textFieldControllerName',
      DatabaseHelper.columnCat  : '$_btnSelectedValCat',
      DatabaseHelper.columnSize  : '$_btnSelectedValSize',
      DatabaseHelper.columnFit  : '$_btnSelectedValFit',
      DatabaseHelper.columnWeather  : '$_btnSelectedValWeather',
      DatabaseHelper.columnRating  : '$_btnSelectedValRating',
      DatabaseHelper.columnDesc  : '$_textFieldControllerDesc',
      DatabaseHelper.columnPic  : '$_cameraImage',
    };
    final id = await db.insert(row);
    Fluttertoast.showToast(
                      msg: 'Item $_textFieldControllerName Added',
                      toastLength: Toast.LENGTH_SHORT,
                    );
    print('inserted row id: $id name: $_textFieldControllerName cat: $_btnSelectedValCat size: $_btnSelectedValSize fit: $_btnSelectedValFit weather: $_btnSelectedValWeather rating: $_btnSelectedValRating desc: $_textFieldControllerDesc pic: $_cameraImage');
  }


_showDialog(BuildContext context, String title, String hint)  {
  _textFieldControllerDialog.text='';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$title'),
            content: TextField(
              controller: _textFieldControllerDialog,
              decoration: InputDecoration(hintText: "$hint"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SAVE'),
                onPressed: () {
                  Navigator.pop(context, _textFieldControllerDialog.text);
                },
              ),
            ],
          );
        });
  }
}