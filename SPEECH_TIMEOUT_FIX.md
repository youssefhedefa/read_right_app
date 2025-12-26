# Speech Recognition Timeout Fix

## Problem
You're experiencing `error_speech_timeout` which occurs when:
1. No speech is detected within the timeout period
2. The microphone isn't picking up audio properly
3. The pause detection is too sensitive
4. Network issues (for online recognition)

## Changes Applied

### 1. Extended Timeout Durations
**Before:**
- `listenFor: 30 seconds`
- `pauseFor: 3 seconds`

**After:**
- `listenFor: 60 seconds` - Gives more time for users to speak
- `pauseFor: 5 seconds` - More tolerant of pauses between words

### 2. Improved Error Handling
Added specific handling for timeout errors with user-friendly messages:
```dart
if (error.errorMsg.contains('timeout')) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Speech recognition timeout. Please try again and speak clearly.'),
      backgroundColor: Colors.orange,
      duration: Duration(seconds: 3),
    ),
  );
}
```

### 3. Better Speech Result Feedback
- Added confidence logging to debug recognition quality
- Shows green snackbar when speech is successfully recognized
- Displays preview of recognized text

### 4. Enhanced Listen Options
```dart
SpeechListenOptions(
  partialResults: true,          // Show results as you speak
  onDevice: false,                // Use online (more accurate)
  cancelOnError: true,            // Stop on error
  listenMode: ListenMode.confirmation,
  autoPunctuation: true,          // Auto add punctuation
  enableHapticFeedback: true,     // Physical feedback
)
```

## Troubleshooting Steps

### Step 1: Check Microphone Permissions
Ensure the app has microphone permissions:
```
Settings > Apps > Read Right > Permissions > Microphone > Allow
```

### Step 2: Test Microphone
1. Open the app
2. Click the record button
3. Speak clearly and continuously
4. Don't pause for more than 5 seconds
5. Speak at normal volume (not too quiet)

### Step 3: Check Network Connection
Since `onDevice: false` is set, the app uses Google's online speech recognition which requires internet:
- Ensure device has stable internet connection
- Try switching between WiFi and mobile data

### Step 4: Locale Issues
The app auto-detects locale:
- Arabic speakers: App must be in Arabic mode (`ar_SA`)
- English speakers: App must be in English mode (`en_US`)

### Step 5: Environment
- Avoid noisy environments
- Speak clearly and at normal pace
- Ensure microphone is not blocked or covered

## Common Error Messages & Solutions

### `error_speech_timeout`
**Cause:** No speech detected within timeout period
**Solutions:**
1. Speak immediately after clicking record
2. Speak continuously without long pauses
3. Check microphone is working
4. Increase volume or speak closer to device

### `error_no_match`
**Cause:** Speech was heard but not understood
**Solutions:**
1. Speak more clearly
2. Reduce background noise
3. Use simpler words
4. Check correct language is selected

### `error_network`
**Cause:** Internet connection issues
**Solutions:**
1. Check internet connection
2. Try switching networks
3. Consider using `onDevice: true` for offline recognition (less accurate)

### `error_busy`
**Cause:** Speech recognizer is already running
**Solutions:**
1. Wait for current session to finish
2. Click stop button first
3. Restart the app if stuck

## Alternative Configuration (Offline Mode)

If you experience frequent network issues, you can switch to on-device recognition:

```dart
listenOptions: SpeechListenOptions(
  partialResults: true,
  onDevice: true,  // Change this to true for offline
  cancelOnError: false,  // Don't cancel on minor errors
  listenMode: ListenMode.confirmation,
  autoPunctuation: true,
  enableHapticFeedback: true,
)
```

**Pros of offline:**
- Works without internet
- Faster response time
- More private

**Cons of offline:**
- Less accurate
- Limited language support
- Requires language model downloads

## Testing Checklist

- [ ] Microphone permission granted
- [ ] Internet connection stable
- [ ] Correct language/locale selected
- [ ] No background noise
- [ ] Microphone not blocked
- [ ] Speaking clearly and continuously
- [ ] Not pausing for more than 5 seconds
- [ ] Volume at normal speaking level

## Logs to Monitor

Watch for these logs in your console:
```
Speech status: listening       ✅ Good - Recording started
result.recognizedWords: [text] ✅ Good - Text being recognized
result.confidence: 0.9         ✅ Good - High confidence
Speech status: done            ⚠️  Recording finished
Speech error: error_speech_timeout ❌ Error - No speech detected
```

## Best Practices for Users

1. **Click Record → Start Speaking Immediately**
2. **Speak Continuously** - Don't pause for more than 5 seconds
3. **Speak Clearly** - Normal pace, normal volume
4. **Quiet Environment** - Reduce background noise
5. **Check Text Field** - It updates in real-time as you speak
6. **Wait for Green Message** - Confirms successful recognition
7. **Click Stop** - When finished speaking

## Code Summary

### Key Changes Made:
1. ✅ Extended `listenFor` from 30s to 60s
2. ✅ Extended `pauseFor` from 3s to 5s
3. ✅ Added timeout-specific error handling
4. ✅ Added speech result confidence logging
5. ✅ Added success feedback (green snackbar)
6. ✅ Enabled online recognition for better accuracy
7. ✅ Added auto-punctuation
8. ✅ Added haptic feedback

All changes have been applied and tested. The timeout issue should be resolved if the user speaks within the 60-second window and doesn't pause for more than 5 seconds.

