# Sprint 2 Task 2: Stateless & Stateful Widgets - Submission Guide

## Task Completion Checklist

Complete the following items before submitting your PR:

### Code Implementation
- [ ] Created `lib/screens/stateless_stateful_demo.dart`
- [ ] Implemented at least 2 Stateless widgets
  - [ ] StatelessHeader
  - [ ] StaticInfoCard
- [ ] Implemented at least 2 Stateful widgets
  - [ ] InteractiveCounterWidget
  - [ ] ColorChangerWidget (recommended)
- [ ] Added proper imports and package structure
- [ ] Code follows Flutter best practices
- [ ] Code is properly commented
- [ ] No linting errors: `flutter analyze`

### Testing & Verification
- [ ] Ran app successfully: `flutter run`
- [ ] Tested all interactive elements
- [ ] Verified Stateless widgets remain unchanged during interactions
- [ ] Verified Stateful widgets update when interacting
- [ ] Tested on emulator/device
- [ ] No crashes or errors during testing

### Documentation
- [ ] Created/Updated README with:
  - [ ] Project description
  - [ ] Explanation of Stateless widgets
  - [ ] Explanation of Stateful widgets
  - [ ] Code snippets from implementation
  - [ ] When to use each widget type
  - [ ] Reflection questions answered
- [ ] Created INTEGRATION_GUIDE.md
- [ ] Screenshots captured showing:
  - [ ] Initial UI state
  - [ ] UI after user interaction
  - [ ] Multiple interaction states

### Media & Video
- [ ] Recorded 1-2 minute video demo showing:
  - [ ] App launching with initial state
  - [ ] Interacting with at least 3 different Stateful widgets
  - [ ] Clear visual updates (state changes)
  - [ ] Brief explanation of differences
- [ ] Video quality is acceptable (clear screen, audible narration)
- [ ] Video uploaded to:
  - [ ] Google Drive, OR
  - [ ] Loom, OR
  - [ ] YouTube (unlisted)
- [ ] Link shared with proper permissions (Edit access or "Anyone with link")

### Version Control & PR
- [ ] Local changes committed with clear message
- [ ] Branch created from latest `main`
- [ ] Code pushed to remote
- [ ] Pull Request created with title: `[Sprint-2] Stateless vs Stateful Widgets – TeamName`
- [ ] PR description includes:
  - [ ] Summary of implementation
  - [ ] List of widgets created
  - [ ] Screenshots of UI states
  - [ ] Video demo link
  - [ ] Reflection on learning
- [ ] PR is ready for review

---

## Step-by-Step Submission Process

### Phase 1: Implementation (15-30 minutes)

#### 1.1 Create the Demo File

The `stateless_stateful_demo.dart` file is already created with complete examples. Review it in:
```
lib/screens/stateless_stateful_demo.dart
```

#### 1.2 Add Navigation to Your App

Choose where to add access to the demo (e.g., welcome screen, menu, etc.):

```dart
// Option 1: Add button in existing screen
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatelessStatefulDemoScreen(),
      ),
    );
  },
  child: const Text('View Widgets Demo'),
)

// Option 2: Use named route
Navigator.pushNamed(context, '/widgets-demo');
```

#### 1.3 Test the Implementation

```bash
cd LiveToura
flutter pub get
flutter run
```

---

### Phase 2: Testing (10-15 minutes)

#### 2.1 Verify Stateless Widgets
Run through this checklist:
- [ ] StatelessHeader displays correctly
- [ ] StaticInfoCard shows all content properly
- [ ] These widgets don't change when you interact with Stateful widgets
- [ ] Text, icons, and styling display correctly

#### 2.2 Verify Stateful Widgets
Interact with each widget and verify:

**InteractiveCounterWidget:**
- [ ] Counter starts at 0
- [ ] Clicking Increase increments the counter
- [ ] Clicking Decrease decrements the counter
- [ ] Reset button returns counter to 0
- [ ] Counter doesn't go below 0

**ColorChangerWidget:**
- [ ] Initial color is set correctly (e.g., red)
- [ ] Clicking color circles changes the display
- [ ] Selected color shows border/highlight
- [ ] New color displays immediately

**ThemeToggleWidget:**
- [ ] Button toggles between Light and Dark
- [ ] Icon changes (light_mode ↔ dark_mode)
- [ ] Text color and background change
- [ ] Display text updates

**CombinedInteractiveWidget:**
- [ ] Score starts at 0
- [ ] Add Points button increases score
- [ ] Animation plays when adding points
- [ ] Hide Score button fades score in/out
- [ ] Reset button returns all to initial state

---

### Phase 3: Documentation (10-15 minutes)

#### 3.1 Update README

Edit or create `STATELESS_STATEFUL_README.md` with:

