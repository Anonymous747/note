import 'package:flutter/material.dart';
import 'package:note/widgets/smiles/smile.dart';

class SuperAwesomeSmile extends Smile {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 8,
                      width: 12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(1),
                              bottomLeft: Radius.circular(1))),
                    ),
                    Container(
                      height: 8,
                      width: 12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(1),
                              bottomLeft: Radius.circular(1))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 40,
                height: 15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
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
