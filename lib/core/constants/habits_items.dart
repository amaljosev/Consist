import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum HabitType { develop, quit, task }

enum HabitRepeat { daily, custom }

enum HabitTiming { anytime, morning, noon, afternoon, evening, night }

class HabitsItems {
  static const weekdays = ["S", "M", "T", "W", "T", "F", "S"];
  static final List<Map<String, dynamic>> habitsToDevelop = [
    {
      "id": 1,
      "name": "Wake up early",
      "category": "develop",
      "icon": Icons.alarm,
    },
    {
      "id": 2,
      "name": "Drink more water",
      "category": "develop",
      "icon": Icons.local_drink,
    },
    {
      "id": 3,
      "name": "Exercise",
      "category": "develop",
      "icon": Icons.fitness_center,
    },
    {
      "id": 4,
      "name": "Read a book",
      "category": "develop",
      "icon": Icons.menu_book,
    },
    {
      "id": 5,
      "name": "Meditate",
      "category": "develop",
      "icon": Icons.self_improvement,
    },
    {
      "id": 6,
      "name": "Plan your day",
      "category": "develop",
      "icon": Icons.calendar_today,
    },
    {
      "id": 7,
      "name": "Eat healthy",
      "category": "develop",
      "icon": Icons.restaurant,
    },
    {
      "id": 8,
      "name": "Learn something new",
      "category": "develop",
      "icon": Icons.school,
    },
    {
      "id": 9,
      "name": "Practice gratitude",
      "category": "develop",
      "icon": Icons.favorite_border,
    },
    {
      "id": 10,
      "name": "Sleep on time",
      "category": "develop",
      "icon": Icons.bedtime,
    },
  ];
  static final List<Map<String, dynamic>> habitsToQuit = [
    {
      "id": 11,
      "name": "Quit smoking",
      "category": "quit",
      "icon": Icons.smoke_free,
    },
    {
      "id": 12,
      "name": "Stop procrastinating",
      "category": "quit",
      "icon": Icons.timer_off,
    },
    {
      "id": 13,
      "name": "Reduce screen time",
      "category": "quit",
      "icon": Icons.screen_lock_portrait,
    },
    {
      "id": 14,
      "name": "Avoid junk food",
      "category": "quit",
      "icon": Icons.no_food,
    },
    {
      "id": 15,
      "name": "Stop biting nails",
      "category": "quit",
      "icon": Icons.pan_tool_alt,
    },
    {
      "id": 16,
      "name": "Limit social media",
      "category": "quit",
      "icon": Icons.phone_android,
    },
    {
      "id": 17,
      "name": "Quit drinking alcohol",
      "category": "quit",
      "icon": Icons.wine_bar,
    },
    {
      "id": 18,
      "name": "Avoid negative self-talk",
      "category": "quit",
      "icon": Icons.psychology_alt,
    },
    {
      "id": 19,
      "name": "Reduce caffeine intake",
      "category": "quit",
      "icon": Icons.local_cafe,
    },
    {
      "id": 20,
      "name": "Stop overspending",
      "category": "quit",
      "icon": Icons.money_off,
    },
  ];
  static final List<Map<String, dynamic>> singleTimeTasks = [
    {
      "id": 21,
      "name": "Organize your workspace",
      "category": "task",
      "icon": Icons.cleaning_services,
    },
    {
      "id": 22,
      "name": "Clean your inbox",
      "category": "task",
      "icon": Icons.mark_email_read,
    },
    {
      "id": 23,
      "name": "Back up your data",
      "category": "task",
      "icon": Icons.backup,
    },
    {
      "id": 24,
      "name": "Schedule doctor appointment",
      "category": "task",
      "icon": Icons.local_hospital,
    },
    {"id": 25, "name": "Call a friend", "category": "task", "icon": Icons.call},
    {
      "id": 26,
      "name": "Declutter your wardrobe",
      "category": "task",
      "icon": Icons.checkroom,
    },
    {
      "id": 27,
      "name": "Pay bills",
      "category": "task",
      "icon": Icons.receipt_long,
    },
    {
      "id": 28,
      "name": "Write down goals",
      "category": "task",
      "icon": Icons.edit_note,
    },
    {
      "id": 29,
      "name": "Update resume",
      "category": "task",
      "icon": Icons.description,
    },
    {
      "id": 30,
      "name": "Fix a broken item",
      "category": "task",
      "icon": Icons.build,
    },
  ];