```markdown
# Stateless vs Stateful Widgets Demo

## Overview
[Brief description of your implementation]

## Stateless Widgets Implemented
- [Widget 1] - [Description]
- [Widget 2] - [Description]

## Stateful Widgets Implemented
- [Widget 1] - [Description]
- [Widget 2] - [Description]

## Code Snippets

### Example Stateless Widget
[Include code snippet]

### Example Stateful Widget
[Include code snippet]

## How to Use
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Reflection
- How do Stateful widgets make Flutter apps dynamic?
  [Your answer]
  
- Why is it important to separate static and reactive parts?
  [Your answer]

## Screenshots
[Include 2-3 screenshots showing initial state and interactions]
```

---

### Phase 4: Screenshots (5-10 minutes)

Take screenshots showing:

#### Screenshot 1: Initial UI
- Show the complete demo screen on load
- All widgets visible
- Counter at 0, default color, light mode, score at 0

#### Screenshot 2: After Interactions
- Counter incremented (e.g., showing 5)
- Color changed to different color
- Dark mode toggled
- Score increased (e.g., showing 30)

#### Screenshot 3: Optional - Feature Focus
Show one specific widget in detail, like:
- Color selector with selected color highlighted
- Counter at max value
- Light/Dark mode contrast

**How to Take Screenshots:**
- **Android Emulator**: With emulator running, use `Ctrl + S` or menu option
- **iOS Simulator**: `Cmd + S`
- **Physical Device**: Use device's screenshot button

Save screenshots to:
```
assets/screenshots/
- initial_state.png
- after_interactions.png
- [feature_detail].png
```

---

### Phase 5: Video Recording (10-15 minutes)

#### 5.1 Prepare for Recording
- [ ] Close unnecessary apps
- [ ] Increase font size if needed for clarity
- [ ] Ensure good lighting
- [ ] Test microphone/audio
- [ ] Have script notes ready (optional)

#### 5.2 Recording Script (1-2 minutes)

**Example narration:**
```
"Hello! This is a demo of Stateless and Stateful widgets in Flutter.

Stateless widgets are used for UI that doesn't change. You can see examples like 
the header and information cards up here - they never change unless the parent 
rebuilds them.

Stateful widgets, on the other hand, manage data that can change. Watch as I 
interact with these examples:

[Tap Increase button] - Notice the counter incremented. This StatefulWidget 
tracked the state internally.

[Tap color circle] - The color changed immediately. Another example of state 
management in action.

[Tap toggle button] - Light mode switched to dark mode. The UI responded to 
the state change.

The key difference is that Stateless widgets are for display, while Stateful 
widgets bring interactivity to your app. Understanding when to use each is 
fundamental to building efficient Flutter applications."
```

#### 5.3 Recording Options

**Option A: Using Built-in Tools**
- **Windows**: Use built-in screen recording or OBS Studio
- **Mac**: Use QuickTime Player
- **Mobile**: Use device's screen recording

**Option B: Chrome DevTools (for Flutter web)**
```bash
flutter run -d chrome
# Use browser's developer tools to record
```

**Option C: Third-Party Tools**
- **Loom** (free, easy, good quality)
  1. Go to loom.com
  2. Click "Start Recording"
  3. Select area/window to record
  4. Record narration while demonstrating
  5. Get shareable link
- **ScreenFlow** (Mac, $99)
- **Camtasia** (cross-platform, paid)
- **OBS Studio** (free, open-source)

#### 5.4 Video Requirements
- **Duration**: 1-2 minutes
- **Content**: 
  - App loading
  - At least 3 widget interactions
  - Clear narration explaining the difference
- **Quality**: 
  - Minimum 720p
  - Clear audio (use microphone, not max volume)
  - No background noise if possible
- **Format**: MP4 (most universal)

#### 5.5 Upload Video

**Option 1: Google Drive**
1. Upload your video to Google Drive
2. Right-click → Share
3. Set to "Anyone with the link" and "Editor" access
4. Copy link

**Option 2: Loom**
1. Record in Loom (easiest option)
2. Click "Share" after recording
3. Copy the link provided
4. Loom links don't require account access

**Option 3: YouTube**
1. Go to youtube.com
2. Click "Create" → "Upload video"
3. Upload your video
4. Set visibility to "Unlisted" (not Private)
5. Copy the video URL

**Option 4: OneDrive**
1. Upload to OneDrive
2. Right-click → Share
3. Copy sharing link
4. Ensure permissions are set correctly

---

### Phase 6: Version Control & PR (10-15 minutes)

#### 6.1 Commit Your Changes

```bash
# Navigate to project
cd LiveToura

# Check status
git status

# Stage all changes
git add .

# Commit with clear message
git commit -m "feat: implemented demo showing stateless and stateful widgets

- Created stateless_stateful_demo.dart with multiple widget examples
- Implemented StatelessHeader and StaticInfoCard (Stateless widgets)
- Implemented InteractiveCounterWidget, ColorChangerWidget, ThemeToggleWidget, 
  and CombinedInteractiveWidget (Stateful widgets)
- Added comprehensive documentation and integration guide
- All widgets tested and verified on emulator
- Demonstrates fundamental Flutter widget lifecycle concepts"
```

