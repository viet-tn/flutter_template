import 'package:flutter/material.dart';

import '../../constants/ui/ui.dart';

List<Widget> listDivideItems({
  required List<Widget> children,
  Widget divider = CGaps.divider,
  bool dividerIsFirstItem = false,
}) {
  if (children.isEmpty || (!dividerIsFirstItem && children.length == 1)) {
    return children;
  }

  if (dividerIsFirstItem) {
    return <Widget>[
      ...children.take(children.length).expand((element) => [divider, element]),
      divider,
    ];
  } else {
    return <Widget>[
      ...children
          .take(children.length - 1)
          .expand((element) => [element, divider]),
      children.last,
    ];
  }
}
