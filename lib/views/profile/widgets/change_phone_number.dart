import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/views/login/validator.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  late TextEditingController phone;
  late TextEditingController newPhone;
  @override
  void initState() {
    super.initState();
    phone = TextEditingController(
        text: context.read<UserProvider>().currentUser!.phoneNumber.toString());
    newPhone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: MediaQuery.of(context).viewInsets.bottom > 0 ? 1 : 0.7,
      expand: false,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Change Phone Number".toUpperCase(),
              style: title.copyWith(color: Colors.white70, fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              child: Icon(
                Icons.phone,
                color: primaryColor,
                size: 150,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    "Old phone number : ",
                    style: textbody1,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.45,
                  height: 40,
                  child: CupertinoTextField(
                    controller: phone,
                    style: textbody1,
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 1)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    "New phone number : ",
                    style: textbody1,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.45,
                  height: 40,
                  child: CupertinoTextField(
                    controller: newPhone,
                    style: textbody1,
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.only(top: 10),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 8,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 1)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                  ),
                  onPressed: () =>
                      validatorPhone(context, phone.text, newPhone.text),
                  child: SizedBox(
                    width: 170,
                    child: Center(
                      child: Text(
                        "Update Phone number",
                        style: textbody1,
                      ),
                    ),
                  )),
            )
          ],
        )),
      ),
    );
  }
}