## Adding Your Profile Photo

To add your profile photo to the portfolio:

### Option 1: Use Your Own Photo
1. Choose a professional photo (preferably square, e.g., 500x500px)
2. Rename it to `profile.png` or `profile.jpg`
3. Copy it to: `assets/images/profile.png`
4. Run `flutter pub get` to refresh assets
5. The photo will appear automatically!

### Option 2: Keep the Icon
If you don't add a photo, the app will gracefully fall back to showing a person icon, so your app will still work perfectly.

## Best Practices for Profile Photos
- **Size**: 500x500 pixels or larger (square aspect ratio)
- **Format**: PNG or JPG
- **Background**: Clean, professional background
- **Lighting**: Good, even lighting
- **Expression**: Friendly, professional smile
- **Style**: LinkedIn-style headshot

## Current Setup
The app is configured to look for `assets/images/profile.png` and will automatically display it if found. If the file is missing, it shows a default icon instead.
