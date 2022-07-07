import 'package:flutter/material.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/widgets/primary_btn.dart';

Future<dynamic> popup(BuildContext context, String confirmText,
    {String? title, String? description, Function? confirmFunction}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, stating) {
          // final tm = SizeConfig.textMultiplier;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.5 * 5.0)),
            child: SizedBox(
              height: 1.5 * 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (title != null)
                    Positioned(
                      top: 1.5 * 6,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            1.5 * 2.5, 1.5 * 1, 1.5 * 2.5, 1.5 * 3),
                        child: Container(
                          width: 1.5 * 60,
                          height: 1.5 * 10,
                          color: Colors.white,
                          child: Text(
                            title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: text18black.copyWith(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  if (description != null)
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 1.5 * 2),
                        width: 1.5 * 60,
                        height: 1.5 * 10,
                        color: Colors.white,
                        child: Text(
                          description,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: text18black.copyWith(fontSize: 19),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 1.5 * 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        primaryButton(
                            context: context,
                            height: 1.5 * 5,
                            width: 1.5 * 30,
                            borderRadius: BorderRadius.circular(1.5 * 4),
                            border: Border.all(
                                color: Colors.grey, width: 1.5 * 0.2),
                            color: Colors.white,
                            function: () => Navigator.pop(context),
                            widget: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1.5 * 2),
                                child: Text(
                                  "Cancel",
                                  style: text18black.copyWith(fontSize: 20),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 1.5 * 4,
                        ),
                        primaryButton(
                            context: context,
                            height: 1.5 * 5.0,
                            width: 1.5 * 30,
                            borderRadius: BorderRadius.circular(1.5 * 4),
                            widget: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1.5 * 2),
                                child: Text(
                                  confirmText,
                                  style: text18white.copyWith(fontSize: 20),
                                ),
                              ),
                            ),
                            function: () {
                              if (confirmFunction != null) {
                                confirmFunction();
                              } else {
                                Navigator.pop(context);
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
