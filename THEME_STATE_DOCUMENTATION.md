# ThemeState Documentation

## Overview
The `ThemeState` class is a comprehensive state management solution for handling theme-related data in the Read Right app. It uses the BLoC pattern to manage gender-based themes with proper state immutability.

## Features

### 1. **Gender-Based Theming**
- Supports two theme variants: Male (Blue) and Female (Pink)
- Stores current gender selection
- Provides type-safe gender enum

### 2. **State Management**
- Immutable state object
- Proper state copying with `copyWith()`
- Loading state support
- Current theme data storage

### 3. **Color Management**
- Stores primary color for quick access
- Gender-specific color constants
- Easy color retrieval

---

## Class Structure

### ThemeState Properties

```dart
class ThemeState {
  final ThemeData themeData;      // Current theme configuration
  final Gender gender;             // Current gender (male/female)
  final Color primaryColor;        // Primary color for current theme
  final bool isLoading;            // Loading state indicator
}
```

### Gender Enum

```dart
enum Gender { male, female }
```

---

## Usage Examples

### 1. Creating Initial State
```dart
// Default male theme
final state = ThemeState.initial();
```

### 2. Copying State with Changes
```dart
// Update only gender
final newState = state.copyWith(
  gender: Gender.female,
);

// Update theme and loading state
final loadingState = state.copyWith(
  isLoading: true,
);

// Update multiple properties
final updatedState = state.copyWith(
  gender: Gender.female,
  themeData: ThemeState.getThemeForGender(Gender.female),
  primaryColor: ThemeState.getColorForGender(Gender.female),
  isLoading: false,
);
```

### 3. Accessing State Properties
```dart
// Check current gender
bool isBoy = state.isMale;       // true/false
bool isGirl = state.isFemale;    // true/false

// Get gender as string
String genderStr = state.genderString;  // 'male' or 'female'

// Access theme data
ThemeData theme = state.themeData;
Color primary = state.primaryColor;
```

---

## Static Helper Methods

### 1. Gender Conversion
```dart
// String to Gender enum
Gender gender = ThemeState.genderFromString('male');    // Gender.male
Gender gender = ThemeState.genderFromString('female');  // Gender.female
Gender gender = ThemeState.genderFromString('invalid'); // Gender.male (default)
```

### 2. Theme Generation
```dart
// Get theme for specific gender
ThemeData maleTheme = ThemeState.getThemeForGender(Gender.male);
ThemeData femaleTheme = ThemeState.getThemeForGender(Gender.female);
```

### 3. Color Retrieval
```dart
// Get primary color for gender
Color blueColor = ThemeState.getColorForGender(Gender.male);      // #2196F3
Color pinkColor = ThemeState.getColorForGender(Gender.female);    // #E91E63
```

---

## Integration with ThemeCubit

### Loading Theme on App Start
```dart
// In ThemeCubit
Future<void> loadTheme() async {
  emit(state.copyWith(isLoading: true));
  
  final prefs = await SharedPreferences.getInstance();
  final genderString = prefs.getString('user_gender') ?? 'male';
  final gender = ThemeState.genderFromString(genderString);
  
  emit(state.copyWith(
    gender: gender,
    themeData: ThemeState.getThemeForGender(gender),
    primaryColor: ThemeState.getColorForGender(gender),
    isLoading: false,
  ));
}
```

### Updating Theme
```dart
// In ThemeCubit
Future<void> updateTheme(String genderString) async {
  emit(state.copyWith(isLoading: true));
  
  final gender = ThemeState.genderFromString(genderString);
  
  emit(state.copyWith(
    gender: gender,
    themeData: ThemeState.getThemeForGender(gender),
    primaryColor: ThemeState.getColorForGender(gender),
    isLoading: false,
  ));
}
```

### Using in Widget
```dart
BlocBuilder<ThemeCubit, ThemeState>(
  builder: (context, themeState) {
    return MaterialApp(
      theme: themeState.themeData,
      home: MyHomePage(
        primaryColor: themeState.primaryColor,
        isMaleTheme: themeState.isMale,
      ),
    );
  },
)
```

---

## Theme Configuration

### Male Theme (Blue)
```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2196F3)),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color(0xFF2196F3),  // Blue
)
```

### Female Theme (Pink)
```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE91E63)),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color(0xFFE91E63),  // Pink
)
```

---

## Best Practices

### 1. Always Use copyWith()
```dart
// ✅ GOOD
emit(state.copyWith(gender: Gender.female));

// ❌ BAD - Don't create new instances directly
emit(ThemeState(
  themeData: state.themeData,
  gender: Gender.female,
  primaryColor: state.primaryColor,
));
```

