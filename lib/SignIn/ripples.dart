import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:sec_project_chatbot/main.dart';
import 'CirclePainter.dart';
import 'CurveWave.dart';
import 'dart:ui';

void main() {
  runApp(ripples());
}
class ripples extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      child: MaterialApp(
        home: RipplesAnimation(onPressed: () {}, child: Text("")),
      )
    );
  }

}

class RipplesAnimation extends StatefulWidget {
  RipplesAnimation({ this.size = 90.0, this.color = Colors.purple,
    required this.onPressed, required this.child,});

  final double size;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  @override
  _RipplesAnimationState createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<RipplesAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                widget.color,
                //Color.fromRGBO(200, 220, 120, 100),
                Colors.purpleAccent,
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.85, end: 0.95).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const CurveWave(),
                ),
              ),
              child: SizedBox(
                child: Image.asset(
                  "assets/app logo panda.png",
                ),
              )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            //backgroundColor: Color.fromRGBO(250, 150, 150, 40),
            backgroundColor:Color.fromRGBO(200, 120, 160, 10),
            appBar: AppBar(
              elevation: 10,
              title: Text("Panda"),
              backgroundColor: Colors.purple,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.max,
                    //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(
                          painter: CirclePainter(
                            _controller,
                            color: widget.color,
                          ),
                          child: SizedBox(
                            width: widget.size * 3.325,
                            height: widget.size * 3.325,
                            child: _button(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "User name/ email",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'username/ email',
                          ),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.purple),
                            onPressed: () {

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                             // Navigator.push(context, builder: MyHomePage());
                            },
                            child: Text("SignIn", style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w500,
                                backgroundColor: Colors.purple),)),
                        SizedBox(
                          height: 50,
                        ),
                        Text("Don't have an account | Sign Up here"),
                        FlatButton(onPressed: (){}, child: Text("Sign Up", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),))
                      ]),
                ),
              ),
      ),
    );
  }
}