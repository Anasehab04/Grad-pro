// lib/services/mock_service.dart
// ─────────────────────────────────────────────────────────────
// Replace each method body with a real API call when backend
// is ready. All screens stay untouched.
// ─────────────────────────────────────────────────────────────

class MockService {
  // ── Simulated logged-in user ──────────────────────────────
  static Map<String, dynamic>? _currentUser;

  // ══════════════════════════════════════════════════════════
  // AUTH
  // ══════════════════════════════════════════════════════════

  /// Login — always succeeds for any email/password
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate wrong password
    if (password.length < 3) {
      throw Exception('Invalid email or password');
    }

    _currentUser = {
      'id': 'user_001',
      'name': 'Anas',
      'email': email,
      'avatar': null,
    };
    return _currentUser!;
  }

  /// Register — always succeeds
  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    _currentUser = {
      'id': 'user_002',
      'name': name,
      'email': email,
      'avatar': null,
    };
    return _currentUser!;
  }

  /// Logout
  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  /// Get current logged-in user
  static Map<String, dynamic>? getCurrentUser() => _currentUser;

  // ══════════════════════════════════════════════════════════
  // HOME
  // ══════════════════════════════════════════════════════════

  /// Fetch the list of Egyptian destinations for Explore section
  static Future<List<Map<String, dynamic>>> getDestinations() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      {'emoji': '🏛️', 'city': 'Cairo', 'subtitle': 'City of Pharaohs'},
      {'emoji': '🗿', 'city': 'Luxor', 'subtitle': 'Open-Air Museum'},
      {'emoji': '🐪', 'city': 'Aswan', 'subtitle': 'Nubian Gem'},
      {'emoji': '🌊', 'city': 'Hurghada', 'subtitle': 'Red Sea Paradise'},
      {'emoji': '🏖️', 'city': 'Alexandria', 'subtitle': 'Mediterranean Pearl'},
      {'emoji': '🏜️', 'city': 'Giza', 'subtitle': 'Land of Pyramids'},
    ];
  }

  /// Fetch saved tours for the current user
  static Future<List<Map<String, dynamic>>> getMyTours() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': 'tour_001',
        'city': 'CAIRO',
        'title': 'Cairo Adventure',
        'description':
            'Explore the rich history and vibrant culture of Cairo over eight unforgettable days. From the...',
        'startDate': 'May 16, 2026',
        'endDate': 'May 23, 2026',
        'days': 8,
        'style': 'Comfort',
        'interests': ['Pyramids', 'History', 'Food'],
        'accentColor': 'cyan',
      },
      {
        'id': 'tour_002',
        'city': 'LUXOR',
        'title': 'Luxor Explorer',
        'description':
            'Walk through the Valley of the Kings and discover temples that have stood for millennia...',
        'startDate': 'Jun 1, 2026',
        'endDate': 'Jun 6, 2026',
        'days': 5,
        'style': 'Economy',
        'interests': ['History', 'Art', 'Desert'],
        'accentColor': 'yellow',
      },
    ];
  }

  // ══════════════════════════════════════════════════════════
  // PLAN TRIP — AI TOUR GENERATION
  // ══════════════════════════════════════════════════════════

  /// Generate a tour itinerary based on user preferences
  static Future<Map<String, dynamic>> generateTour({
    required String destination,
    required DateTime departure,
    required DateTime returnDate,
    required String travelStyle,
    required List<String> interests,
  }) async {
    // Simulate AI thinking time
    await Future.delayed(const Duration(seconds: 3));

    final days = returnDate.difference(departure).inDays + 1;

    return {
      'id': 'tour_new_001',
      'city': destination.toUpperCase(),
      'title': '$destination Adventure',
      'description':
          'Embark on an unforgettable journey through $destination, where ancient wonders meet vibrant street life.',
      'startDate': _formatDate(departure),
      'endDate': _formatDate(returnDate),
      'days': days,
      'style': travelStyle,
      'interests': interests,
      'itinerary': _generateFakeItinerary(destination, days),
    };
  }

  // ══════════════════════════════════════════════════════════
  // TOUR DETAIL
  // ══════════════════════════════════════════════════════════

  /// Fetch a single tour by ID
  static Future<Map<String, dynamic>> getTourById(String tourId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return {
      'id': tourId,
      'city': 'CAIRO',
      'title': 'Cairo Adventure',
      'description':
          'Embark on an unforgettable journey through Cairo, where ancient wonders meet vibrant street life.',
      'startDate': 'May 16, 2026',
      'endDate': 'May 23, 2026',
      'days': 8,
      'style': 'Comfort',
      'itinerary': _generateFakeItinerary('Cairo', 8),
    };
  }

  // ══════════════════════════════════════════════════════════
  // HELPERS (private)
  // ══════════════════════════════════════════════════════════

  static String _formatDate(DateTime d) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }

  static List<Map<String, dynamic>> _generateFakeItinerary(
      String destination, int days) {
    // Pool of activities per destination
    final Map<String, List<Map<String, dynamic>>> pool = {
      'Cairo': [
        {'emoji': '🏛️', 'time': '9:00 AM', 'duration': '3 hrs', 'title': 'Giza Pyramid Complex', 'color': 'blue'},
        {'emoji': '🥗', 'time': '12:30 PM', 'duration': '1.5 hrs', 'title': 'Lunch at Felfela', 'color': 'orange'},
        {'emoji': '🏛️', 'time': '2:00 PM', 'duration': '1 hr', 'title': 'Great Sphinx of Giza', 'color': 'blue'},
        {'emoji': '🌙', 'time': '3:30 PM', 'duration': '1.5 hrs', 'title': 'Sound and Light Show', 'color': 'purple'},
        {'emoji': '🏺', 'time': '9:00 AM', 'duration': '3 hrs', 'title': 'Egyptian Museum', 'color': 'blue'},
        {'emoji': '🛍️', 'time': '1:00 PM', 'duration': '2 hrs', 'title': 'Khan el-Khalili Bazaar', 'color': 'green'},
        {'emoji': '🕌', 'time': '3:30 PM', 'duration': '1 hr', 'title': 'Al-Azhar Mosque', 'color': 'blue'},
        {'emoji': '🚢', 'time': '8:00 AM', 'duration': '4 hrs', 'title': 'Nile Felucca Cruise', 'color': 'cyan'},
      ],
      'Luxor': [
        {'emoji': '👑', 'time': '8:00 AM', 'duration': '4 hrs', 'title': 'Valley of the Kings', 'color': 'yellow'},
        {'emoji': '🏛️', 'time': '1:00 PM', 'duration': '2 hrs', 'title': 'Karnak Temple', 'color': 'blue'},
        {'emoji': '🚢', 'time': '6:00 PM', 'duration': '2 hrs', 'title': 'Nile Sunset Cruise', 'color': 'cyan'},
        {'emoji': '🎨', 'time': '9:00 AM', 'duration': '2 hrs', 'title': 'Luxor Museum', 'color': 'purple'},
      ],
      'Aswan': [
        {'emoji': '🐪', 'time': '9:00 AM', 'duration': '3 hrs', 'title': 'Nubian Village Tour', 'color': 'orange'},
        {'emoji': '🏛️', 'time': '1:00 PM', 'duration': '2 hrs', 'title': 'Philae Temple', 'color': 'blue'},
        {'emoji': '🚢', 'time': '5:00 PM', 'duration': '2 hrs', 'title': 'Felucca Ride at Sunset', 'color': 'cyan'},
      ],
    };

    final activities = pool[destination] ?? pool['Cairo']!;

    // Build itinerary: one list of activities per day
    return List.generate(days, (dayIndex) {
      final startIndex = (dayIndex * 3) % activities.length;
      final dayActivities = [
        activities[startIndex % activities.length],
        activities[(startIndex + 1) % activities.length],
        activities[(startIndex + 2) % activities.length],
      ];
      return {
        'dayNumber': dayIndex + 1,
        'title': _dayTitle(dayIndex),
        'activities': dayActivities,
      };
    });
  }

  static String _dayTitle(int index) {
    const titles = [
      '✨ Ancient Wonders & Pyramids',
      '🏺 Museums & History',
      '🚢 Nile & Local Life',
      '🛍️ Bazaars & Food',
      '🌅 Desert & Sunsets',
      '🎨 Art & Culture',
      '🕌 Mosques & Architecture',
      '🌊 Leisure & Relaxation',
    ];
    return titles[index % titles.length];
  }
}
