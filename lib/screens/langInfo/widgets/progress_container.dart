import 'package:codeline_students_app/screens/genral_screen/data_entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget progressContainer({intialValue, child, collection}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: Get.height / 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xff56bece),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Get.to(DataEntry(
              collection: collection,
            )),
            child: Container(
                alignment: Alignment.center,
                height: Get.height / 12,
                width: Get.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Color(0xff17A2B8),
                ),
                child: child),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 27,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 8,
                width: Get.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 8,
                  width: (Get.width / 2) * intialValue / 100,
                  decoration: BoxDecoration(
                    color: Color(0xff84FAB0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.topRight,
            child: Text(
              "${intialValue.ceil().toString()}%",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
}
