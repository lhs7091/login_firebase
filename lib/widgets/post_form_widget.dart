import 'package:flutter/material.dart';

class PostFormWidget extends StatelessWidget {
  final imageFile;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final bool loading;

  PostFormWidget(
      {this.imageFile,
      this.descriptionController,
      this.loading,
      this.locationController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading
            ? LinearProgressIndicator()
            : Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
        Divider(),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.grey[300],
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write a caption......",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width * 0.2,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    alignment: FractionalOffset.topCenter,
                    image: AssetImage('assets/logos/default.png'),
                  )),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Write a contents......",
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
