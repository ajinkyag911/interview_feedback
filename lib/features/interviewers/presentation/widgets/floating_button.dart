import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key key, this.text, this.icon, this.onPressed})
      : super(key: key);
  final String text;
  final Icon icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff12873b),
          ),
          color: Color(0xff12873b),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 110.0,
      height: 50.0,
      child: new RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: 8,
            ),
            icon
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
