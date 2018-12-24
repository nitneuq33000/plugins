import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  // SearchPageState()
  //     : colorItems = List<Color>.generate(_kChildCount, (int index) {
  //         return coolColors[math.Random().nextInt(coolColors.length)];
  //       }),
  //       colorNameItems = List<String>.generate(_kChildCount, (int index) {
  //         return coolColorNames[math.Random().nextInt(coolColorNames.length)];
  //       });

  TextStyle searchText;
  Color searchBackground, searchIconColor, searchCursorColor;

  TextEditingController _searchTextController;
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _searchTextController = TextEditingController();

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    _startSearch();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchFocusNode.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  void _startSearch() {
    _searchTextController.clear();
    _animationController.forward();
  }

  void _cancelSearch() {
    // if (widget.alwaysShowAppBar) {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
    // }
    // widget.onSearchPressed();
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  // final List<Color> colorItems;
  // final List<String> colorNameItems;
  bool _isSearching = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeSearchAppBar(
        title: const Text("Search Page"),
        isSearching: _isSearching,
        onSearchPressed: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
        onChanged: (String value) {
          print(value);
        },
        // actions: <Widget>[
        //   NativeIconButton(
        //     icon: Icon(Icons.info_outline),
        //     iosIcon: Icon(CupertinoIcons.info),
        //   ),
        // ],
      ),
    );
  }
}
