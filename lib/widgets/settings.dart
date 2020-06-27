import 'package:Aerar/generated/l10n.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: RaisedButton(
                child: Text(S.of(context).aboutDialog),
                onPressed: () {
                  showAboutDialog(context: context);
                })));
  }
}
