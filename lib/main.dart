import 'package:flutter/material.dart';
import 'package:nic_validation/Presentation/view/common/error_msg.dart';
import 'package:nic_validation/Presentation/view/home_page.dart';
import 'package:nic_validation/Presentation/view/nic_validation.dart';
import 'package:sizer/sizer.dart';

import 'Presentation/view/Session_Managment/session_config.dart';
import 'Presentation/view/Session_Managment/session_timeout.dart';
import 'Presentation/view/nic_check_ml.dart';
import 'package:functional_listener/functional_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 15),
        invalidateSessionForUserInactiviity: const Duration(seconds: 30));

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        showAlert(context, "user  inactive timeout");
        // handle user  inactive timeout
        //Navigator.of(context).pop();
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        showAlert(context, "app lost focus timeout");
        // handle user  app lost focus timeout
        // Navigator.of(context).pushNamed("/auth");
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
        child: GestureDetector(onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
    }, child: Sizer(builder:
          (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            //brightness: Brightness.dark,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
                .copyWith(secondary: Colors.pink),
          ),
          home: NicMlValidation(),
        );
    })),
      );
  }
}
