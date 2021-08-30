import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String HOST_NAME = "https://www.example.com";

const String ALL_AUTHORS_URL = "/authors/all";
const String ALL_TAGS_URL = "/tags/all";
const String FAVORITE_STORIES_URL = "/stories/favorites";
const String LATEST_STORIES_URL = "/stories/latest";
const String SEARCH_STORIES_URL = "/stories/search";
const String ALL_STORIES_URL = "/stories/all";
const String ALL_STORIES_BY_TAG_URL = "/stories/tag/";
const String IMAGES_BASE_URL = HOST_NAME + "/images/";
const String API_BASE_URL = HOST_NAME + "/api";
const String THUMBNAILS_BASE_URL = HOST_NAME + "/images/thumbnails/";

const Color DARK_BACKGROUND_COLOR = Color(0xDE000000);
const Color DARK_ICON_BACKGROUND_COLOR = Color(0xFF2d3447);
const Color DARK_ICON_COLOR = Color(0xB3FFFFFF);
const Color DARK_TEXT_COLOR = Color(0xB3FFFFFF);
const Color LIGHT_BACKGROUND_COLOR = Color(0xFFFFFFFF);
const Color LIGHT_ICON_BACKGROUND_COLOR = Color(0x22000000);
const Color LIGHT_ICON_COLOR = Color(0xFF2d3447);
const Color LIGHT_TEXT_COLOR = Color(0xA1000000);

const String STORY_IDS_KEY = 'stories';
const List<Color> TAG_COLORS = [
  Color(0xffffbd69),
  Color(0xffff6363),
  Color(0xff29c7ac),
  Color(0xff46b5d1),
  Color(0xffb030b0),
  Color(0xffa7d129),
  Color(0xffff4d00),
];

const int TRENDING_LIST_ITEM_COUNT = 10;
