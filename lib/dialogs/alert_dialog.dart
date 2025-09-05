import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/values/dimen.dart';
import 'package:mandir/widget/widgets.dart';

class MyAlertDialog {
  bool shoeIcon = true;
  double _cornersRound = 20;
  String _iconImage = '';
  double _iconSize = 34;
  String _title = '';
  String _message = '';
  double _titleTextSize = fontSizeLarge;
  Color _titleTextColor = ThemeColors.defaultTextColor;
  Color _messageTextColor = ThemeColors.defaultTextColor;
  Color _buttonsTextColor = ThemeColors.defaultTextColor;
  bool _html = false;
  bool _cancelable = true;
  String _negativeButtonText = '';
  String _neutralButtonText = '';
  String _positiveButtonText = '';
  bool _textSelectable = false;
  void Function()? _positiveClickListener;
  void Function()? _negativeClickListener;
  void Function()? _neutralClickListener;
  Alignment _buttonAlignment = Alignment.centerRight;
  Alignment _titleAlignment = Alignment.centerLeft;
  Alignment _messageAlignment = Alignment.centerLeft;
  double _firstSpacing = 15;
  double _secondSpacing = 10;

  MyAlertDialog();

  MyAlertDialog setIcon(String _iconImage) {
    this._iconImage = _iconImage;
    return this;
  }

  MyAlertDialog disableIcon() {
    this.shoeIcon = false;
    return this;
  }

  MyAlertDialog setIconSize(double iconSize) {
    this._iconSize = iconSize;
    return this;
  }

  MyAlertDialog setCornersRound(double cornersRound) {
    this._cornersRound = cornersRound;
    return this;
  }

  MyAlertDialog setFirstSpacing(double space) {
    this._firstSpacing = space;
    return this;
  }

  MyAlertDialog setSecondSpacing(double space) {
    this._secondSpacing = space;
    return this;
  }

  MyAlertDialog setButtonAlignment(Alignment buttonAlignment) {
    this._buttonAlignment = buttonAlignment;
    return this;
  }

  MyAlertDialog setTitleAlignment(Alignment titleAlignment) {
    this._titleAlignment = titleAlignment;
    return this;
  }

  MyAlertDialog setMessageAlignment(Alignment messageAlignment) {
    this._messageAlignment = messageAlignment;
    return this;
  }

  MyAlertDialog setTextSelectable() {
    this._textSelectable = true;
    return this;
  }

  MyAlertDialog setTitle(String title) {
    this._title = title;
    return this;
  }

  MyAlertDialog setTitleTextSize(double titleTextSize) {
    this._titleTextSize = titleTextSize;
    return this;
  }

  MyAlertDialog setMessage(String message) {
    this._message = message;
    return this;
  }

  MyAlertDialog setPositiveButton(String text, [void Function()? positiveClickListener]) {
    _positiveButtonText = text;
    this._positiveClickListener = positiveClickListener;
    return this;
  }

  MyAlertDialog setNeutralButton(String text, [void Function()? neutralClickListener]) {
    this._neutralButtonText = text;
    this._neutralClickListener = neutralClickListener;
    return this;
  }

  MyAlertDialog setNegativeButton(String text, [void Function()? negativeClickListener]) {
    _negativeButtonText = text;
    this._negativeClickListener = negativeClickListener;
    return this;
  }

  MyAlertDialog setTitleTextColor(Color titleTextColor) {
    this._titleTextColor = titleTextColor;
    return this;
  }

  MyAlertDialog setMessageTextColor(Color messageTextColor) {
    this._messageTextColor = messageTextColor;
    return this;
  }

  MyAlertDialog setButtonsTextColor(Color buttonsTextColor) {
    this._buttonsTextColor = buttonsTextColor;
    return this;
  }

  MyAlertDialog setDialogCancelable(bool cancelable) {
    this._cancelable = cancelable;
    return this;
  }

  MyAlertDialog setHtml(bool isHtml) {
    this._html = isHtml;
    return this;
  }

  void show({void Function()? dismissListener}) {
    Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornersRound)),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                decoration: Helper.dialogBoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: _titleAlignment,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          shoeIcon
                              ? Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(_iconSize / 2),
                                    child: assetImage(
                                      _iconImage,
                                      width: _iconSize,
                                      height: _iconSize,
                                      errorBuilder: (ctx, o, e) =>
                                          assetImage('assets/icons/logo.png', width: _iconSize, height: _iconSize),
                                    ),
                                  ),
                                )
                              : empty(),
                          Flexible(
                              child:
                                  Text(_title, style: MyTextStyle(color: _titleTextColor, fontSize: _titleTextSize))),
                        ],
                      ),
                    ),
                    _firstSpacing.vs,
                    Flexible(
                        child: SingleChildScrollView(child: Align(alignment: _messageAlignment, child: _textWidget()))),
                    _secondSpacing.vs,
                    Align(
                      alignment: _buttonAlignment,
                      child: Row(mainAxisSize: MainAxisSize.min, children: _getButtons()),
                    )
                  ],
                ),
              ),
            ),
            barrierDismissible: _cancelable)
        .then((value) {
      if (dismissListener != null) {
        dismissListener.call();
      }
    });
  }

  List<Widget> _getButtons() {
    List<Widget> list = [];

    if (_negativeButtonText.isNotEmpty) {
      list.add(MaterialButton(
        onPressed: () {
          if (_negativeClickListener != null) {
            _negativeClickListener?.call();
          } else {
            Get.back();
          }
        },
        minWidth: 0,
        height: 0,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(_negativeButtonText,
            style: MyTextStyle(
              color: _buttonsTextColor,
              fontSize: fontSizeSmall,
            )),
      ));
    }

    if (_neutralButtonText.isNotEmpty) {
      list.add(MaterialButton(
        onPressed: () {
          if (_neutralClickListener != null) {
            _neutralClickListener?.call();
          } else {
            Get.back();
          }
        },
        minWidth: 0,
        height: 0,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(_neutralButtonText,
            style: MyTextStyle(
              color: _buttonsTextColor,
              fontSize: fontSizeSmall,
            )),
      ));
    }

    if (_positiveButtonText.isNotEmpty) {
      list.add(MaterialButton(
        onPressed: () {
          if (_positiveClickListener != null) {
            _positiveClickListener?.call();
          } else {
            Get.back();
          }
        },
        minWidth: 0,
        height: 0,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(_positiveButtonText,
            style: MyTextStyle(
              color: _buttonsTextColor,
              fontSize: fontSizeSmall,
            )),
      ));
    }
    return list;
  }

  Widget _textWidget() {
    if (_html) {
      // return Html(data: _message, shrinkWrap: true);
      // return HtmlWidget(_message);
      return Placeholder();
    } else if (_textSelectable) {
      return SelectableText(
        _message,
        style: MyTextStyle(color: _messageTextColor, fontSize: fontSizeMedium),
      );
    } else {
      return Text(
        _message,
        style: MyTextStyle(color: _messageTextColor, fontSize: fontSizeMedium),
        softWrap: true,
      );
    }
  }
}





