import 'package:flutter/material.dart';

class  CustomRowTitle extends StatelessWidget {
  final String title;
  void Function()? onTap;
   CustomRowTitle({super.key,required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(
          left: 10, right: 10, bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: const [
                Text(
                  'See More ',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
