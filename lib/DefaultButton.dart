import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press, this.color, this.loading,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final Color? color;
  final bool?  loading;

  @override
  Widget build(BuildContext context) {
    bool _loading = loading?? false;
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      child: (_loading)?Center(child: CircularProgressIndicator(),) :TextButton(
        style: TextButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.white,
          backgroundColor: color??Colors.green,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style:const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
