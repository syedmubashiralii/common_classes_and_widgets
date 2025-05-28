
extension ConvertFlag on String {
  String get toFlag {

    return  (this).toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}
// Text("IN".toFlag.toString(), style:  const TextStyle(fontSize: 50),),
//example usage in a widget