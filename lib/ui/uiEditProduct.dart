
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final List editDb;
  final List<String> colDb;
  EditProductPage( this.editDb,this.colDb);//this.editDb,
  
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {

  @override
  Widget build(BuildContext context,) {
    print('${widget.colDb} \n${widget.editDb}');
    // TODO: implement build
    throw UnimplementedError();
  }

}