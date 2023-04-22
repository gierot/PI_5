import 'package:flutter/material.dart';

class Top extends PreferredSize {

  Top()
      : super(
          preferredSize: Size.fromHeight(56.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    'imagens/pedra.png',
                    height: 32,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
}
