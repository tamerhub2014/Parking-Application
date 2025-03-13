import 'package:flutter_parking_ui_new/app/model/modal_bookmark.dart';
import 'package:flutter_parking_ui_new/app/model/model_category.dart';
import 'package:flutter_parking_ui_new/app/model/model_chat.dart';
import 'package:flutter_parking_ui_new/app/model/model_my_booking.dart';
import 'package:flutter_parking_ui_new/app/model/model_my_card.dart';
import 'package:flutter_parking_ui_new/app/model/model_notification.dart';
import 'package:flutter_parking_ui_new/app/model/model_payment_list.dart';
import 'package:flutter_parking_ui_new/app/model/model_slot_detail.dart';
import 'package:flutter_parking_ui_new/app/model/model_vehicle.dart';

import '../../base/model_review_slider.dart';
import '../model/model_intro.dart';
import '../model/select_vehicale_model.dart';

class DataFile {
  static const int slotAvailable = 1;
  static const int slotUnAvailable = 2;
  static const int slotSelected = 3;

  static List<String> getAllGalleryList() {
    List<String> profileGallery = [
      "gallery1.png",
      "gallery2.png",
      "gallery3.png",
      "gallery4.png",
      "gallery5.png",
      "gallery6.png"
    ];

    return profileGallery;
  }

  static List<ModelPaymentList> getAllPaymentList() {
    List<ModelPaymentList> catList = [];
    // catList.add(ModelPaymentList("Cash", "cash.svg"));
    catList.add(ModelPaymentList("Paypal", "paypal.svg"));
    // catList.add(ModelPaymentList("Google Pay", "Google.svg"));
    catList.add(ModelPaymentList("Master Card", "mastercard.svg"));

    return catList;
  }

  static List<ModelPaymentList> PaymentList() {
    List<ModelPaymentList> catList = [];
    catList.add(ModelPaymentList("Paypal", "paypal.svg"));
    // catList.add(ModelPaymentList("Google Pay", "Google.svg"));
    catList.add(ModelPaymentList("Master Card", "mastercard.svg"));

    return catList;
  }

  static List<ModelPaymentList> getAllPayment() {
    List<ModelPaymentList> catList = [];
    // catList.add(ModelPaymentList("Wallet", "cash.svg"));
    catList.add(ModelPaymentList("Paypal", "paypal.svg"));
    // catList.add(ModelPaymentList("Google Pay", "Google.svg"));
    catList.add(ModelPaymentList("Master Card", "mastercard.svg"));

    return catList;
  }

  static List<ModelBookMark> getMyBookMarks() {
    List<ModelBookMark> catList = [];

    catList.add(ModelBookMark("bookMark1.png", "P23141236738",
        "29 Street Club Town Garden", "20m Right To Parking Spot"));
    catList.add(ModelBookMark(
        "bookMark2.png", "P12141236741", "ParkWise Ventures", "New York, USA"));
    catList.add(ModelBookMark(
        "bookMark3.png", "P12141236741", "AutoNest Spaces", "New York, USA"));
    catList.add(ModelBookMark("bookMark4.png", "P12141236741",
        "Appleton Warren", "45489 Scoville plaza"));
    catList.add(ModelBookMark(
        "bookMark5.png", "P12141236741", "Palmerston lawn", "5458 7th Street"));

    return catList;
  }

  static List<ModelMyCard> getAllMyCardList() {
    List<ModelMyCard> catList = [];

    catList.add(ModelMyCard("Paypal", "paypal.svg", "xxxx xxxx xxxx 5416"));
    catList.add(
        ModelMyCard("Master Card", "mastercard.svg", "xxxx xxxx xxxx 2024"));
    catList.add(ModelMyCard("Visa", "visa.svg", "xxxx xxxx xxxx 1430"));

    return catList;
  }

  static List<ModelChat> getChattingList() {
    List<ModelChat> catList = [];

    catList.add(ModelChat(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
        "2:55 PM",
        false,
        false));
    catList.add(ModelChat(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut",
        "3:02 PM",
        true,
        true));
    catList.add(ModelChat(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit,",
        "4:58 PM",
        false,
        false));

    return catList;
  }