#### 6.2 Push to Remote

```bash
# Create feature branch (if not already created)
git checkout -b feature/stateless-stateful-demo

# Push branch
git push origin feature/stateless-stateful-demo
```

#### 6.3 Create Pull Request

**Title:**
```
[Sprint-2] Stateless vs Stateful Widgets – TeamName
```

**Description Template:**

```markdown
## Summary
This PR implements a comprehensive demo showcasing Stateless and Stateful 
widgets in Flutter, fundamental building blocks for any Flutter application.

## What's New
- Created `lib/screens/stateless_stateful_demo.dart` with 6 example widgets
- Implemented 2 Stateless widgets: StatelessHeader, StaticInfoCard
- Implemented 4 Stateful widgets with various interactions

## Widgets Implemented

### Stateless Widgets
- **StatelessHeader**: Displays static title and description
- **StaticInfoCard**: Shows information with icon, title, and content

### Stateful Widgets
- **InteractiveCounterWidget**: Increment/decrement/reset counter
- **ColorChangerWidget**: Select from color palette
- **ThemeToggleWidget**: Toggle between light and dark mode
- **CombinedInteractiveWidget**: Multiple state variables with animations

## Testing
- ✅ All widgets render correctly
- ✅ Stateless widgets remain unchanged during interactions
- ✅ Stateful widgets update UI on state changes
- ✅ All buttons and interactions work as expected
- ✅ Tested on emulator at 1280x720

## Screenshots
[Include 2-3 screenshots showing initial and interactive states]

## Video Demo
[Link to 1-2 minute video demo showing all widgets in action]

## Key Learning
- Stateless widgets are for static UI (no state management needed)
- Stateful widgets enable dynamic, interactive UIs
- setState() method rebuilds only the affected widget
- Proper widget selection improves app performance and maintainability

## How to Test
1. Navigate to the demo screen using the button added to [screen name]
2. Interact with counter (increase, decrease, reset)
3. Select different colors to see immediate UI update
4. Toggle between light and dark mode
5. Add points and toggle score visibility

[Include any additional notes or observations]
```

#### 6.4 Configure PR Settings
- [ ] Title matches format: `[Sprint-2] Stateless vs Stateful Widgets – TeamName`
- [ ] Description includes all required sections
- [ ] Screenshots are visible in PR
- [ ] Video link is accessible and works
- [ ] All checks pass

---

## Final Checklist Before Submission

### Code Quality
- [ ] `flutter analyze` shows no issues
- [ ] `flutter format .` has been run
- [ ] Code is readable and well-commented
- [ ] No console errors or warnings

### Documentation
- [ ] README is complete and accurate
- [ ] Code snippets are included
- [ ] Reflection questions are answered thoroughly
- [ ] Integration guide is provided

### Testing
- [ ] App builds without errors
- [ ] All widgets display correctly
- [ ] All interactions work as expected
- [ ] Tested on actual emulator/device

### Submission Materials
- [ ] Screenshots captured and saved
- [ ] Video recorded and uploaded
- [ ] Video link tested and accessible
- [ ] PR created with complete description

### PR Ready
- [ ] All files committed and pushed
- [ ] PR title follows format
- [ ] PR description is comprehensive
- [ ] At least one review requested (optional)

---

## Common Issues & Solutions

### Issue: Widgets don't update when I tap buttons
**Solution**: Make sure you're calling `setState()` inside the Stateful widget's state class

### Issue: Video upload is too large
**Solution**: 
- Use Loom (compresses automatically)
- Reduce resolution to 720p
- Use YouTube's compression

### Issue: Code has linting errors
**Solution**:
```bash
flutter format .
flutter analyze
```

### Issue: App crashes when navigating to demo
**Solution**:
- Verify import statement at top of file
- Ensure `StatelessStatefulDemoScreen` is exported correctly
- Check for missing dependencies in pubspec.yaml

### Issue: PR conflicts with main branch
**Solution**:
```bash
# Update main locally
git fetch origin
git rebase origin/main

# Resolve conflicts if any, then:
git push origin feature/stateless-stateful-demo --force-with-lease
```

---

## Submission Deadline Reminder

⏰ Submit your PR by [deadline date]

Include:
1. ✅ Code implementation
2. ✅ README with explanations and reflection
3. ✅ Screenshots (at least 2)
4. ✅ 1-2 minute video demo
5. ✅ PR with complete description

---

## Example PR (Reference)

**Title**: `[Sprint-2] Stateless vs Stateful Widgets – Team Alpha`

**Includes**:
- Link to code: `lib/screens/stateless_stateful_demo.dart`
- Screenshots showing initial and interactive states
- 1.5 minute Loom video showing all widgets in action
- Detailed reflection on learning
- Clear explanation of when to use each widget type

---

Good luck with your submission! 🚀
