import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomStackTv extends StatelessWidget {
  final String image;
  final String title;
  final String movieName;


  const CustomStackTv({super.key,
    required  this.image,
    required this.title,
    required  this.movieName
});

  @override
  Widget build(BuildContext context) {
    var mqHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top-10;
    var mqWidth = MediaQuery.of(context).size.width;
    return  SizedBox(
      width: mqWidth,
      height: mqHeight / 2,
      child:
      Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration:  const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black26,
                      Color(0xff303030),
                      // Colors.black,
                    ])),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.redAccent,
                        size: 16,
                      ),
                      Text(
                        ' $title'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieName,
                      style: const TextStyle(
                          fontSize: 30, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
