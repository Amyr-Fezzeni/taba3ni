
import 'package:flutter/material.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/widgets/primary_btn.dart';


Future<dynamic> popup(BuildContext context, String confirmText,{String? title,String? description,Function? confirmFunction}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context,stating) {
              final hm = SizeConfig.heightMultiplier;
              final wm = SizeConfig.widthMultiplier;
              final tm = SizeConfig.textMultiplier;
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(wm!*5.0)),
                child: SizedBox(
                  height: hm!*35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if(title != null)
                        Positioned(
                          top:hm*6,
                          child: Padding(
                            padding:  EdgeInsets.fromLTRB(
                                wm*2.5,
                                hm*1,
                                wm*2.5,
                                hm*3
                            ),
                            child: Container(
                              width: wm*60,
                              height: hm*10,
                              color: Colors.white,
                              child: Text(title,maxLines: 2,textAlign: TextAlign.center,style: text18black.copyWith(fontSize: wm*2.5),),
                            ),
                          ),
                        ),
                      if(description != null)
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: hm*2),
                            width: wm*60,
                            height: hm*10,
                            color: Colors.white,
                            child: Text(description,maxLines: 2,textAlign: TextAlign.center,style: text18black.copyWith(fontSize: wm*2.2),),
                          ),
                        ),

                      Positioned(
                        bottom: hm*4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        
                            primaryButton(context:context,height: hm*5, width: wm*30,
                                borderRadius: BorderRadius.circular(wm*4),
                                border: Border.all(color: Colors.grey,width: wm*0.2),
                                color: Colors.white,
                                widget: FittedBox(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: wm*2),
                                    child: Text("Cancel",style:text18black,),
                                  ),
                                )),
                            SizedBox(width: wm*4,),
                            primaryButton(context:context,height: hm*5.0, width: wm*30,borderRadius: BorderRadius.circular(wm*4),widget: FittedBox(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: wm*2),
                                child: Text(confirmText,style: text18white,),
                              ),
                            ),function: (){
                              if(confirmFunction!=null){
                                confirmFunction();
                              }else{
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
            }
        );
      });
}