  static const List<Map<String, dynamic>> iconList = [
    // 🔵 Health & Wellness
    {"id": 1, "name": "workout", "icon": Icons.fitness_center_outlined},
    {"id": 2, "name": "running", "icon": Icons.directions_run_outlined},
    {"id": 3, "name": "sports", "icon": Icons.sports_basketball_outlined},
    {"id": 4, "name": "cycling", "icon": Icons.pedal_bike_outlined},
    {"id": 5, "name": "swimming", "icon": Icons.pool_outlined},
    {"id": 6, "name": "meditation", "icon": Icons.self_improvement_outlined},
    {"id": 7, "name": "eating_healthy", "icon": Icons.local_dining_outlined},
    {"id": 8, "name": "meal_prep", "icon": Icons.set_meal_outlined},
    {"id": 9, "name": "hydration", "icon": Icons.water_drop_outlined},
    {"id": 10, "name": "nature_walk", "icon": Icons.eco_outlined},
    {"id": 11, "name": "heart_health", "icon": CupertinoIcons.heart},
    {"id": 12, "name": "morning_routine", "icon": CupertinoIcons.sun_max},
    {"id": 13, "name": "night_routine", "icon": CupertinoIcons.moon},
    {"id": 14, "name": "sleep", "icon": Icons.bedtime_outlined},
    {"id": 15, "name": "relaxation", "icon": Icons.spa_outlined},
    {"id": 16, "name": "recovery", "icon": Icons.healing_outlined},
    {"id": 17, "name": "heart_rate", "icon": Icons.monitor_heart_outlined},
    {"id": 18, "name": "hiking", "icon": Icons.hiking}, // NEW: Outdoor activity
    {
      "id": 19,
      "name": "balance",
      "icon": Icons.balance_outlined,
    }, // NEW: Posture / balance exercise
    // 🟢 Productivity & Learning
    {"id": 20, "name": "reading", "icon": Icons.menu_book_outlined},
    {"id": 21, "name": "daily_reading", "icon": Icons.auto_stories_outlined},
    {"id": 22, "name": "journaling", "icon": Icons.edit_outlined},
    {"id": 23, "name": "studying", "icon": Icons.school_outlined},
    {"id": 24, "name": "new_idea", "icon": Icons.lightbulb_outline},
    {"id": 25, "name": "wake_early", "icon": Icons.alarm_outlined},
    {"id": 26, "name": "time_discipline", "icon": Icons.alarm_on_outlined},
    {"id": 27, "name": "work_study", "icon": Icons.laptop_mac_outlined},
    {"id": 28, "name": "coding", "icon": Icons.keyboard_outlined},
    {"id": 29, "name": "learning", "icon": CupertinoIcons.book},
    {"id": 30, "name": "time_management", "icon": CupertinoIcons.time},
    {"id": 31, "name": "writing", "icon": CupertinoIcons.doc_text},
    {"id": 32, "name": "daily_updates", "icon": CupertinoIcons.news},
    {
      "id": 33,
      "name": "planning",
      "icon": Icons.task_outlined,
    }, // NEW: Daily planning habit
    {
      "id": 34,
      "name": "tracking",
      "icon": Icons.list_alt_outlined,
    }, // NEW: To-do / habit tracker
    // 🟣 Mindfulness & Self Growth
    {"id": 35, "name": "task_completion", "icon": Icons.check_circle_outline},
    {"id": 36, "name": "mindfulness", "icon": Icons.psychology_outlined},
    {"id": 37, "name": "gratitude", "icon": Icons.volunteer_activism_outlined},
    {"id": 38, "name": "positivity", "icon": Icons.wb_sunny_outlined},
    {"id": 39, "name": "progress", "icon": Icons.auto_graph_outlined},
    {"id": 40, "name": "reflection", "icon": Icons.insights_outlined},
    {"id": 41, "name": "kindness", "icon": Icons.handshake_outlined},
    {"id": 42, "name": "self_love", "icon": Icons.favorite_border},
    {"id": 43, "name": "confidence", "icon": Icons.shield_outlined},
    {"id": 44, "name": "curiosity", "icon": Icons.catching_pokemon},
    {
      "id": 45,
      "name": "calmness",
      "icon": Icons.nightlight_outlined,
    }, // NEW: Staying calm habit
    // 🟠 Lifestyle & Routine
    {"id": 46, "name": "cleaning", "icon": Icons.cleaning_services_outlined},
    {"id": 47, "name": "gardening", "icon": Icons.local_florist_outlined},
    {"id": 48, "name": "grocery", "icon": Icons.shopping_cart_outlined},
    {"id": 49, "name": "budgeting", "icon": Icons.attach_money_outlined},
    {"id": 50, "name": "pet_care", "icon": Icons.pets_outlined},
    {"id": 51, "name": "music", "icon": Icons.music_note_outlined},
    {"id": 52, "name": "art", "icon": Icons.brush_outlined},
    {"id": 53, "name": "diy", "icon": Icons.construction_outlined},
    {"id": 54, "name": "schedule", "icon": CupertinoIcons.calendar},
    {"id": 55, "name": "work", "icon": CupertinoIcons.briefcase},
    {"id": 56, "name": "grooming", "icon": CupertinoIcons.scissors},
    {"id": 57, "name": "home_care", "icon": CupertinoIcons.house},
    {"id": 58, "name": "self_care", "icon": CupertinoIcons.wand_stars},
    {
      "id": 59,
      "name": "cooking",
      "icon": Icons.kitchen_outlined,
    }, // NEW: Cooking habit
    {
      "id": 60,
      "name": "organization",
      "icon": Icons.folder_open_outlined,
    }, // NEW: Organizing things
    // 🟡 Social & Digital Habits
    {"id": 61, "name": "call", "icon": Icons.phone_outlined},
    {"id": 62, "name": "email", "icon": Icons.mail_outline},
    {"id": 63, "name": "message", "icon": Icons.sms_outlined},
    {"id": 64, "name": "social", "icon": Icons.groups_outlined},
    {"id": 65, "name": "culture", "icon": Icons.public_outlined},
    {"id": 66, "name": "digital_detox", "icon": Icons.lock_clock},
    {"id": 67, "name": "privacy", "icon": Icons.no_photography_outlined},
    {
      "id": 68,
      "name": "app_usage",
      "icon": CupertinoIcons.device_phone_portrait,
    },
    {"id": 69, "name": "communication", "icon": CupertinoIcons.chat_bubble},
    {
      "id": 70,
      "name": "networking",
      "icon": Icons.wifi_tethering_outlined,
    }, // NEW: Social / career networking
    {
      "id": 71,
      "name": "video_call",
      "icon": Icons.videocam_outlined,
    }, // NEW: Habit of virtual connect
    // 🟤 Motivation / Meta
    {"id": 72, "name": "reward", "icon": Icons.star_outline},
    {"id": 73, "name": "goal", "icon": Icons.flag_outlined},
    {"id": 74, "name": "long_term_goal", "icon": Icons.track_changes_outlined},
    {"id": 75, "name": "new_habit", "icon": Icons.rocket_launch_outlined},
    {"id": 76, "name": "improve", "icon": Icons.upgrade_outlined},
    {
      "id": 77,
      "name": "milestone",
      "icon": Icons.emoji_events_outlined,
    }, // NEW: Celebrating achievements
    {
      "id": 78,
      "name": "consistency",
      "icon": Icons.repeat_on_outlined,
    }, // NEW: Build consistency
  ];
}
