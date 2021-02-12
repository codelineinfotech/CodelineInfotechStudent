import 'package:codeline_students_app/resource/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class CommanWidget {
  static Widget circularProgress() {
    return Container(
      color: Colors.black38,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(ColorsPicker.skyColor),
      )),
    );
  }

  static Widget imageProfileView(
      {String imageUrl,
      double imageHeight,
      double imageWidth,
      String decoration}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: imageHeight,
        width: imageWidth,
        child: imageUrl != null && imageUrl != ""
            ? OctoImage(
                fit: BoxFit.fill,
                imageBuilder: OctoImageTransformer.circleAvatar(),
                image: NetworkImage(imageUrl),
                placeholderBuilder:
                    OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                errorBuilder: OctoError.icon(color: Colors.red),
              )
            : Image.asset("assets/images/profile.png"),
        decoration: decoration == "NoDecoration"
            ? BoxDecoration()
            : BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 5),
              ),
      ),
    );
  }
}