  static List<ModelCategory> getAllCategoryList() {
    List<ModelCategory> catList = [];
    catList.add(ModelCategory("Taxi", "img1.png"));
    catList.add(ModelCategory("Car", "img2.png"));
    catList.add(ModelCategory("Bike", "img3.png"));
    catList.add(ModelCategory("Van", "img4.png"));
    catList.add(ModelCategory("Bus", "img5.png"));
    catList.add(ModelCategory("Police Car", "img6.png"));
    catList.add(ModelCategory("Track", "img7.png"));
    catList.add(ModelCategory("Bicycle", "img8.png"));
    // catList.add(ModelCategory("Taxi", "img9.png"));

    return catList;
  }

  static List<ModelCategory> getAllFacilitiesList() {
    List<ModelCategory> catList = [];
    catList.add(ModelCategory("24*7", "fac1.svg"));
    catList.add(ModelCategory("CCTV", "fac2.svg"));
    catList.add(ModelCategory("Payment", "fac3.svg"));
    catList.add(ModelCategory("Pickup", "fac4.svg"));
    catList.add(ModelCategory("Car wash", "fac5.svg"));
    return catList;
  }

  static List<ModelMyBooking> getAllOnGoingBookings() {
    List<ModelMyBooking> bookList = [];

    bookList.add(ModelMyBooking("homeImage1.png", "29 Street Club Town Garden",
        "\$10 ", "20m Right To Parking Spot", "Parking Ongoing", 10000));

    return bookList;
  }

  static List<ModelMyBooking> getAllHistoryBookings() {
    List<ModelMyBooking> bookList = [];

    bookList.add(ModelMyBooking("homeImage1.png", "29 Street Club Town Garden",
        "\$10 ", "20m Right To Parking Spot", "Parking completed", 1));

    bookList.add(ModelMyBooking("bookMark2.png", "ParkWise Ventures", "\$15 ",
        "New York, USA", "Parking completed", 3));

    bookList.add(ModelMyBooking("bookMark3.png", "\$10 ", "Appleton Warren",
        "New York, USA", "Parking completed", 6));

    return bookList;
  }

  static List<ModelMyBooking> getCancelledBookings() {
    List<ModelMyBooking> bookList = [];

    bookList.add(ModelMyBooking("homeImage1.png", "29 Street Club Town Garden",
        "\$10 ", "20m Right To Parking Spot", "Parking completed", 1));

    bookList.add(ModelMyBooking("homeImage1.png", "ParkWise Ventures", "\$15 ",
        "New York, USA", "Parking completed", 3));

    bookList.add(ModelMyBooking("homeImage1.png", "\$10 ", "Appleton Warren",
        "New York, USA", "Parking completed", 6));

    return bookList;
  }

  static List<ModelSlotDetail> getAllSlotList() {
    List<ModelSlotDetail> slotList = [];

    slotList.add(ModelSlotDetail("G01", slotAvailable));
    slotList.add(ModelSlotDetail("G02", slotUnAvailable));
    slotList.add(ModelSlotDetail("G03", slotUnAvailable));
    slotList.add(ModelSlotDetail("G04", slotAvailable));
    slotList.add(ModelSlotDetail("G05", slotAvailable));
    slotList.add(ModelSlotDetail("G06", slotSelected));
    slotList.add(ModelSlotDetail("G07", slotAvailable));
    slotList.add(ModelSlotDetail("G08", slotAvailable));
    slotList.add(ModelSlotDetail("G09", slotAvailable));
    slotList.add(ModelSlotDetail("G10", slotUnAvailable));

    return slotList;
  }

  static List<ModelSlotDetail> getAllSlotSecList() {
    List<ModelSlotDetail> slotList = [];

    slotList.add(ModelSlotDetail("G11", slotUnAvailable));
    slotList.add(ModelSlotDetail("G12", slotAvailable));
    slotList.add(ModelSlotDetail("G13", slotAvailable));
    slotList.add(ModelSlotDetail("G14", slotAvailable));
    slotList.add(ModelSlotDetail("G15", slotAvailable));
    slotList.add(ModelSlotDetail("G16", slotUnAvailable));
    slotList.add(ModelSlotDetail("G17", slotAvailable));
    slotList.add(ModelSlotDetail("G18", slotUnAvailable));
    slotList.add(ModelSlotDetail("G19", slotUnAvailable));
    slotList.add(ModelSlotDetail("G20", slotUnAvailable));

    return slotList;
  }

