import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:capex_mobile/styles/colors.dart';
import 'package:capex_mobile/widgets/custom_text_form_field.dart';

class ChatRider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      padding: BubbleEdges.all(15.0),
      margin: BubbleEdges.only(top: 8.0, bottom: 12.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: _theme.primaryColor,
      padding: BubbleEdges.all(15.0),
      margin: BubbleEdges.only(top: 8.0, bottom: 12.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 10.0),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                title: Container(
                  padding: EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Text(
                    "KAP ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: dbasicDarkColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                subtitle: Text(
                  "Customer Support",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                trailing: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "https://www.pngitem.com/pimgs/m/537-5372558_flat-man-icon-png-transparent-png.png"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(
                  15.0,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Today at 5:03 PM",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Bubble(
                      style: styleMe,
                      child: Text(
                        "Hello, how can I help you?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Bubble(
                      style: styleSomebody,
                      child: Text(
                        "Hi, what time will be the truck arrived?.",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Bubble(
                      style: styleMe,
                      child: Text(
                        "Let me check on that",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
            Container(
              height: 120.0,
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CustomTextFormField(
                      hintText: "Enter a message...",
                      showLabel: false,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.send,
                    color: _theme.primaryColor,
                    size: 35.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
