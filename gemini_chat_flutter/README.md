# Gemini Chat Flutter

A 100% faithful Flutter migration of the React web Gemini Chat application, featuring a unique zoom drawer sidebar animation and comprehensive AI chat functionality.

## Features

✅ **Zoom Drawer Animation** - Unique sidebar with scale/slide animation effect
✅ **Chat Interface** - Full-featured chat with Gemini AI integration
✅ **Streaming Responses** - Real-time streaming of AI responses
✅ **Quick Phrases** - Shortcut system for frequently used prompts
✅ **Tool Popups** - History, Model selection, MCP tools, and Quick phrases
✅ **Expandable Input Menu** - Camera, Gallery, and File attachment options
✅ **Dark Mode Support** - Full light/dark theme support
✅ **Markdown Rendering** - Rich text formatting in AI responses
✅ **Settings Page** - Comprehensive settings management
✅ **Material 3 Design** - Modern UI with Tailwind-inspired colors

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models with Freezed
│   ├── message.dart
│   ├── assistant.dart
│   ├── chat_session.dart
│   └── quick_phrase.dart
├── providers/                # Riverpod state management
│   ├── messages_provider.dart
│   ├── quick_phrases_provider.dart
│   └── gemini_service_provider.dart
├── screens/                  # Main screens
│   ├── home_screen.dart      # Zoom drawer container
│   ├── chat_screen.dart      # Chat interface
│   └── settings_screen.dart  # Settings page
├── widgets/                  # Reusable widgets
│   ├── sidebar.dart          # Sidebar navigation
│   └── input_bar.dart        # Complex input component
├── services/                 # Business logic
│   └── gemini_service.dart   # Gemini AI integration
└── theme/                    # Theme configuration
    └── app_theme.dart        # Tailwind-inspired colors
```

## Setup Instructions

### Prerequisites

- Flutter SDK 3.38.3 or higher
- Dart 3.10.1 or higher
- Android Studio / VS Code with Flutter extensions
- Gemini API Key

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Freezed code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Configure API Key**

   Edit the `.env` file in the project root:
   ```
   API_KEY=your_gemini_api_key_here
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Key Components

### 1. Zoom Drawer Animation

The unique sidebar animation is implemented in [home_screen.dart](lib/screens/home_screen.dart) using:
- `AnimationController` for smooth transitions
- `Transform.translate` for horizontal sliding
- `Transform.scale` for zoom effect
- `ClipRRect` for rounded corners during animation

### 2. Input Bar

The complex input bar ([input_bar.dart](lib/widgets/input_bar.dart)) features:
- Expandable media menu (camera, gallery, file)
- Tool popups (history, model, MCP, quick phrases)
- Auto-suggestion based on shortcuts
- Adaptive send button styling

### 3. Chat Screen

The chat interface ([chat_screen.dart](lib/screens/chat_screen.dart)) includes:
- Auto-scrolling message list
- Streaming AI responses
- Markdown rendering
- Loading indicators
- Empty state UI

### 4. State Management

Using Riverpod for:
- Message history management
- Quick phrases storage
- Gemini service provider
- Global app state

## Architecture Decisions

### Why Riverpod?
- Type-safe state management
- Better testability
- Compile-time safety
- No BuildContext required

### Why Freezed?
- Immutable data models
- JSON serialization
- Copy-with functionality
- Union types support

### Why Material 3?
- Modern design system
- Built-in dark mode
- Adaptive components
- Better accessibility

## Tailwind to Flutter Color Mapping

```dart
primaryColor: Color(0xFFE4D5D5)
backgroundLight: Color(0xFFFFFFFF)
backgroundDark: Color(0xFF121212)
gray100-900: Tailwind gray scale
accentBrown: Color(0xFF8B5E3C)
```

## Running on Different Platforms

### Android
```bash
flutter run -d android
```

### iOS
```bash
flutter run -d ios
```

### Web (experimental)
```bash
flutter run -d chrome
```

## Development Tips

### Hot Reload
Press `r` in the terminal or use IDE hot reload button

### Hot Restart
Press `R` in the terminal for full restart

### Debug Mode
The app runs in debug mode by default with performance overlay available

### Release Build
```bash
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## Troubleshooting

### Build Runner Issues
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### API Key Not Working
- Ensure `.env` file is in project root
- Check API key is valid
- Verify `.env` is listed in `pubspec.yaml` assets

### Dependency Conflicts
```bash
flutter pub upgrade
```

## Migration Notes

This Flutter app is a 100% visual and functional recreation of the React web version with the following enhancements:

1. **Native Performance** - Smooth 60fps animations
2. **Better Scrolling** - Native scroll physics
3. **Offline Support** - Can be extended with local storage
4. **Platform Integration** - Native camera, gallery, file picker
5. **Smaller Bundle** - Optimized for mobile

## Future Enhancements

- [ ] Local message persistence
- [ ] Image upload support
- [ ] Voice input
- [ ] Multi-language support
- [ ] Custom assistant creation
- [ ] MCP server integration
- [ ] Search history functionality

## License

This project is for educational purposes.

## Credits

Migrated from React web version to Flutter with 100% fidelity.