  static List<String> getAllCollectionListList() {
    List<String> profileGallery = [
      "add_image.png",
      "collect1.png",
      "collect2.png",
      "collect3.png",
      "collect4.png",
      "collect5.png",
      "collect6.png",
      "collect7.png",
    ];

    return profileGallery;
  }

  static List<String> getAllFloorList() {
    List<String> profileGallery = ["Ground Floor", "1st Floor", "2nd Floor"];

    return profileGallery;
  }

  static List<ModelIntro> introList = [
    ModelIntro(
        1,
        "Find parking place around your easily",
        "Instantly discover available parking spaces nearby with a simple tap on your phone.",
        "intro1.png"),
    ModelIntro(2, "Perfect solution to your parking problems",
        "Our app ensures a stress-free\nexperience every time.", "intro2.png"),
    ModelIntro(2, "Pay for your parking easily with us",
        "Pay for your parking using various\npayment methods.", "intro3.png")
  ];

  static List<ModelIntro> getAllOfferList() {
    List<ModelIntro> getOfferList = [
      ModelIntro(
          1,
          "Fresh Grocery\nFor You",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
          "intro1.png"),
      ModelIntro(
          2,
          "Choose From Our\nBest Menu",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
          "intro2.png"),
      ModelIntro(
          2,
          "Quick Delivery At\nYour Doorstep",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
          "intro3.png")
    ];
    return getOfferList;
  }

  static List<ModelNotification> getAllNotification() {
    List<ModelNotification> list = [];

    list.add(ModelNotification("Today", [
      NotificationDetail(
          "10 Minutes Remaining",
          "Lorem ipsum dolor sit amet, consectetur.",
          "notification_success.png"),
      NotificationDetail("Booking Successful!",
          "Parking booking at Portley was succ...", "notification_success.png"),
      NotificationDetail("Booking Canceld",
          "Parking booking at Portley was succ...", "notification_success.png"),
    ]));

    list.add(ModelNotification("Yesterday", [
      NotificationDetail(
          "10 Minutes Remaining",
          "Lorem ipsum dolor sit amet, consectetur.",
          "notification_success.png"),
      NotificationDetail("Booking Canceld",
          "Parking booking at Portley was succ...", "notification_success.png"),
      NotificationDetail("Slot Review Reqest",
          "Parking booking at Portley was succ...", "notification_success.png"),
    ]));

    return list;
  }

  static List<ModelReviewSlider> getOption() {
    return [
      ModelReviewSlider("Address", "checkout_address.svg"),
      ModelReviewSlider("Payment", "checkout_payment.svg"),
      ModelReviewSlider("Confirm", "checkout_confirm.svg")
    ];
  }

  static List<ModelVehicle> getAllVehicles() {
    List<ModelVehicle> vehicleList = [];

    vehicleList
        .add(ModelVehicle("Toyota  Land Cruiser", "AFD 6397", "vehicle1.png"));
    vehicleList.add(ModelVehicle("KIA SELTOS", "HUC 2957", "vehicle2.png"));
    vehicleList.add(ModelVehicle("Honda City", "GTK 6294", "vehicle3.png"));

    return vehicleList;
  }

  static List<SelectVehicleModel> getSelectVehicleList() {
    List<SelectVehicleModel> selectVehicleList = [];

    selectVehicleList.add(SelectVehicleModel(
      text: "Taxi",
      image: "img1.png",
    ));
    selectVehicleList.add(SelectVehicleModel(
      text: "Car",
      image: "img2.png",
    ));
    selectVehicleList.add(SelectVehicleModel(
      text: "Bike",
      image: "img3.png",
    ));
    selectVehicleList.add(SelectVehicleModel(
      text: "Van",
      image: "img4.png",
    ));
    selectVehicleList.add(SelectVehicleModel(
      text: "Bus",
      image: "img5.png",
    ));
    selectVehicleList.add(SelectVehicleModel(
      text: "Police car",
      image: "img6.png",
    ));
    selectVehicleList.add(SelectVehicleModel(
      text: "Bicycle",
      image: "img8.png",
    ));

    return selectVehicleList;
  }
}
