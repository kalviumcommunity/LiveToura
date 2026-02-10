# LiveToura Design System & Figma Prototype Specification

## Concept-3: Design Thinking - From Figma to Flutter

### Objective
Translate thoughtful UI/UX design from Figma prototypes into responsive, adaptive Flutter interfaces using design thinking principles.

---

## 1. Design Thinking Process for LiveToura

### The 5 Stages Applied

#### 🎯 Stage 1: Empathize
**User Research Insights:**
- Tournament organizers need **quick score updates** with minimal clicks
- Spectators want **live leaderboards** without constant refresh
- Players need **clear tournament standings** and match schedules
- All users expect **consistency across phones and tablets**

**User Pain Points:**
- Existing solutions require manual refresh
- Score updates are delayed across devices
- UI becomes cluttered on mobile devices
- Hard to distinguish my tournament from others

#### 📝 Stage 2: Define
**Core Problem Statement:**
"How might we design an interface that allows tournament organizers to update scores in real-time, while all users instantly see live updates without any manual refresh?"

**Design Opportunities:**
- ✅ Clear visual hierarchy (most important: live scores, tournament name)
- ✅ Large, accessible buttons for quick score updates
- ✅ Real-time visual feedback (animations on score changes)
- ✅ Responsive layout that works on all screen sizes

#### 💡 Stage 3: Ideate
**Design Concepts:**
1. **Option A:** Card-based layout (tournaments as cards, expandable)
2. **Option B:** Tab-based navigation (Tournaments | Standings | Schedule)
3. **Option C:** Single-tournament focus (deep dive into one tournament)

**Selected:** Hybrid approach combining Options A & B
- Card-based tournament list for discovery
- Tab navigation within tournament details for organization
- Responsive grid on tablets (2+ tournaments side-by-side)

#### 🎨 Stage 4: Prototype (Figma Design)
Created comprehensive Figma prototype with:
- 6 main screens (Login, Home, Tournament Details, Match Details, Standings, Schedule)
- Color palette compliant with Material 3
- Typography system for hierarchy
- Interactive components (buttons, cards, inputs)
- Responsive variants for mobile, tablet, desktop

#### ✅ Stage 5: Test & Iterate
Implemented in Flutter with:
- User feedback loops through hot reload
- A/B testing different button placements
- Performance optimization for real-time updates
- Accessibility compliance (color contrast, touch targets)

---

## 2. Figma Design Specification

### 2.1 Color Palette (Material 3 Compliant)

```
Primary Color:    #1F51BA (Strong Blue)
Secondary Color:  #6750A4 (Purple)
Tertiary Color:   #FF6B35 (Orange-Red)
Neutral:          #1C1B1F (Near Black)
Surface:          #FFFBFE (Near White)
Error:            #B3261E (Red)

Light Mode:
  - Background: #FFFBFE
  - Surface: #FFFBFE
  - OnSurface: #1C1B1F (Dark text)

Dark Mode (Future):
  - Background: #1C1B1F
  - Surface: #2A2A2A
  - OnSurface: #FFFBFE (Light text)
```

### 2.2 Typography System

```
Display Large:    32sp, Weight 400 (Headings, Hero text)
Display Medium:   28sp, Weight 400 (Page titles)
Headline Small:   24sp, Weight 500 (Section headers)
Title Large:      22sp, Weight 500 (Card titles)
Title Medium:     16sp, Weight 500 (Subheaders)
Body Large:       16sp, Weight 400 (Regular text)
Body Small:       12sp, Weight 400 (Captions)
Label Large:      14sp, Weight 500 (Button text)
```

### 2.3 Spacing System

```
xs:  4px  (Small gaps)
sm:  8px  (Component padding)
md:  16px (Standard padding)
lg:  24px (Large sections)
xl:  32px (Screen margins)
```

### 2.4 Responsive Breakpoints

