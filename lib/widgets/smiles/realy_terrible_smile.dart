import 'package:flutter/material.dart';
import 'package:note/widgets/painting/line.dart';
import 'package:note/widgets/smiles/smile.dart';

class RealyTerribleSmile extends Smile {
  final Color smileColor;

  const RealyTerribleSmile({this.smileColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(width: 5, color: smileColor)),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 7,
                        width: 13,
                        decoration: BoxDecoration(
                            color: smileColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ))),
                    Container(
                        height: 6,
                        width: 13,
                        decoration: BoxDecoration(
                            color: smileColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            )))
                  ],
                ),
              ),
              Line(p1: Offset(-15, 15), p2: Offset(10, 20)),
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
