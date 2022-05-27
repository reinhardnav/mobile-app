import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capex_mobile/providers/ProfileAuthentication.dart';
import 'package:capex_mobile/router.dart';
import 'package:capex_mobile/styles/theme_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ProfileAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeScheme.light(),
        initialRoute: WalkthroughRoute,
      ),
    ),
  );
}