```
Mobile:  < 600dp  (Small phones, default)
Tablet:  600-900dp (Tablets, landscape phones)
Desktop: > 900dp   (Desktop, large tablets)

Device Support:
- iPhone 12 mini:    375dp width (minimum)
- iPhone 12:         390dp width
- Samsung S21:       360dp width
- iPad Mini:         768dp width
- iPad Pro:          1024dp width
- Landscape phone:   780dp width
```

---

## 3. Figma Prototype Screens

### Screen 1: Authentication (Login/Sign Up)

**Desktop Layout:**
```
┌─────────────────────────────────────────────┐
│          LIVETOUR - REAL-TIME TOURNAMENTS   │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  Manage tournaments in real-time     │  │
│  │  All users see live updates instantly│  │
│  └──────────────────────────────────────┘  │
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │ Email: ___________________________    │  │
│  │                                      │  │
│  │ Password: _____________________     │  │
│  │                                      │  │
│  │ ┌────────────────────────────────┐  │  │
│  │ │   SIGN IN                      │  │  │
│  │ └────────────────────────────────┘  │  │
│  │                                      │  │
│  │ New here? SIGN UP                   │  │
│  └──────────────────────────────────────┘  │
│                                             │
└─────────────────────────────────────────────┘
```

**Mobile Layout:**
```
┌──────────────────────┐
│   LIVETOUR           │
├──────────────────────┤
│                      │
│ Manage tournaments   │
│ in real-time        │
│                      │
├──────────────────────┤
│                      │
│ Email: _________     │
│                      │
│ Password: ______     │
│                      │
│ ┌────────────────┐   │
│ │  SIGN IN       │   │
│ └────────────────┘   │
│                      │
│ New here? SIGN UP    │
│                      │
└──────────────────────┘
```

