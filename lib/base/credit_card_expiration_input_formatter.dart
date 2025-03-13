// class CreditCardExpirationDateFormatter extends MaskedInputFormatter {
//   CreditCardExpirationDateFormatter() : super('00/00');
//
//   @override
//   FormattedValue applyMask(String text) {
//     var fv = super.applyMask(text);
//     var result = fv.toString();
//     var numericString = toNumericString(result);
//     var numAddedLeadingSymbols = 0;
//     String? ammendedMonth;
//     if (numericString.length > 0) {
//       var allDigits = numericString.split('');
//       var stringBuffer = StringBuffer();
//       var firstDigit = int.parse(allDigits[0]);
//
//       if (firstDigit > 1) {
//         stringBuffer.write('0');
//         stringBuffer.write(firstDigit);
//         ammendedMonth = stringBuffer.toString();
//         numAddedLeadingSymbols = 1;
//       } else if (firstDigit == 1) {
//         if (allDigits.length > 1) {
//           stringBuffer.write(firstDigit);
//           var secondDigit = int.parse(allDigits[1]);
//           if (secondDigit > 2) {
//             stringBuffer.write(2);
//           } else {
//             stringBuffer.write(secondDigit);
//           }
//           ammendedMonth = stringBuffer.toString();
//         }
//       }
//     }
//     if (ammendedMonth != null) {
//       if (result.length < ammendedMonth.length) {
//         result = ammendedMonth;
//       } else {
//         var sub = result.substring(2, result.length);
//         result = '$ammendedMonth$sub';
//       }
//     }
//     fv = super.applyMask(result);
//
//     /// a little hack to be able to move caret by one
//     /// symbol to the right if a leading zero was added automatically
//     for (var i = 0; i < numAddedLeadingSymbols; i++) {
//       fv.increaseNumberOfLeadingSymbols();
//     }
//     return fv;
//   }
// }
