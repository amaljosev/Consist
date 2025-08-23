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

  static const List<IconData> habitIcons = [
  // 🔵 Health & Wellness
  Icons.fitness_center_outlined, // Workout
  Icons.directions_run_outlined, // Running
  Icons.sports_basketball_outlined, // Sports
  Icons.pedal_bike_outlined, // Cycling
  Icons.pool_outlined, // Swimming
  Icons.self_improvement_outlined, // Meditation / Yoga
  Icons.local_dining_outlined, // Eating healthy
  Icons.set_meal_outlined, // Meal prep
  Icons.water_drop_outlined, // Hydration
  Icons.eco_outlined, // Nature / Walk
  CupertinoIcons.heart, // Heart health
  CupertinoIcons.sun_max, // Morning routine
  CupertinoIcons.moon, // Night routine
  Icons.bedtime_outlined, // Sleep tracking
  Icons.spa_outlined, // Relaxation
  Icons.healing_outlined, // Health recovery
  Icons.monitor_heart_outlined, // Heart rate

  // 🟢 Productivity & Learning
  Icons.menu_book_outlined, // Reading
  Icons.auto_stories_outlined, // Daily reading
  Icons.edit_outlined, // Journaling
  Icons.school_outlined, // Studying
  Icons.lightbulb_outline, // New idea
  Icons.alarm_outlined, // Wake up early
  Icons.alarm_on_outlined, // Time discipline
  Icons.laptop_mac_outlined, // Work or study
  Icons.keyboard_outlined, // Typing / Coding
  CupertinoIcons.book, // Learning
  CupertinoIcons.time, // Time management
  CupertinoIcons.doc_text, // Writing
  CupertinoIcons.news, // Daily updates

  // 🟣 Mindfulness & Self Growth
  Icons.check_circle_outline, // Task completion
  Icons.psychology_outlined, // Mindfulness
  Icons.volunteer_activism_outlined, // Gratitude
  Icons.wb_sunny_outlined, // Positive thinking
  Icons.auto_graph_outlined, // Progress
  Icons.insights_outlined, // Self-reflection
  Icons.handshake_outlined, // Kindness
  Icons.favorite_border, // Self-love
  Icons.shield_outlined, // Confidence
  Icons.catching_pokemon, // Curiosity (no outlined version)

  // 🟠 Lifestyle & Routine
  Icons.cleaning_services_outlined, // Cleaning habit
  Icons.local_florist_outlined, // Gardening
  Icons.shopping_cart_outlined, // Grocery shopping
  Icons.attach_money_outlined, // Budgeting
  Icons.pets_outlined, // Pet care
  Icons.music_note_outlined, // Music practice
  Icons.brush_outlined, // Art / creativity
  Icons.construction_outlined, // DIY / craft
  CupertinoIcons.calendar, // Schedule
  CupertinoIcons.briefcase, // Work habit
  CupertinoIcons.scissors, // Grooming
  CupertinoIcons.house, // Home care
  CupertinoIcons.wand_stars, // Self-care

  // 🟡 Social & Digital Habits
  Icons.phone_outlined, // Call someone
  Icons.mail_outline, // Respond to email
  Icons.sms_outlined, // Message someone
  Icons.groups_outlined, // Social bonding
  Icons.public_outlined, // Learn new culture
  Icons.lock_clock, // Digital detox (no outlined)
  Icons.no_photography_outlined, // Privacy habit
  CupertinoIcons.device_phone_portrait, // App usage
  CupertinoIcons.chat_bubble, // Communication

  // 🟤 Motivation / Meta
  Icons.star_outline, // Reward / streak
  Icons.flag_outlined, // Habit goal
  Icons.track_changes_outlined, // Long-term goal
  Icons.rocket_launch_outlined, // Start a new habit
  Icons.upgrade_outlined, // Improve habit
];

}
