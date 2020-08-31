import 'package:flutter/material.dart';
import 'package:note/widgets/smiles/smile.dart';

class SomewhatBadSmile extends Smile {
  final Color smileColor;

  const SomewhatBadSmile({this.smileColor = Colors.white});

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
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          color: smileColor, shape: BoxShape.circle),
                    ),
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          color: smileColor, shape: BoxShape.circle),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 25,
                height: 15,
                decoration: BoxDecoration(
                    color: smileColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
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
