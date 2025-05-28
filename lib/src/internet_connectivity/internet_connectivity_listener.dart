import 'package:commons_classes_functions/src/internet_connectivity/internet_connectivity_service.dart';
import 'package:commons_classes_functions/src/internet_connectivity/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: InternetConnectivityService.connectivityStream,
      builder: (context, snapshot) {
        final isConnected =
            !(snapshot.data?.contains(ConnectivityResult.none) ?? true);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!isConnected) {
            // Navigate to No Internet Screen if disconnected
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const NoInternetScreen(),
              allowSnapshotting: false
            ));
          } else {
            // Pop No Internet Screen if connected
            if (Navigator.canPop(context)) Navigator.pop(context);
          }
        });

        return child;
      },
    );
  }
}