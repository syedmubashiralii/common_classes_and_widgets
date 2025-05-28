import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}
class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    try {
      switch (state) {
        // If app is in paused state.
        case AppLifecycleState.paused:
          debugPrint("App paused");
          // Implement your code here
          break;
          
        // If app is in resumed state.
        case AppLifecycleState.resumed:
          debugPrint("App resumed");
          // Implement your code here
          break;
        // If app is in detached state.
        case AppLifecycleState.detached:
          debugPrint("App detached");
          // Implement your code here
          break;
        // If app is in inactive state.
        case AppLifecycleState.inactive:
          debugPrint("App inactive");
          // Implement your code here
          break;
          
        default:
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) => widget.child;
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}