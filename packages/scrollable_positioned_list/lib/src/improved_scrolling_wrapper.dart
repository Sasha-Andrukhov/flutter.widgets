import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

class CustomScrollBehaviour extends MaterialScrollBehavior {
  const CustomScrollBehaviour();

  @override
  Widget buildScrollbar(
      BuildContext context,
      Widget child,
      ScrollableDetails details,
      ) {
    return child;
  }
}



class ImprovedScrollingWrapper {
  static Widget getWidget({
    Key? key,
    required ScrollController scrollController,
    required Widget child,
    bool useScrollbar = true,
  }) {
    return ImprovedScrolling(
      checkNegativeOffset: true,
      scrollController: scrollController,
      onScroll: (scrollOffset) => debugPrint(
        'Scroll offset: $scrollOffset',
      ),
      onMMBScrollStateChanged: (scrolling) => debugPrint(
        'Is scrolling: $scrolling',
      ),
      onMMBScrollCursorPositionUpdate: (localCursorOffset, scrollActivity) =>
          debugPrint(
            'Cursor position: $localCursorOffset\n'
                'Scroll activity: $scrollActivity',
          ),
      enableMMBScrolling: true,
      enableKeyboardScrolling: true,
      enableCustomMouseWheelScrolling: true,
      mmbScrollConfig: const MMBScrollConfig(
        customScrollCursor:  DefaultCustomScrollCursor(),
      ),
      keyboardScrollConfig: KeyboardScrollConfig(
        homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
          return const Duration(milliseconds: 100);
        },
        endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
          return const Duration(milliseconds: 2000);
        },
      ),
      customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
        scrollAmountMultiplier: 4.0,
        scrollDuration: Duration(milliseconds: 350),
      ),
      child: ScrollConfiguration(
        behavior: CustomScrollBehaviour(),
        child: child,
      ),
    );
  }
}
