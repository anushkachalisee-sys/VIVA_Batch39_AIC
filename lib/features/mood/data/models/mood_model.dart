import 'package:flutter/material.dart';

class Song {
  final String title;
  final String artistName;
  final String duration;
  final String matchPercentage;
  final String albumCover;
  bool isFavourite;

  Song({
    required this.title,
    required this.artistName,
    required this.duration,
    required this.matchPercentage,
    required this.albumCover,
    this.isFavourite = false,
  });
}

class Artist {
  final String name;
  final String genre;
  final String matchPercentage;
  final String image;
  final String description;
  bool isFollowing;

  Artist({
    required this.name,
    required this.genre,
    required this.matchPercentage,
    required this.image,
    required this.description,
    this.isFollowing = false,
  });
}

class MoodPlaylist {
  final String title;
  final String coverImage;
  final String songCount;
  final String label;

  MoodPlaylist({
    required this.title,
    required this.coverImage,
    required this.songCount,
    this.label = 'MADE FOR YOUR MOOD',
  });
}

class Mood {
  final String id;
  final String name;
  final String emoji;
  final IconData icon;
  final Color color;
  final String description;
  final String soundtrackHeading;
  final String soundtrackSubtitle;
  final MoodPlaylist playlist;
  final List<Song> songs;
  final List<Artist> artists;

  Mood({
    required this.id,
    required this.name,
    required this.emoji,
    required this.icon,
    required this.color,
    required this.description,
    required this.soundtrackHeading,
    required this.soundtrackSubtitle,
    required this.playlist,
    required this.songs,
    required this.artists,
  });
}
