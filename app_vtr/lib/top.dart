import 'package:flutter/material.dart';

class Top extends PreferredSize {

  Top()
      : super(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
            backgroundColor:const Color(0xFF04121F),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.white,
                    height: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'imagens/logo.png',
                    height: 32,
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.white,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        );
}
