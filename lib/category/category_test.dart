import 'package:flutter/material.dart';

class CategoryTest extends StatefulWidget {
  const CategoryTest({super.key});

  @override
  State<CategoryTest> createState() => _CategoryTestState();
}

class _CategoryTestState extends State<CategoryTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12),
              BoxShadow(
                color: Colors.white,
                spreadRadius: -0.1,
                blurRadius: 2,
                offset: Offset(3, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
