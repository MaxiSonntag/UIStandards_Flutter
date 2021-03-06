import 'package:flutter/material.dart';

class ImagesInApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Text("This image is included in this app", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          AspectRatio(
            aspectRatio: 16/9,
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    child: _getImage(),
                    flex: 8,
                  ),
                  Flexible(
                    child: Container(),
                    flex: 1,
                  )
                ],
              ),
            )
          )

        ],
      ),
    );
  }

  Widget _getImage(){
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(8.0),
      child: Image.asset('sample_images/DSC_1.jpg', fit: BoxFit.cover),
    );
  }
}