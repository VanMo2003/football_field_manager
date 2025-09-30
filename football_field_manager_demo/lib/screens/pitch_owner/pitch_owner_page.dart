import 'package:flutter/material.dart';
import '../../screens/pitch_owner/pitch_owner_screen.dart';
import '../../screens/pitch_owner/side_bar/side_bar_screen.dart';
import '../../screens/widgets/loading_widget.dart';

class ManegeScreen extends StatelessWidget {
  const ManegeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Trang chủ quản lý sân"),
      ),
    );
  }
}
