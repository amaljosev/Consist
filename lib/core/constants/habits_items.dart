import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum HabitType { develop, quit, task }

enum HabitRepeat { daily, custom }

enum HabitTiming { anytime, morning, noon, afternoon, evening, night }

class HabitsItems {
  static const weekdays = ["S", "M", "T", "W", "T", "F", "S"];

  static const List<Map<String, dynamic>> habitCategories = [
    {"id": "0", "name": "All", "icon": Icons.list},
    {"id": "1", "name": "Develop", "icon": Icons.flag_outlined},
    {"id": "2", "name": "Quit", "icon": Icons.block},
    {"id": "3", "name": "Task", "icon": Icons.check_circle_outline},
    {"id": "4", "name": "Health", "icon": Icons.fitness_center},
    {"id": "5", "name": "Productivity", "icon": Icons.work_outline},
    {"id": "6", "name": "Mindfulness", "icon": Icons.self_improvement},
    {"id": "7", "name": "Lifestyle", "icon": Icons.home_outlined},
    {"id": "8", "name": "Social", "icon": Icons.groups_outlined},
    {"id": "9", "name": "Motivation", "icon": Icons.star_outline},
  ];

  static const List<Map<String, dynamic>> habitList = [
    // Habits to Develop (categoryId: "1")
    {
      "id": "1",
      "name": "Workout",
      "icon": Icons.fitness_center_outlined,
      "categoryId": "1",
    },
    {
      "id": "2",
      "name": "Drink Water",
      "icon": Icons.local_drink_outlined,
      "categoryId": "1",
    },
    {"id": "3", "name": "Eat Fruits", "icon": Icons.apple, "categoryId": "1"},
    {
      "id": "4",
      "name": "Meditate",
      "icon": Icons.self_improvement,
      "categoryId": "1",
    },
    {"id": "5", "name": "Read", "icon": Icons.book_outlined, "categoryId": "1"},
    {"id": "6", "name": "Journal", "icon": Icons.edit, "categoryId": "1"},
    {
      "id": "7",
      "name": "Sleep Early",
      "icon": Icons.nightlight_round,
      "categoryId": "1",
    },
    {
      "id": "8",
      "name": "Organize Daily Tasks",
      "icon": Icons.format_list_bulleted,
      "categoryId": "1",
    },
    {
      "id": "9",
      "name": "Practice Gratitude",
      "icon": Icons.favorite_outline,
      "categoryId": "1",
    },
    {
      "id": "10",
      "name": "Connect with Others",
      "icon": Icons.people_outline,
      "categoryId": "1",
    },

    // Habits to Quit (categoryId: "2")
    {
      "id": "11",
      "name": "Binge Watching",
      "icon": Icons.tv_off,
      "categoryId": "2",
    },
    {
      "id": "12",
      "name": "Skipping Meals",
      "icon": Icons.no_food,
      "categoryId": "2",
    },
    {
      "id": "13",
      "name": "Smoking",
      "icon": Icons.smoke_free,
      "categoryId": "2",
    },
    {
      "id": "14",
      "name": "Negative Self-Talk",
      "icon": Icons.do_not_disturb_on,
      "categoryId": "2",
    },
    {
      "id": "15",
      "name": "Procrastination",
      "icon": Icons.snooze,
      "categoryId": "2",
    },
    {
      "id": "16",
      "name": "Excessive Screen Time",
      "icon": Icons.phonelink_off,
      "categoryId": "2",
    },
    {
      "id": "17",
      "name": "Poor Sleep Habits",
      "icon": Icons.bedtime_off,
      "categoryId": "2",
    },
    {
      "id": "18",
      "name": "Impulse Shopping",
      "icon": Icons.remove_shopping_cart,
      "categoryId": "2",
    },
    {
      "id": "19",
      "name": "Nail Biting",
      "icon": Icons.pan_tool_outlined,
      "categoryId": "2",
    },
    {
      "id": "20",
      "name": "Saying Yes to Everything",
      "icon": Icons.no_accounts,
      "categoryId": "2",
    },

    // One-Time Tasks (categoryId: "3")
    {
      "id": "21",
      "name": "Declutter Workspace",
      "icon": Icons.cleaning_services_outlined,
      "categoryId": "3",
    },
    {
      "id": "22",
      "name": "Schedule Medical Checkup",
      "icon": Icons.medical_services_outlined,
      "categoryId": "3",
    },
    {
      "id": "23",
      "name": "Plan Monthly Budget",
      "icon": Icons.account_balance_wallet_outlined,
      "categoryId": "3",
    },
    {
      "id": "24",
      "name": "Organize Bookshelf",
      "icon": Icons.shelves,
      "categoryId": "3",
    },
    {
      "id": "25",
      "name": "Batch Cook Meals",
      "icon": Icons.kitchen,
      "categoryId": "3",
    },
    {
      "id": "26",
      "name": "Sort Mail",
      "icon": Icons.mail_outline,
      "categoryId": "3",
    },
    {
      "id": "27",
      "name": "Prep Next-Day Clothes",
      "icon": Icons.checkroom,
      "categoryId": "3",
    },
    {
      "id": "28",
      "name": "Clean Drop Zone",
      "icon": Icons.home_outlined,
      "categoryId": "3",
    },
    {
      "id": "29",
      "name": "Backup Digital Files",
      "icon": Icons.backup,
      "categoryId": "3",
    },
    {
      "id": "31",
      "name": "Update Personal Records",
      "icon": Icons.folder_open,
      "categoryId": "3",
    },

    // Extended Habits from iconList with category mapping
    // Health & Wellness (categoryId: "4")
    {
      "id": "32",
      "name": "Running",
      "icon": Icons.directions_run_outlined,
      "categoryId": "4",
    },
    {
      "id": "33",
      "name": "Sports",
      "icon": Icons.sports_basketball_outlined,
      "categoryId": "4",
    },
    {
      "id": "34",
      "name": "Cycling",
      "icon": Icons.pedal_bike_outlined,
      "categoryId": "4",
    },
    {
      "id": "35",
      "name": "Swimming",
      "icon": Icons.pool_outlined,
      "categoryId": "4",
    },
    {
      "id": "36",
      "name": "Meditation",
      "icon": Icons.self_improvement_outlined,
      "categoryId": "6",
    },
    {
      "id": "37",
      "name": "Eating Healthy",
      "icon": Icons.local_dining_outlined,
      "categoryId": "4",
    },
    {
      "id": "38",
      "name": "Meal Prep",
      "icon": Icons.set_meal_outlined,
      "categoryId": "7",
    },
    {
      "id": "39",
      "name": "Hydration",
      "icon": Icons.water_drop_outlined,
      "categoryId": "4",
    },
    {
      "id": "40",
      "name": "Nature Walk",
      "icon": Icons.eco_outlined,
      "categoryId": "4",
    },
    {
      "id": "41",
      "name": "Heart Health",
      "icon": CupertinoIcons.heart,
      "categoryId": "4",
    },
    {
      "id": "42",
      "name": "Morning Routine",
      "icon": CupertinoIcons.sun_max,
      "categoryId": "7",
    },
    {
      "id": "43",
      "name": "Night Routine",
      "icon": CupertinoIcons.moon,
      "categoryId": "7",
    },
    {
      "id": "44",
      "name": "Sleep",
      "icon": Icons.bedtime_outlined,
      "categoryId": "4",
    },
    {
      "id": "45",
      "name": "Relaxation",
      "icon": Icons.spa_outlined,
      "categoryId": "6",
    },
    {
      "id": "46",
      "name": "Recovery",
      "icon": Icons.healing_outlined,
      "categoryId": "4",
    },
    {
      "id": "47",
      "name": "Heart Rate",
      "icon": Icons.monitor_heart_outlined,
      "categoryId": "4",
    },
    {"id": "48", "name": "Hiking", "icon": Icons.hiking, "categoryId": "4"},
    {
      "id": "49",
      "name": "Balance",
      "icon": Icons.balance_outlined,
      "categoryId": "4",
    },

    // Productivity & Learning (categoryId: "5")
    {
      "id": "50",
      "name": "Reading",
      "icon": Icons.menu_book_outlined,
      "categoryId": "5",
    },
    {
      "id": "51",
      "name": "Daily Reading",
      "icon": Icons.auto_stories_outlined,
      "categoryId": "5",
    },
    {
      "id": "52",
      "name": "Journaling",
      "icon": Icons.edit_outlined,
      "categoryId": "5",
    },
    {
      "id": "53",
      "name": "Studying",
      "icon": Icons.school_outlined,
      "categoryId": "5",
    },
    {
      "id": "54",
      "name": "New Idea",
      "icon": Icons.lightbulb_outline,
      "categoryId": "5",
    },
    {
      "id": "55",
      "name": "Wake Early",
      "icon": Icons.alarm_outlined,
      "categoryId": "5",
    },
    {
      "id": "56",
      "name": "Time Discipline",
      "icon": Icons.alarm_on_outlined,
      "categoryId": "5",
    },
    {
      "id": "57",
      "name": "Work Study",
      "icon": Icons.laptop_mac_outlined,
      "categoryId": "5",
    },
    {
      "id": "58",
      "name": "Coding",
      "icon": Icons.keyboard_outlined,
      "categoryId": "5",
    },
    {
      "id": "59",
      "name": "Learning",
      "icon": CupertinoIcons.book,
      "categoryId": "5",
    },
    {
      "id": "60",
      "name": "Time Management",
      "icon": CupertinoIcons.time,
      "categoryId": "5",
    },
    {
      "id": "61",
      "name": "Writing",
      "icon": CupertinoIcons.doc_text,
      "categoryId": "5",
    },
    {
      "id": "62",
      "name": "Daily Updates",
      "icon": CupertinoIcons.news,
      "categoryId": "5",
    },
    {
      "id": "63",
      "name": "Planning",
      "icon": Icons.task_outlined,
      "categoryId": "5",
    },
    {
      "id": "64",
      "name": "Tracking",
      "icon": Icons.list_alt_outlined,
      "categoryId": "5",
    },

    // Mindfulness & Self Growth (categoryId: "6")
    {
      "id": "65",
      "name": "Task Completion",
      "icon": Icons.check_circle_outline,
      "categoryId": "6",
    },
    {
      "id": "66",
      "name": "Mindfulness",
      "icon": Icons.psychology_outlined,
      "categoryId": "6",
    },
    {
      "id": "67",
      "name": "Gratitude",
      "icon": Icons.volunteer_activism_outlined,
      "categoryId": "6",
    },
    {
      "id": "68",
      "name": "Positivity",
      "icon": Icons.wb_sunny_outlined,
      "categoryId": "6",
    },
    {
      "id": "69",
      "name": "Progress",
      "icon": Icons.auto_graph_outlined,
      "categoryId": "6",
    },
    {
      "id": "70",
      "name": "Reflection",
      "icon": Icons.insights_outlined,
      "categoryId": "6",
    },
    {
      "id": "71",
      "name": "Kindness",
      "icon": Icons.handshake_outlined,
      "categoryId": "6",
    },
    {
      "id": "72",
      "name": "Self Love",
      "icon": Icons.favorite_border,
      "categoryId": "6",
    },
    {
      "id": "73",
      "name": "Confidence",
      "icon": Icons.shield_outlined,
      "categoryId": "6",
    },
    {
      "id": "74",
      "name": "Curiosity",
      "icon": Icons.catching_pokemon,
      "categoryId": "6",
    },
    {
      "id": "75",
      "name": "Calmness",
      "icon": Icons.nightlight_outlined,
      "categoryId": "6",
    },

    // Lifestyle & Routine (categoryId: "7")
    {
      "id": "76",
      "name": "Cleaning",
      "icon": Icons.cleaning_services_outlined,
      "categoryId": "7",
    },
    {
      "id": "77",
      "name": "Gardening",
      "icon": Icons.local_florist_outlined,
      "categoryId": "7",
    },
    {
      "id": "78",
      "name": "Grocery",
      "icon": Icons.shopping_cart_outlined,
      "categoryId": "7",
    },
    {
      "id": "79",
      "name": "Budgeting",
      "icon": Icons.attach_money_outlined,
      "categoryId": "7",
    },
    {
      "id": "80",
      "name": "Pet Care",
      "icon": Icons.pets_outlined,
      "categoryId": "7",
    },
    {
      "id": "81",
      "name": "Music",
      "icon": Icons.music_note_outlined,
      "categoryId": "7",
    },
    {
      "id": "82",
      "name": "Art",
      "icon": Icons.brush_outlined,
      "categoryId": "7",
    },
    {
      "id": "83",
      "name": "DIY",
      "icon": Icons.construction_outlined,
      "categoryId": "7",
    },
    {
      "id": "84",
      "name": "Schedule",
      "icon": CupertinoIcons.calendar,
      "categoryId": "7",
    },
    {
      "id": "85",
      "name": "Work",
      "icon": CupertinoIcons.briefcase,
      "categoryId": "7",
    },
    {
      "id": "86",
      "name": "Grooming",
      "icon": CupertinoIcons.scissors,
      "categoryId": "7",
    },
    {
      "id": "87",
      "name": "Home Care",
      "icon": CupertinoIcons.house,
      "categoryId": "7",
    },
    {
      "id": "88",
      "name": "Self Care",
      "icon": CupertinoIcons.wand_stars,
      "categoryId": "7",
    },
    {
      "id": "89",
      "name": "Cooking",
      "icon": Icons.kitchen_outlined,
      "categoryId": "7",
    },
    {
      "id": "90",
      "name": "Organization",
      "icon": Icons.folder_open_outlined,
      "categoryId": "7",
    },

    // Social & Digital Habits (categoryId: "8")
    {
      "id": "91",
      "name": "Call",
      "icon": Icons.phone_outlined,
      "categoryId": "8",
    },
    {
      "id": "92",
      "name": "Email",
      "icon": Icons.mail_outline,
      "categoryId": "8",
    },
    {
      "id": "93",
      "name": "Message",
      "icon": Icons.sms_outlined,
      "categoryId": "8",
    },
    {
      "id": "94",
      "name": "Social",
      "icon": Icons.groups_outlined,
      "categoryId": "8",
    },
    {
      "id": "95",
      "name": "Culture",
      "icon": Icons.public_outlined,
      "categoryId": "8",
    },
    {
      "id": "96",
      "name": "Digital Detox",
      "icon": Icons.lock_clock,
      "categoryId": "8",
    },
    {
      "id": "97",
      "name": "Privacy",
      "icon": Icons.no_photography_outlined,
      "categoryId": "8",
    },
    {
      "id": "98",
      "name": "App Usage",
      "icon": CupertinoIcons.device_phone_portrait,
      "categoryId": "8",
    },
    {
      "id": "99",
      "name": "Communication",
      "icon": CupertinoIcons.chat_bubble,
      "categoryId": "8",
    },
    {
      "id": "100",
      "name": "Networking",
      "icon": Icons.wifi_tethering_outlined,
      "categoryId": "8",
    },
    {
      "id": "101",
      "name": "Video Call",
      "icon": Icons.videocam_outlined,
      "categoryId": "8",
    },

    // Motivation / Meta (categoryId: "9")
    {
      "id": "102",
      "name": "Reward",
      "icon": Icons.star_outline,
      "categoryId": "9",
    },
    {
      "id": "103",
      "name": "Goal",
      "icon": Icons.flag_outlined,
      "categoryId": "9",
    },
    {
      "id": "104",
      "name": "Long Term Goal",
      "icon": Icons.track_changes_outlined,
      "categoryId": "9",
    },
    {
      "id": "105",
      "name": "New Habit",
      "icon": Icons.rocket_launch_outlined,
      "categoryId": "9",
    },
    {
      "id": "106",
      "name": "Improve",
      "icon": Icons.upgrade_outlined,
      "categoryId": "9",
    },
    {
      "id": "107",
      "name": "Milestone",
      "icon": Icons.emoji_events_outlined,
      "categoryId": "9",
    },
    {
      "id": "108",
      "name": "Consistency",
      "icon": Icons.repeat_on_outlined,
      "categoryId": "9",
    },
  ];
}
