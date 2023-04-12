import 'package:flutter/material.dart';

class CustomOneMovieTv extends StatelessWidget {
 final String image;
  void Function()? onTap;

 CustomOneMovieTv({super.key, required this.image,required this.onTap});

  @override
  Widget build(BuildContext context) {
    var mqWidth = MediaQuery.of(context).size.width;
    return  Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(10)),
          ),
          width: mqWidth / 3.5,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(
                  Radius.circular(10)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
