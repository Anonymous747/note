import 'package:flutter/material.dart';
import 'package:note/widgets/smiles/smile.dart';

class PrettyGoodSmile extends Smile {
  final Color smileColor;

  const PrettyGoodSmile({this.smileColor = Colors.white});

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
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 10,
                      width: 12,
                      decoration: BoxDecoration(
                          color: smileColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                    ),
                    Container(
                      height: 10,
                      width: 12,
                      decoration: BoxDecoration(
                          color: smileColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                    )
                  ],
                ),
              ),
              Container(
                width: 30,
                height: 15,
                decoration: BoxDecoration(
                    color: smileColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
              )
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
