import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedDetails extends StatefulWidget {
  final DocumentSnapshot post;

  @required
  const MedDetails(this.post);
  @override
  _MedDetailsState createState() => _MedDetailsState();
}

class _MedDetailsState extends State<MedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.data['title']) , centerTitle: true,),
    );
  }
}
