import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Widget> pageDesign({required BuildContext context, required bool blur}) {
  return [
    AnimatedIllustration(context: context),
    blur
        ? BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: const SizedBox(),
          )
        : const SizedBox(),
  ];
}

// BoxDecoration _decoration() {
//   return BoxDecoration(
//     borderRadius: const BorderRadius.all(Radius.circular(50)),
//     color: Colors.white,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.shade200,
//         blurRadius: 10,
//         spreadRadius: 6,
//       ),
//       BoxShadow(
//         color: Colors.grey.shade300,
//         blurRadius: 6,
//         spreadRadius: 2,
//         blurStyle: BlurStyle.inner,
//       )
//     ],
//   );
// }

class AnimatedIllustration extends StatefulWidget {
  const AnimatedIllustration({super.key, required this.context});
  final BuildContext context;
  @override
  State<AnimatedIllustration> createState() => _AnimatedIllustrationState();
}

class _AnimatedIllustrationState extends State<AnimatedIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  late Animation<Offset> fly;
  @override
  void dispose() {
    _animation.removeListener(() {});
    _animation.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500))
      ..repeat(reverse: true);
    fly = Tween(begin: Offset.zero, end: const Offset(0, 0.03))
        .animate(_animation);

    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(widget.context).size.width * .6,
      top: 10,
      child: SlideTransition(
        position: fly,
        child: SvgPicture.asset('assets/illustration.svg', width: 450),
      ),
    );
  }
}
