import 'package:flutter/material.dart';
import 'package:note/widgets/painting/line.dart';
import 'package:note/widgets/smiles/smile.dart';

class CompletelyOkaySmile extends Smile {
  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(width: 5, color: Colors.white)),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 10,
                      width: 12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                    ),
                    Container(
                      height: 10,
                      width: 12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Line(p1: Offset(-11, 10), p2: Offset(11, 10)),
              Line(p1: Offset(-15, 7), p2: Offset(-11, 10)),
              Line(p1: Offset(11, 10), p2: Offset(15, 7)),
            ],
          )
          // Container(
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: backgrounColor,
          //       border: Border.all(color: Colors.white, width: 5)),
          // )
        ],
      ),
    );
  }
}
