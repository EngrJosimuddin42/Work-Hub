
import 'package:flutter/material.dart';

class Service {
  final String title;
  final String description;
  final String imageAsset;
  final String gifAsset;
  final String videoAsset;
  final Color color;

  const Service({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.gifAsset,
    required this.videoAsset,
    required this.color,
  });
}
