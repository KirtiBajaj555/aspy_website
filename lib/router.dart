import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screen/my_home_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(initialSection: 'home'),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => MyHomePage(initialSection: 'about'),
    ),
    GoRoute(
      path: '/services',
      builder: (context, state) => MyHomePage(initialSection: 'services'),
    ),
    GoRoute(
      path: '/sectors',
      builder: (context, state) => MyHomePage(initialSection: 'sectors'),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => MyHomePage(initialSection: 'contact'),
    ),
  ],
);
