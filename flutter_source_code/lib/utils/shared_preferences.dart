import 'package:flutter_story_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future<bool> checkAvailability(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList(STORY_IDS_KEY) == null) {
      return false;
    }
    return prefs.getStringList(STORY_IDS_KEY).contains(id.toString());
  }

  static Future<bool> delete(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storyIds = prefs.getStringList(STORY_IDS_KEY)
      ..remove(id.toString());
    await prefs.setStringList(STORY_IDS_KEY, storyIds);
    return true;
  }

  static Future<List<String>> getAllStoryIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(STORY_IDS_KEY);
  }

  static Future<bool> storeStoryId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storyIds = prefs.getStringList(STORY_IDS_KEY);
    if (storyIds == null) {
      storyIds = new List();
    }
    storyIds.add(id.toString());
    await prefs.setStringList(STORY_IDS_KEY, storyIds.toSet().toList());
    return true;
  }
}
