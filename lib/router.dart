import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capex_mobile/screens/add_card.dart';
import 'package:capex_mobile/screens/chat_rider.dart';
import 'package:capex_mobile/screens/country_select.dart';
import 'package:capex_mobile/screens/destination_view.dart';
import 'package:capex_mobile/screens/favorites.dart';
import 'package:capex_mobile/screens/home.dart';
import 'package:capex_mobile/screens/login.dart';
import 'package:capex_mobile/root_page.dart';
import 'package:capex_mobile/screens/my_rides.dart';
import 'package:capex_mobile/screens/otp_verification.dart';
import 'package:capex_mobile/screens/payment.dart';
import 'package:capex_mobile/screens/phone_registration.dart';
import 'package:capex_mobile/screens/profile.dart';
import 'package:capex_mobile/screens/promotions.dart';
import 'package:capex_mobile/screens/register.dart';
import 'package:capex_mobile/screens/suggested_rides.dart';
import 'package:capex_mobile/screens/unauth.dart';
import 'package:capex_mobile/screens/update_favorite.dart';
import 'package:capex_mobile/screens/update_information.dart';
import 'package:capex_mobile/screens/walkthrough.dart';
import 'package:capex_mobile/services/authentication.dart';
import 'package:capex_mobile/screens/login_signup_page.dart';


// Routes
// const String HomePageRoute = "/";
const String WalkthroughRoute = "/";
const String RegisterRoute = "register";
const String LoginRoute = "login";
const String RootPageLink = "root-page";
const String LoginPage = "login-page";

const String PhoneRegisterRoute = "phone-register";
const String OtpVerificationRoute = "otp-verification";
const String UpdateInformationRoute = "update-information";
const String SelectCountryRoute = "country-select";
const String HomepageRoute = "homepage";
const String DestinationRoute = "destination";
const String UnAuthenticatedPageRoute = "unauth";
const String ProfileRoute = "profile";
const String PaymentRoute = "payment";
const String AddCardRoute = "addCard";
const String ChatRiderRoute = "chatRider";
const String FavoritesRoute = "favorite";
const String UpdateFavoritesRoute = "update-favorite";
const String PromotionRoute = "promotion";
const String SuggestedRidesRoute = "suggested-route";
const String MyRidesRoute = "my-rides";

BaseAuth auth;

// Router
Route<dynamic> onGenerateRoute(RouteSettings settings){


 

  switch (settings.name) {
    case WalkthroughRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WalkThrough());
    case RegisterRoute:
      return MaterialPageRoute(builder: (BuildContext context) => RegisterPage(auth: new Auth()));
    case LoginRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Login());
    case RootPageLink:
      return MaterialPageRoute( builder: (BuildContext context) => RootPage(auth: new Auth()));
    case LoginPage:
      return MaterialPageRoute(
          builder: (BuildContext context) => LoginSignupPage());
    case PhoneRegisterRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PhoneRegistration());
    case OtpVerificationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => OtpVerification());
    case UpdateInformationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => UpdateInformation());
    case SelectCountryRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SelectCountry());
    case HomepageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Homepage(auth: new Auth()));
    case DestinationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DestinationView());
    case UnAuthenticatedPageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => UnAuth());
    case ProfileRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Profile());
    case PaymentRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Payment());
    case AddCardRoute:
      return MaterialPageRoute(builder: (BuildContext context) => AddCard());
    case ChatRiderRoute:
      return MaterialPageRoute(builder: (BuildContext context) => ChatRider());
    case FavoritesRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Favorites());
    case PromotionRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Promotions());
    case UpdateFavoritesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => UpdateFavorite());
    case SuggestedRidesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SuggestedRides());
    case MyRidesRoute:
      return MaterialPageRoute(builder: (BuildContext context) => MyRides());
    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => WalkThrough());
  }
}
