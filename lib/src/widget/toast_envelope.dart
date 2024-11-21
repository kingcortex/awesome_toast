import 'package:awesome_toast/src/core/awesome_toast_item.dart';
import 'package:awesome_toast/src/core/awesome_toast_provider.dart';
import 'package:flutter/material.dart';


/// [AwesomeToastEnvelope] est une classe qui gère les animations de la toast
/// et permet également certaines actions, comme le glissement pour la supprimer.
/// Elle encapsule la toast construite dans [AwesomeToastItem].

class AwesomeToastEnvelope extends StatefulWidget {
  final AwesomeToastItem item;

  final VoidCallback? onCloce;
  final VoidCallback? onTap;
  const AwesomeToastEnvelope({
    super.key,
    this.onCloce,
    this.onTap,
    required this.item,
  });

  @override
  AwesomeToastEnvelopeState createState() => AwesomeToastEnvelopeState();
}

class AwesomeToastEnvelopeState extends State<AwesomeToastEnvelope>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double _positionX = 0.0;
  bool _isDragging = false;
  late Size _screenSize;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    print(details.delta.dx);
    setState(() {
      _positionX += details.delta.dx;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_positionX.abs() > 100) {
      _delete(_positionX);
      //widget.onCloce?.call();
    } else {
      setState(() {
        _isDragging = false;
        _positionX = 0.0;
      });
    }
  }

  void _onHorizontalDragStart() {
    setState(() {
      _isDragging = true;
    });
  }

  void _delete(double dx) async {
    if (dx > 0) {
      setState(() {
        _positionX -= _screenSize.width * 2;
      });
    } else {
      setState(() {
        _positionX += _screenSize.width * 2;
      });
    }
    await Future.delayed(const Duration(milliseconds: 200));
    widget.onCloce?.call();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _screenSize = MediaQuery.of(context).size;
      },
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // Commence sous l'écran
      end: const Offset(0, 0), // Fin de l'animation à sa position finale
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // Animation fluide
    ));

    _controller.forward(); // Lancer l'animation lorsque le widget apparaît
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Transform.translate(
        offset: Offset(_positionX, 0),
        child: GestureDetector(
          onPanUpdate: (details) {
            print(details.globalPosition.dx);
          },
          onHorizontalDragStart: (details) => _onHorizontalDragStart(),
          onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details),
          onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details),
          onTap: () {
            AwesomeToastProvider.of(context)!.state.expanded();
          },
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..translate(_positionX, 0),
              duration: _isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 400),
              child: widget.item.builder,
            ),
          ),
        ),
      ),
    );
  }
}
