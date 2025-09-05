import 'package:flutter/material.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/widget/widgets.dart';
import 'package:get/get.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/values/strings.dart';

// ignore: must_be_immutable
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  bool enableBackButton;
  bool showBellButton;
  bool showProfileButton;
  bool enableClearButton;
  void Function(String text)? searchCallBack;
  void Function()? backCallBack;
  bool searchExpanded;
  TextEditingController? searchController;
  bool searchReadOnly;
  Function()? onSearchClick;
  Widget? trailing;
  void Function()? onMenuClick;

  MyAppBar(
    this.title, {
    super.key,
    this.enableBackButton = true,
    this.showBellButton = false,
    this.showProfileButton = false,
    this.searchCallBack,
    this.backCallBack,
    this.searchExpanded = false,
    this.enableClearButton = true,
    this.searchController,
    this.searchReadOnly = false,
    this.onSearchClick,
    this.trailing,
    this.onMenuClick,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  // _MyAppBarState createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  // Size get preferredSize => const Size.fromHeight(80);
  // Size get preferredSize => Size.fromHeight(15.w);
  Size get preferredSize => Size.fromHeight(8.h);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    widget.searchController =
        widget.searchController ?? TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: EdgeInsets.only(top: 3.h),
      decoration: const BoxDecoration(color: ThemeColors.primaryColor),
      child: widget.searchExpanded
          ? _searchBar
          : Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.onMenuClick != null ? _menuButton : _backButton,
                _toolbarTitle,
                5.hs,
                _searchIcon,
                _bellIcon,
                if (widget.trailing != null) widget.trailing ?? empty(),
                8.hs,
                _userProfile,
                8.hs,
              ],
            ),
    );
  }

  Widget get _toolbarTitle {
    return Expanded(
      child: Text(
        // (widget.title.placeholder(Strings.get('appName'))) +
        //     (ApiKeys.env == ApiKeys.ENV_DEV ? ' (DEV)' : ''),
        widget.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
        style: const MyTextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget get _searchBar => Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: MyFlatButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.search,
              color: ThemeColors.colorSecondary,
              size: 18,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            onChanged: (txt) {
              if (widget.searchCallBack != null) {
                widget.searchCallBack?.call(txt);
              }
            },
            onTap: widget.onSearchClick,
            cursorWidth: 1.4,
            readOnly: widget.searchReadOnly,
            autofocus: true,
            cursorColor: ThemeColors.colorSecondary,
            controller: widget.searchController,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: ' ${Strings.get('search')}...',
              hintStyle: const MyTextStyle(
                fontSize: 14,
                color: ThemeColors.colorSecondary,
              ),
              isDense: true,
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            // onSubmitted: (str) => searchCallBack.call(str),
            style: const MyTextStyle(
              fontSize: 14,
              color: ThemeColors.colorSecondary,
            ),
          ),
        ),
        _clearButton,
      ],
    ),
  );

  Widget get _userProfile => widget.showProfileButton
      ? InkWell(
          onTap: () {
            // Get.to(() => ProfileScreen());
          },
          overlayColor: WidgetStateColor.transparent,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: CircleAvatar(
              backgroundColor: ThemeColors.white.withAlpha(50),
              radius: 2.h,
              // backgroundImage: CachedNetworkImageProvider(
              //   Helper.getProfileImageUrl(Preference.user.image),
              // ),
            ),
          ),
        )
      : Container();

  Widget get _searchIcon => widget.searchCallBack != null
      ? Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            width: 30,
            height: 30,
            child: MyFlatButton(
              onPressed: () => setState(() => widget.searchExpanded = true),
              color: Colors.white.withAlpha(50),
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              child: const Icon(Icons.search, color: Colors.white, size: 18),
            ),
          ),
        )
      : empty();

  Widget get _bellIcon => widget.showBellButton
      ? Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
              child: SizedBox(
                width: 30,
                height: 30,
                child: MyFlatButton(
                  onPressed: () {
                    Get.back();
                    // Get.to(() => NotificationScreen());
                  },
                  color: Colors.white.withAlpha(50),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  child: assetImage(
                    'assets/icons/bell_bold.png',
                    color: Colors.white,
                    width: 18,
                    height: 18,
                  ),
                ),
              ),
            ),
            Obx(
              () => Const.notificationCount.value > 0
                  ? Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            Const.notificationCount.value.toString(),
                            style: const MyTextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(width: 18, height: 18),
            ),
          ],
        )
      : empty();

  Widget get _clearButton => SizedBox(
    width: 40,
    height: 40,
    child: MyFlatButton(
      onPressed: () {
        if (widget.searchController!.text.isNotEmpty) {
          widget.searchController?.clear();
          widget.searchCallBack?.call('');
        } else {
          setState(() => widget.searchExpanded = false);
        }
      },
      color: Colors.white.withAlpha(50),
      padding: EdgeInsets.zero,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.close,
        color: ThemeColors.colorSecondary,
        size: 18,
      ),
    ),
  );

  // Widget get _backButton=> enableBackButton
  //          ?IconButton(
  //     onPressed: backCallBack != null ? backCallBack : Get.back,
  //     icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 18),
  //   ):Container(width: 20);

  Widget get _backButton => widget.enableBackButton
      ? SizedBox(
          width: 40,
          height: 40,
          child: MyFlatButton(
            onPressed: widget.backCallBack ?? Get.back,
            // onPressed: () {
            //   if (backCallBack != null) {
            //     backCallBack.call();
            //   } else {
            //     Get.back();
            //   }
            // },
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        )
      : Container(width: 20);

  Widget get _menuButton => SizedBox(
    width: 40,
    height: 40,
    child: MyFlatButton(
      onPressed: () {
        widget.onMenuClick?.call();
      },
      padding: EdgeInsets.zero,
      shape: const CircleBorder(),
      child: const Icon(Icons.menu, color: Colors.white, size: 24),
    ),
  );
}
