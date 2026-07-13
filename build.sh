#!/bin/bash

# 1. Clone Flutter stable channel
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# 2. Add Flutter to the path
export PATH="$PATH:`pwd`/flutter/bin"

# 3. Enable web builds and run doctor to check
flutter config --enable-web
flutter doctor

# 4. Build the Flutter Web App
flutter build web --release

# 5. Vercel expects the output in a specific folder, let's make sure it's ready
# (Vercel will look inside build/web based on Step 2)
