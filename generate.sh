#!/bin/bash

# Script to run code generation for Freezed, Riverpod, and JSON serialization

echo "Running code generation..."
flutter pub run build_runner build --delete-conflicting-outputs

echo "Code generation completed!" 