import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capex_mobile/providers/ProfileAuthentication.dart';
import 'package:capex_mobile/router.dart';
import 'package:capex_mobile/widgets/walkthrough_stepper.dart';
import 'package:capex_mobile/widgets/walkthrough_template.dart';

import '../router.dart';

class WalkThrough extends StatelessWidget {
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final ProfileAuth _walkthroughProvider =
        Provider.of<ProfileAuth>(context, listen: false);

    print(_walkthroughProvider.isAuthentificated);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (int index) {
                    _walkthroughProvider.onPageChange(index);
                  },
                  children: <Widget>[
                    WalkThroughTemplate(
                      title: "Locate Your Cargo Realtime",
                      subtitle:
                          "I know this is crazy, buy i tried something fresh, I hope you love it.",
                      image: Image.asset("assets/images/walkthrough1.png"),
                    ),
                    WalkThroughTemplate(
                      title: "Get latest Promos!",
                      subtitle: "The More You Book The more Points You Get",
                      image: Image.asset("assets/images/walkthrough2.png"),
                    ),
                    WalkThroughTemplate(
                      title: "Experience Realtime Booking",
                      subtitle:
                          "I know this is crazy, buy i tried something fresh, I hope you love it.",
                      image: Image.asset("assets/images/walkthrough3.png"),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:
                          WalkthroughStepper(controller: _pageViewController),
                    ),
                    ClipOval(
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: Icon(
                            Icons.trending_flat,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_pageViewController.page >= 2) {
                              Navigator.of(context)
                                  .pushReplacementNamed(RootPageLink);
                              return;
                            }
                            _pageViewController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          padding: EdgeInsets.all(13.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