### 2. Show Loading State for Async Operations
```dart
// ✅ GOOD
emit(state.copyWith(isLoading: true));
await someAsyncOperation();
emit(state.copyWith(isLoading: false));

// ❌ BAD - No loading indicator
await someAsyncOperation();
emit(newState);
```

### 3. Use Type-Safe Gender Enum
```dart
// ✅ GOOD
if (state.gender == Gender.male) {
  // Do something
}

// ❌ BAD - String comparison
if (state.genderString == 'male') {
  // Do something
}
```

### 4. Access Properties, Don't Recalculate
```dart
// ✅ GOOD - Use stored value
Color color = state.primaryColor;

// ❌ BAD - Recalculate
Color color = ThemeState.getColorForGender(state.gender);
```

---

## Common Patterns

### Pattern 1: Conditional UI Based on Gender
```dart
Widget build(BuildContext context) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) {
      return Container(
        color: state.isMale ? Colors.blue.shade50 : Colors.pink.shade50,
        child: Text(
          state.isMale ? 'Welcome Boy!' : 'Welcome Girl!',
          style: TextStyle(color: state.primaryColor),
        ),
      );
    },
  );
}
```

### Pattern 2: Theme-Aware Button
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: context.read<ThemeCubit>().primaryColor,
  ),
  onPressed: () {},
  child: Text('Click Me'),
)
```

### Pattern 3: Loading Indicator
```dart
BlocBuilder<ThemeCubit, ThemeState>(
  builder: (context, state) {
    if (state.isLoading) {
      return CircularProgressIndicator(
        color: state.primaryColor,
      );
    }
    return YourContentWidget();
  },
)
```

---

## Advantages of ThemeState

### 1. **Type Safety**
- Gender enum prevents invalid values
- Compile-time error checking

### 2. **Immutability**
- State cannot be accidentally modified
- Predictable state changes

### 3. **Performance**
- Cached theme data (no regeneration)
- Efficient state copying

### 4. **Maintainability**
- Single source of truth for theme
- Easy to extend with new properties

### 5. **Testability**
- Easy to create test states
- Predictable state transitions

---

## Migration from Old Implementation

### Before (Direct ThemeData)
```dart
class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(defaultTheme);
  
  void updateTheme(String gender) {
    emit(gender == 'male' ? maleTheme : femaleTheme);
  }
}
```

### After (ThemeState)
```dart
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());
  
  void updateTheme(String gender) {
    final genderEnum = ThemeState.genderFromString(gender);
    emit(state.copyWith(
      gender: genderEnum,
      themeData: ThemeState.getThemeForGender(genderEnum),
      primaryColor: ThemeState.getColorForGender(genderEnum),
    ));
  }
}
```

### Benefits of Migration
- ✅ Access to current gender
- ✅ Access to primary color
- ✅ Loading state support
- ✅ Type-safe operations
- ✅ Better debugging

---

## Testing Examples

### Unit Test for ThemeState
```dart
void main() {
  group('ThemeState', () {
    test('initial state should be male theme', () {
      final state = ThemeState.initial();
      expect(state.isMale, true);
      expect(state.isFemale, false);
      expect(state.genderString, 'male');
    });

    test('copyWith should update properties correctly', () {
      final state = ThemeState.initial();
      final newState = state.copyWith(gender: Gender.female);
      
      expect(newState.isFemale, true);
      expect(newState.gender, Gender.female);
    });

    test('genderFromString should handle invalid input', () {
      expect(ThemeState.genderFromString('male'), Gender.male);
      expect(ThemeState.genderFromString('female'), Gender.female);
      expect(ThemeState.genderFromString('invalid'), Gender.male);
    });
  });
}
```

---

## Troubleshooting

### Issue: State not updating in UI
**Solution:** Ensure you're using BlocBuilder and emitting new state
```dart
// Emit new state
emit(state.copyWith(gender: Gender.female));
```

### Issue: Wrong theme applied
**Solution:** Check gender conversion and theme generation
```dart
final gender = ThemeState.genderFromString(genderStr);
final theme = ThemeState.getThemeForGender(gender);
```

### Issue: Loading state stuck
**Solution:** Always set isLoading to false after operation
```dart
try {
  emit(state.copyWith(isLoading: true));
  await operation();
  emit(state.copyWith(isLoading: false));
} catch (e) {
  emit(state.copyWith(isLoading: false));  // Don't forget!
}
```

---

## Summary

The `ThemeState` class provides:
- ✅ Comprehensive theme management
- ✅ Type-safe gender handling
- ✅ Immutable state pattern
- ✅ Loading state support
- ✅ Easy-to-use helper methods
- ✅ Excellent maintainability

Use it to build robust, maintainable theme systems in your Flutter apps!

