import 'package:covidactnow/pages/view_region.dart';
import 'package:flutter/material.dart';
import 'package:covidactnow/utils/map_ext.dart';

enum MessageType {
  onMessage,
  onLaunch,
  onResume,
  onBackgroundMessage,
}

class Message {
  Message(this.title, this.body, this.type);

  Message.fromMap(Map<String, dynamic> map, this.type) {
    final notification = map.mapForKey<String, dynamic>('notification');

    // iOS doesn't have 'data', if null, look in map
    final data = map.mapForKey<String, dynamic>('data') ?? map;

    if (notification != null && notification['title'] != null) {
      // for onMessage
      title = notification.strForKey('title');
      body = notification.strForKey('body');
    } else if (data != null && data['title'] != null) {
      // for onResume / onLaunch
      title = data.strForKey('title');
      body = data.strForKey('body');
    }

    // get route information
    if (data != null) {
      route = data.strForKey('route');
    }

    title = title ?? 'title';
    body = body ?? 'body';
  }

  String title;
  String body;
  String route;
  MessageType type;

  @override
  String toString() {
    return '$title, $body, $route';
  }

  void navigateToRoute(
    BuildContext context,
  ) {
    Page_ViewRegion.navigateToPage(context, route);
  }
}
