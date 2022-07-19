import 'package:flutter/material.dart';
import 'package:ibtikar_task/shared/components/conditional_builder.dart';


class LoadingProgress extends StatelessWidget {
  final Widget child;
  final bool show;
  final Color? color;

  const LoadingProgress({
    Key? key,
    required this.show,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: show,
      builder: (context) => Container(
        height: double.infinity,
        width: double.infinity,
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      fallback: (context) => child,
    );
  }
}