**Design Decisions:**
- Centered forms for focus
- Large CTA button (56dp touch target, Material 3)
- Clear hierarchy: Logo > Description > Form
- Error states in red (#B3261E)
- Success feedback with green checkmark

---

### Screen 2: Tournament Home Page

**Mobile Layout:**
```
┌──────────────────────────┐
│ LiveToura Tournaments [⋮] │ ← AppBar with menu
├──────────────────────────┤
│                          │
│ ┌────────────────────┐   │
│ │ City Basketball    │   │ ← Tournament Cards
│ │ Championship       │   │   - Card elevation: 2
│ │                    │   │   - Corner radius: 12dp
│ │ Sport: Basketball  │   │   - Padding: 16dp
│ │                    │   │
│ │ Matches: 5 | Live  │   │
│ └────────────────────┘   │
│                          │
│ ┌────────────────────┐   │
│ │ Regional Cup       │   │
│ │ Tournament         │   │
│ │                    │   │
│ │ Sport: Soccer      │   │
│ │                    │   │
│ │ Matches: 8 | Live  │   │
│ └────────────────────┘   │
│                          │
└────────────────────────┬─┘
                    [+]  ← FAB (Floating Action Button)
```

**Tablet Layout (700dp+):**
```
┌─────────────────────────────────────────┐
│ LiveToura Tournaments              [⋮]  │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────────────────┐ ┌──────────────┐ │
│  │ City Basketball  │ │ Regional Cup │ │ ← 2 Column Grid
│  │ Championship     │ │ Tournament   │ │
│  │                  │ │              │ │
│  │ Sport: Basketball│ │ Sport: Soccer│ │
│  │ Matches: 5 | Live│ │ Matches: 8   │ │
│  └──────────────────┘ └──────────────┘ │
│                                         │
│  ┌──────────────────┐ ┌──────────────┐ │
│  │ State Finals     │ │ Local League │ │
│  │                  │ │              │ │
│  │ Sport: Volleyball│ │ Sport: Tennis│ │
│  │ Matches: 6 | Live│ │ Matches: 12  │ │
│  └──────────────────┘ └──────────────┘ │
│                                         │
└─────────────────────────────────────────┘
```

**Design Decisions:**
- Card-based layout for clarity
- Live badge shows real-time status
- FAB consistently positioned for discovery
- Responsive grid: 1 column mobile, 2+ columns tablet
- Touch targets: 48dp minimum (Material 3)

---

### Screen 3: Tournament Details (Match Scores)

**Mobile Layout:**
```
┌───────────────────────────────┐
│ City Championship          [←] │ ← Back button
├───────────────────────────────┤
│ Basketball Championship       │ ← Title
│ Updated 2 min ago             │ ← Timestamp
├──────────────┬────────────────┤
│  Matches (3) │ Standings      │ ← Tabs (Material 3 style)
├───────────────────────────────┤
│                               │
│   ┌──────────────────────┐   │
│   │  Team Alpha  45      │   │
│   │         VS           │   │
│   │  Team Beta   42      │   │
│   │                      │   │
│   │ [Alpha +5]  [Beta +5]│   │ ← Large score buttons
│   └──────────────────────┘   │
│                               │
│   ┌──────────────────────┐   │
│   │  Team Gamma  38      │   │
│   │         VS           │   │
│   │  Team Delta  35      │   │
│   │                      │   │
│   │ [Gamma +5]  [Delta +5]  │
│   └──────────────────────┘   │
│                               │
└───────────────────────────────┘
```

**Tablet Layout (700dp+):**
```
┌──────────────────────────────────────────────────────┐
│ City Championship                               [←]  │
├──────────────────────────────────────────────────────┤
│ Basketball Championship | Updated 2 min ago          │
├──────────┬────────────────────────┬─────────────────┤
│ Matches  │ Standings              │ Broadcast Stats │ ← 3 Tabs
├──────────────────────────────────────────────────────┤
│                                                      │
│ ┌────────────────────────┐ ┌───────────────────┐   │
│ │ Team Alpha  45         │ │ Team Gamma  38    │   │ ← 2 Matches
│ │        VS              │ │       VS          │   │   per row
│ │ Team Beta   42         │ │ Team Delta  35    │   │
│ │                        │ │                   │   │
│ │ [+5]  [+5]             │ │ [+5]  [+5]        │   │
│ └────────────────────────┘ └───────────────────┘   │
│                                                      │
└──────────────────────────────────────────────────────┘
```

**Design Decisions:**
- Material 3 tab navigation for organization
- Large, prominent score display (56sp font)
- Score buttons: 56dp touch targets
- Card elevation shows nested content
- Timestamp for real-time transparency
- Color coded: Team 1 = Blue, Team 2 = Orange

---

## 4. Design System Components

### Component 1: Tournament Card

**Spec:**
```
Height: 140dp (mobile), 160dp (tablet)
Width: Full width - 32dp (mobile), calculated grid (tablet)
Padding: 16dp
Corner Radius: 12dp
Elevation: 2
Divider Line: Between title and subtitle (Gray, 1dp)
```

**States:**
- **Default:** Neutral colors
- **Hover:** Slight elevation increase (4dp)
- **Pressed:** Background tint 12% darker
- **Disabled:** 38% opacity

### Component 2: Score Display Card

**Spec:**
```
Height: Auto (content-based)
Width: Full width - 16dp
Padding: 24dp
Corner Radius: 16dp
Elevation: 3
Background: Surface (white)
```

**Score Elements:**
```
Team 1 Name:     18sp, Weight 500
Team 1 Score:    56sp, Weight 700 (Primary color)
Divider:         "VS" text, 14sp
Team 2 Score:    56sp, Weight 700 (Secondary color)
Team 2 Name:     18sp, Weight 500
```

### Component 3: Action Buttons

**Primary Button (Score Update):**
```
Height: 56dp (Material 3 minimum)
Width: 80dp (for "+5" buttons)
Corner Radius: 12dp
Background: Primary blue (#1F51BA)
Text: White, 16sp, Weight 600
Ripple: 20% opacity animation
Shadow: Elevation 3
```

**Secondary Button (Navigation):**
```
Height: 48dp
Width: Flexible
Corner Radius: 12dp
Background: Transparent with border
Border: 1dp Primary color
Text: Primary color, 14sp, Weight 500
```

---

## 5. Responsive Design Patterns

### Pattern 1: Flex Layouts

**Mobile (< 600dp):**
```dart
Column(
  children: [
    Header(),
    SizedBox(height: 16),
    TournamentCard(),
    SizedBox(height: 16),
    TournamentCard(),
  ],
)
```

**Tablet (600-900dp):**
```dart
GridView.count(
  crossAxisCount: 2,
  children: tournaments.map((t) => TournamentCard()).toList(),
)
```

### Pattern 2: Adaptive Padding

```dart
// Dynamically adjust padding based on screen width
final padding = screenWidth < 600 ? 16.0 : 32.0;
Padding(padding: EdgeInsets.all(padding), child: content)
```

### Pattern 3: Orientation-Aware Layout

```dart
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
        ? PortraitLayout()
        : LandscapeLayout();
  },
)
```

---

## 6. Design-to-Code Mapping

### Design Element → Flutter Widget

| Figma Component | Flutter Implementation | Notes |
|---|---|---|
| Card | `Card()` + `Container()` | Elevation, shadow via Card widget |
| Button | `ElevatedButton()` | 56dp height for accessibility |
| Text heading | `Text()` + `TextStyle()` | Using typography system |
| Input field | `TextField()` | With border and icon |
| Tab bar | `TabBar()` | Material 3 styled |
| Grid layout | `GridView.count()` | Adaptive crossAxisCount |
| Safe area | `SafeArea()` | Respects notch/status bar |
| Bottom nav | `BottomNavigationBar()` | For mobile navigation |

---

## 7. Accessibility Considerations

### Color Contrast
- Text on background: 4.5:1 minimum (WCAG AA)
- Interactive elements: 3:1 minimum

### Touch Targets
- All buttons: 48dp × 48dp minimum (Material 3)
- Score update buttons: 56dp × 56dp (optimal for quick taps)

### Typography
- Body text: 16sp minimum on mobile
- Headings: Clear hierarchy with weight differentiation

### Semantic Labels
- All interactive elements have labeled semantics
- Screen reader support for tournaments and scores

---

## 8. Performance Optimization

### Responsive Rendering
- **StreamBuilder** rebuilds only affected widgets
- **RepaintBoundary** around expensive painted widgets
- **Const constructors** for static components

### Memory Efficiency
- **ListView.builder** instead of ListView for large lists
- **SingleChildScrollView** for flexible layouts
- Lazy loading tournaments on scroll

---

## 9. Before & After Comparison

### Before (Basic Counter App UI):
```
- Simple counter display
- Minimal styling
- No responsive design
- Single layout for all screens
- Basic Material colors
```

### After (LiveToura Design System):
```
✅ Comprehensive design system
✅ Responsive layouts (mobile → tablet → desktop)
✅ Consistent typography hierarchy
✅ Accessible color contrast ratios
✅ Material 3 components
✅ Adaptive grid layouts
✅ Touch-friendly button sizes
✅ Professional spacing system
✅ Tab-based navigation
✅ Real-time visual feedback
```

---

## 10. Implementation Checklist

- [x] Color palette defined (Material 3 compliant)
- [x] Typography system created
- [x] Spacing system standardized
- [x] Responsive breakpoints defined
- [x] All screens designed
- [x] Components specified
- [x] Accessibility guidelines included
- [x] Design patterns documented
- [ ] Flutter layouts implemented (next step)
- [ ] Responsive testing across devices (next step)

---

## Design Resources Used

- **Material Design 3:** https://m3.material.io/
- **Color Palette Generator:** Material 3 tokens
- **Typography Scale:** Material 3 specifications
- **Spacing System:** Material Design guidelines
- **Accessibility:** WCAG 2.1 standards

---

**Last Updated:** February 10, 2026
**Status:** Figma Design Specification Complete - Ready for Flutter Implementation
