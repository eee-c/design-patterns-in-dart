import 'dart:html' show query;

main() {
  var bottom = query('#bottom'),
    middle = query('#middle'),
    top = query('#top');

  bottom.onClick.listen((e){
    if (e.ctrlKey) return;
    if (e.shiftKey) return;

    bottom.style.border =
      bottom.style.border.contains('green') ?
        '' : '3px green dashed';
    e.stopPropagation();
  });

  middle.onClick.listen((e){
    if (e.ctrlKey) return;

    middle.style.border =
      middle.style.border.contains('blue') ?
        '' : '3px blue dashed';
    e.stopPropagation();
  });

  top.onClick.listen((_){
    top.style.border =
      top.style.border.contains('orange') ?
        '' : '3px orange dotted';
  });
}