// void showLocationSearchDialog() {
//   final TextEditingController searchController = TextEditingController();
//   final FocusNode searchFocusNode = FocusNode();
//
//   // Auto-focus on the search field when dialog opens
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     searchFocusNode.requestFocus();
//   });
//
//   Get.dialog(
//     Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 10,
//       child: Container(
//         width: Get.width * 0.85, // Responsive width
//         constraints: const BoxConstraints(maxWidth: 400),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.white,
//               Colors.grey.shade50,
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header with close button
//             Container(
//               padding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "🌍 Search Location",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: Icon(
//                       Icons.close_rounded,
//                       color: Colors.grey.shade600,
//                       size: 24,
//                     ),
//                     splashRadius: 20,
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // Content area
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 children: [
//                   // Search TextField with enhanced styling
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: searchController,
//                       focusNode: searchFocusNode,
//                       textInputAction: TextInputAction.search,
//                       decoration: InputDecoration(
//                         hintText: "Enter city, address, or landmark...",
//                         hintStyle: TextStyle(
//                           color: Colors.grey.shade500,
//                           fontSize: 16,
//                         ),
//                         prefixIcon: Container(
//                           padding: const EdgeInsets.all(12),
//                           child: Icon(
//                             Icons.search_rounded,
//                             color: Colors.blue.shade600,
//                             size: 24,
//                           ),
//                         ),
//                         suffixIcon: searchController.text.isNotEmpty
//                             ? IconButton(
//                           onPressed: () {
//                             searchController.clear();
//                           },
//                           icon: Icon(
//                             Icons.clear_rounded,
//                             color: Colors.grey.shade500,
//                             size: 20,
//                           ),
//                         )
//                             : null,
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade200,
//                             width: 1.5,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade200,
//                             width: 1.5,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide(
//                             color: Colors.blue.shade400,
//                             width: 2,
//                           ),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 16,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       onChanged: (value) {
//                         // You can call API or filter list here
//                         print("Searching: $value");
//                       },
//                       onSubmitted: (value) {
//                         // Handle search when user presses enter
//                         _handleSearch(searchController);
//                       },
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Quick suggestions (optional)
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "💡 Quick suggestions:",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.blue.shade700,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 6,
//                           children: [
//                             _buildSuggestionChip("Current Location", Icons.my_location),
//                             _buildSuggestionChip("New York", Icons.location_city),
//                             _buildSuggestionChip("London", Icons.location_city),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Action Buttons with enhanced styling
//             Container(
//               padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
//               child: Row(
//                 children: [
//                   // Cancel Button
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         side: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey.shade700,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 12),
//
//                   // Search Button
//                   Expanded(
//                     flex: 2,
//                     child: ElevatedButton(
//                       onPressed: () => _handleSearch(searchController),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue.shade600,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 2,
//                         shadowColor: Colors.blue.shade200,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.search_rounded, size: 20),
//                           const SizedBox(width: 8),
//                           const Text(
//                             "Search Location",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     barrierDismissible: true,
//   );
// }
//
// // Helper function to handle search logic
// void _handleSearch(TextEditingController searchController) {
//   String location = searchController.text.trim();
//   if (location.isNotEmpty) {
//     Get.back(result: location);
//     // Show loading or success feedback
//     Get.snackbar(
//       "🔍 Searching",
//       "Looking for: $location",
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.blue.shade100,
//       colorText: Colors.blue.shade800,
//       duration: const Duration(seconds: 2),
//     );
//   } else {
//     // Show validation error
//     Get.snackbar(
//       "⚠️ Empty Search",
//       "Please enter a location to search",
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.orange.shade100,
//       colorText: Colors.orange.shade800,
//       duration: const Duration(seconds: 2),
//     );
//   }
// }
//
// // Helper function to build suggestion chips
// Widget _buildSuggestionChip(String label, IconData icon) {
//   return GestureDetector(
//     onTap: () {
//       // Handle suggestion tap
//       Get.back(result: label);
//     },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.blue.shade200),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: Colors.blue.shade600),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.blue.shade700,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }