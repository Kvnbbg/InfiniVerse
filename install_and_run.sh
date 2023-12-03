#!/bin/bash

# Create a Flutter app and define dependencies in pubspec.yaml

# Use 'cat' to generate the pubspec.yaml file with project details and dependencies
cat > pubspec.yaml <<EOL
name: image_processing_app
description: Flutter application for image processing

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
EOL

# Install dependencies using Flutter pub
flutter pub get

# Check for missing dependencies and install them (this is a duplicate command, consider removing)
flutter pub get

# Run the Flutter app
flutter run

# Display a message indicating the completion of the script
echo "Hello, this is a shell script!"
