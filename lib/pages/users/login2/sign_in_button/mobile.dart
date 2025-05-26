// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'stub.dart';

/// Renders a SIGN IN button that calls `handleSignIn` onclick.
Widget buildSignInButton({HandleSignInFn? onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 200,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF00b3b0),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/icongoogle.jpeg',
                  fit: BoxFit.fill,
                  height: 45,
                  width: 45,
                )
                // const Text('G', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400)),
                ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF00b3b0),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Sign in with Google '),
            ),
          ),
        ],
      ),
    ),
  );
}
