import 'package:flutter/material.dart';

class CustomAnimationWidget extends StatefulWidget {
  const CustomAnimationWidget({super.key});

  @override
  State<CustomAnimationWidget> createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<CustomAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this
    );
    _sizeAnimation=Tween<double>(begin:100,end:250 ).animate(_controller);
    _colorAnimation=ColorTween(begin: Colors.red,end: Colors.green).animate(_controller);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void _toggleAnimation(){
    if(_controller.status==AnimationStatus.completed){
      _controller.reverse();
    }else{
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Custom Animation"),
        //Spacer(flex: 8,),
        SizedBox(height: 8,),
        GestureDetector(
          onTap:_toggleAnimation,
          child:AnimatedBuilder(
              animation: _controller,
              builder: (context,child) {
                return Container(
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  color: _colorAnimation.value,
                  child: const Center(child: Icon(Icons.touch_app_outlined,color: Colors.white,),),
                );
              }
          ),
        )
      ],
    );
  }
}
