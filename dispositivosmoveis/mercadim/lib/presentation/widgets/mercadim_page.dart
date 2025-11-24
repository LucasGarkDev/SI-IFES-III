import 'package:flutter/material.dart';

class MercadimPage extends StatelessWidget {
  final String? title;
  final Widget child;
  final bool scrollable;

  const MercadimPage({
    super.key,
    this.title,
    required this.child,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding: const EdgeInsets.all(16),
      child: child,
    );

    return Scaffold(
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      body: scrollable
          ? SingleChildScrollView(child: body)
          : body,
    );
  }
}
