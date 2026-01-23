import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideBottomNavigationBar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const HideBottomNavigationBar(
      {super.key, required this.controller, this.duration = const Duration(
          microseconds: 100), required this.child});

  @override
  State<HideBottomNavigationBar> createState() => _HideBottomNavigationBarState();
}

class _HideBottomNavigationBarState extends State<HideBottomNavigationBar> {

  // ----------- visible and invisible --------
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  // ----------- when the user scroll the screen ---------
  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if(direction == ScrollDirection.forward){
      setState(() {
        isVisible = true;
      });
    }else if(direction == ScrollDirection.reverse){
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.addListener(listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? 80 : 0,
      child: Wrap(
        children: [
          widget.child,
        ],
      ),
    );
  }
}
