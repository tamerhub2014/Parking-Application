import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/booking/booking_confirmation.dart';
import 'package:flutter_parking_ui_new/app/booking/booking_detail.dart';
import 'package:flutter_parking_ui_new/app/booking/extend_time_screen.dart';
import 'package:flutter_parking_ui_new/app/booking/parking_ticket_screen.dart';
import 'package:flutter_parking_ui_new/app/booking/parking_time_screen.dart';
import 'package:flutter_parking_ui_new/app/detail/chat_screen.dart';
import 'package:flutter_parking_ui_new/app/detail/choose_parking_slot_screen.dart';
import 'package:flutter_parking_ui_new/app/detail/choose_vehicle_screen.dart';
import 'package:flutter_parking_ui_new/app/detail/gallery_screen.dart';
import 'package:flutter_parking_ui_new/app/detail/parking_detail.dart';
import 'package:flutter_parking_ui_new/app/detail/select_date_time_screen.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_parking_ui_new/app/home/home_screen.dart';
import 'package:flutter_parking_ui_new/app/login/screen_change_pass.dart';
import 'package:flutter_parking_ui_new/app/login/screen_check_mail.dart';
import 'package:flutter_parking_ui_new/app/login/screen_forgot_pass.dart';
import 'package:flutter_parking_ui_new/app/login/screen_login.dart';
import 'package:flutter_parking_ui_new/app/login/screen_sign_up.dart';
import 'package:flutter_parking_ui_new/app/login/screen_verify.dart';
import 'package:flutter_parking_ui_new/app/payment/payment_card_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/help_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/my_cards_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/my_profile_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/my_vehicle_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/notification_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/select_vehicle_screen.dart';
import 'package:flutter_parking_ui_new/app/profile/setting_screen.dart';

import '../home/data/models/parking_model.dart';
import '../home/data/models/parking_ticket.dart';
import '../intro/intro.dart';
import '../payment/choose_payment_method_screen.dart';
import '../view/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.introRoute: (context) => const IntroView(),
    Routes.signUpRoute: (context) => const ScreenSignUp(),
    Routes.loginRoute: (context) => const ScreenLogin(),
    Routes.forgotPassRoute: (context) => const ScreenForgotPass(),
    Routes.checkMailScreenRoute: (context) => ScreenCheckMail(),
    Routes.verifyCodeRoute: (context) => const ScreenVerify(),
    Routes.changePassRoute: (context) => const ScreenChangePass(),
    Routes.homeScreenRoute: (context) => HomeScreen(),
    Routes.locationDetailScreenRoute: (context) {
      final parkingModel =
          ModalRoute.of(context)?.settings.arguments as ParkingModel;

      return ParkingDetailScreen(parking: parkingModel);
    },
    Routes.galleryScreenRoute: (context) => GalleryScreen(),
    Routes.dateTimeSelectorScreen: (context) => SelectDateTimeScreen(),
    Routes.chooseParkingSlotScreen: (context) {
      final ParkingTicketBody ticketBody =
          ModalRoute.of(context)?.settings.arguments as ParkingTicketBody;

      return ChooseParkingSlotScreen(parkingTicket: ticketBody);
    },
    Routes.choosePaymentMethodScreen: (context) => ChoosePaymentMethodScreen(),
    Routes.paymentCardScreen: (context) {
      final body =
          ModalRoute.of(context)?.settings.arguments as ParkingTicketBody;

      return PaymentCardScreen(parkingTicketBody: body);
    },
    Routes.bookingConfirmationScreen: (context) => BookingConfirmation(),
    Routes.parkingTicketScreen: (context) {
      final body =
          ModalRoute.of(context)?.settings.arguments as ParkingTicketBody;

      return ParkingTicketScreen(ticket: body);
    },
    Routes.parkingTimeScreen: (context) {
      final ticket =
          ModalRoute.of(context)?.settings.arguments as ParkingTicket;

      return ParkingTimeScreen(ticket: ticket);
    },
    Routes.extendTimeScreen: (context) {
      final ticket =
          ModalRoute.of(context)?.settings.arguments as ParkingTicket;

      return ExtendTimeScreen(ticket: ticket);
    },
    Routes.bookingDetailScreen: (context) => BookingDetail(),
    Routes.myProfileScreen: (context) => MyProfileScreen(),
    Routes.notificationScreen: (context) => NotificationScreen(),
    Routes.myVehicleScreen: (context) => SelectVehicleScreen(),
    Routes.selectVehicleScreen: (context) => MyVehicleScreen(),
    Routes.myCardsScreen: (context) => MyCardsScreen(),
    Routes.settingScreen: (context) => SettingScreen(),
    Routes.helpScreen: (context) => HelpScreen(),
    Routes.chatScreen: (context) => ChatScreen(),
    Routes.chooseVehicleScreen: (context) => ChooseVehicleScreen(),
  };
}
