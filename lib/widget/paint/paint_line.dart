import 'package:flutter/material.dart';

class SidePaint {
  bool top = false;
  bool down = false;
  bool left = false;
  bool right = false;

  SidePaint({
    this.top = false,
    this.down = false,
    this.left = false,
    this.right = false,
  });
  SidePaint.all(bool value) {
    top = down = left = right = value;
  }
}

class PaintLine extends CustomPainter {
  final double progress;
  final Color colorPaint;
  final double thicknessPaint;
  final SidePaint sidePaint;

  PaintLine({
    required this.progress,
    required this.sidePaint,
    this.colorPaint = Colors.black,
    this.thicknessPaint = 5.0,
  });

  final int snippingsCount = 200;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colorPaint
      ..strokeWidth = thicknessPaint
      ..style = PaintingStyle.stroke;

    double addedLine = (thicknessPaint * 0.5);

    const p1 = Offset(0, 0);
    final p2 = Offset(0, (size.height * progress) + addedLine);

    final p3 = Offset(-addedLine, 0);

    final p4 = Offset(progress * size.width + addedLine, 0);

    final p5 = Offset(progress * size.width + addedLine, size.height);
    final p6 = Offset(-addedLine, size.height);

    final p7 = Offset(size.width, progress * size.height + addedLine);
    final p8 = Offset(size.width, 0);

    if (sidePaint.left) {
      // left line
      canvas.drawLine(
        p1,
        p2,
        paint,
      );
    }
    if (sidePaint.top) {
      // up line
      canvas.drawLine(
        p3,
        p4,
        paint,
      );
    }
    if (sidePaint.down) {
      // down Line
      canvas.drawLine(
        p6,
        p5,
        paint,
      );
    }

    if (sidePaint.right) {
      // right line
      canvas.drawLine(
        p8,
        p7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AnimatedLiner extends StatefulWidget {
  final Size size;
  final Color colorLine;
  final double thicknessPaint;
  final Duration duration;
  final SidePaint sidePaint;
  final Widget? child;

  const AnimatedLiner({
    super.key,
    required this.duration,
    required this.size,
    required this.sidePaint,
    this.child,
    this.colorLine = Colors.black,
    this.thicknessPaint = 5.0,
  });

  @override
  State<AnimatedLiner> createState() => _AnimatedLinerState();
}

class _AnimatedLinerState extends State<AnimatedLiner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    if (_animation.value == 0) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    // _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.thicknessPaint / 2),
      child: CustomPaint(
        painter: PaintLine(
          progress: _animation.value,
          colorPaint: widget.colorLine,
          thicknessPaint: widget.thicknessPaint,
          sidePaint: widget.sidePaint,
        ),
        size: widget.size,
        child: widget.child,
      ),
    );
  }
}
