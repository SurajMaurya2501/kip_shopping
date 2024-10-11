import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kip_shooping/widgets/custom_button.dart';

Color blue = const Color(0xFF3D5CFF);
Color grey = const Color(0xFF858597);

void customLoading(BuildContext context, String text) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
              5.0,
            )),
            child: Material(
              child: Dialog(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      text,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void successDialogue(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                "assets/svg/verified.svg",
                fit: BoxFit.cover,
              ),
              const Text(
                "Success",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "Congratulations, you have\ncompleted your registration!",
                style: TextStyle(color: grey,
                ),
              ),
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: "Done",
                isWhiteColor: false,
                width: double.infinity,
              )
            ],
          ),
        ),
      );
    },
  );
}



