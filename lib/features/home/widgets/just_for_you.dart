import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cherry_mvp/core/config/config.dart';
import 'package:cherry_mvp/core/utils/utils.dart';
import 'package:cherry_mvp/core/reusablewidgets/reusablewidgets.dart';
import 'package:cherry_mvp/features/home/widgets/just_for_you_card.dart';

class JustForYou extends StatefulWidget {
  const JustForYou({super.key});

  @override 
  JustForYouState createState() => JustForYouState();
}

class JustForYouState extends State<JustForYou> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0, bottom: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),

          // first child of column
          Padding(
            padding: const EdgeInsets.only(
              top: 0.0,
              left: 5.0,
              right: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // first child of row
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    left: 0.0,
                  ),
                  child: Text(
                    AppStrings.justForYouText,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                ),
                // End first child of row

                // second child of row
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    left: 0.0,
                  ), 

                  child: IconButton(
                    icon: ClipRRect(
                      // borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        width: 30, // Set width
                        height: 30, // Set height
                        AppImages.icButton,
                        fit: BoxFit.fill,
                      ),
                    ),
                    onPressed: () {
                      // print("Icon Button Pressed");
                    },
                  ),
                ),
                // End second child of row
              ],
            ),
          ),
          // End first child of column

          // second child of column
          /* Padding(
            padding: const EdgeInsets.only(
              // top: 0.0,
              left: 0.0,
            ),*/
            // child: Row(
              // children: [
                // 
                // JustForYouCard(), 
              Container(
                width: 600, // Set width
                // height: MediaQuery.of(context).size.height, // Set height 
                height:320,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    // childAspectRatio: 1, // Adjust the size ratio of items
                    childAspectRatio: 0.9, // Adjust the size ratio of items
                  ),
                  itemCount: 4, // Number of items
                  itemBuilder: (context, index) {
                    return /* Container(
                      color: Colors.green,
                      child: Center(child: Text("Item $index", style: TextStyle(color: Colors.white))),
                    ); */
                    JustForYouCard();
                  }
                ),
                //
              // ],
            ),
          // ),
          // End second child of column
        ],
      ),
    );
  }
}
