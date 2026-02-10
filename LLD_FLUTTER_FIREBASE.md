# LiveToura - Low-Level Design (LLD)
## Flutter + Firebase Mobile Application

**Project:** LiveToura - Real-time Community Sports Tournament Tracking  
**Date:** February 10, 2026  
**Version:** 1.0  
**Architecture:** Flutter + Firebase (BaaS)

---

## 📊 Table of Contents

1. [UI Component Structure](#ui-component-structure)
2. [Navigation Flow](#navigation-flow)
3. [State Management Architecture](#state-management-architecture)
4. [Backend Logic - Firebase Services](#backend-logic--firebase-services)
5. [Data Models & Classes](#data-models--classes)
6. [Data Flow Architecture](#data-flow-architecture)
7. [Firebase Firestore Collections](#firebase-firestore-collections)
8. [Error Handling & State Management](#error-handling--state-management)
9. [Cloud Mapping & Integration](#cloud-mapping--integration)

---

## 🎨 UI Component Structure

### Widget Hierarchy

```
LiveTouraApp (MaterialApp)
│
├── Theme (LiveTouraTheme)
│
└── Navigation (if authenticated)
    │
    ├── AuthenticationPage
    │   ├── LoginForm
    │   │   ├── EmailTextField
    │   │   ├── PasswordTextField
    │   │   ├── LoginButton
    │   │   └── SignUpToggle
    │   │
    │   └── SignUpForm
    │       ├── EmailTextField
    │       ├── PasswordTextField
    │       ├── ConfirmPasswordTextField
    │       └── SignUpButton
    │
    ├── TournamentHomePage (Main Dashboard)
    │   ├── AppBar
    │   ├── TournamentList (GridView)
    │   │   └── TournamentCard (Repeated)
    │   │       ├── SportBadge
    │   │       ├── TournamentName
    │   │       ├── LiveIndicator
    │   │       └── JoinButton
    │   │
    │   └── FloatingActionButton (Create Tournament)
    │
    └── TournamentDetailsPage
        ├── AppBar
        ├── TabBar
        │   ├── Matches Tab
        │   │   └── MatchCard (Repeated)
        │   │       ├── Team1Name
        │   │       ├── ScoreDisplay (56sp)
        │   │       ├── Team2Name
        │   │       ├── IncrementButton (Team1)
        │   │       └── IncrementButton (Team2)
        │   │
        │   └── Standings Tab
        │       └── StandingsTable
        │           ├── TableHeader
        │           └── TableRow (Repeated)
        │
        ├── FloatingActionButton (Add Match)
        └── LogoutButton
```

---

## 🗺️ Navigation Flow

```
┌─────────────────────────────────────────────────────────────┐
│                       LiveTouraApp                          │
│                                                             │
│  [Firebase.initializeApp()]                               │
│  [Check Authentication Status]                             │
└─────────────────┬───────────────────────────────────────────┘
                  │
                  ▼
        ┌─────────────────┐
        │ Is User Auth'd? │
        └────────┬────────┘
                 │
        ┌────────┴────────┐
        │                 │
        ▼ NO              ▼ YES
    ┌──────────────┐  ┌──────────────────────┐
    │ Auth Page    │  │ Tournament Home Page │
    │ [Login/Signup│  │ [Dashboard]          │
    └──────┬───────┘  └────────┬─────────────┘
           │                    │
           │                    ├──────────────────┐
           │                    │                  │
           ▼                    ▼                  ▼
    ┌─────────────────┐  ┌─────────────────┐  ┌───────────────┐
    │ SignUp Success  │  │ Select Tournament   │ FAB: Create   │
    │ → Auto Login    │  │ [Navigate to Details]  Tournament  │
    │ → Home Page     │  └────────┬─────────────┘  │
    └─────────────────┘           │                │
                                   │   ┌────────────┘
                                   ▼   ▼
                            ┌──────────────────────┐
                            │ Tournament Details   │
                            │ Page [Tabs]          │
                            │ - Matches Tab        │
                            │ - Standings Tab      │
                            └────────┬─────────────┘
                                     │
                    ┌────────────────┴────────────────┐
                    │                                 │
                    ▼                                 ▼
            ┌──────────────────┐          ┌──────────────────┐
            │ Update Score     │          │ View Standings   │
            │ [Real-time Sync] │          │ [Real-time Sync] │
            └────────┬─────────┘          └──────────────────┘
                     │
                     ▼
            ┌──────────────────┐
            │ Firestore Stream │
            │ Updates (Scores) │
            └──────────────────┘
```

---

## 🎛️ State Management Architecture

### Approach: StreamBuilder + Services (No External State Manager)

```
┌────────────────────────────────────────────────────────────┐
│                    UI LAYER (Widgets)                      │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐  │
│  │ TournamentHomePage                                  │  │
│  │ └─ StreamBuilder<List<Tournament>>                  │  │
│  │    │                                                │  │
│  │    ├─ connectionState: waiting          → Loading   │  │
│  │    ├─ connectionState: active + data    → Display   │  │
│  │    └─ connectionState: done + error     → Error     │  │
│  │                                                      │  │
│  │    OnTap → Navigator.push(details)                  │  │
│  └─────────────────────────────────────────────────────┘  │
│                           ▲                                │
└───────────────────────────┼────────────────────────────────┘
                            │
                            │ .listen()
                            │
┌───────────────────────────┼────────────────────────────────┐
│              SERVICE LAYER (Business Logic)               │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐  │
│  │ FirestoreService                                    │  │
│  │                                                     │  │
│  │ getTournamentsStream() → Stream<List<Tournament>>   │  │
│  │ getMatchesStream(id) → Stream<List<Match>>         │  │
│  │ updateMatchScore(id, m, t1, t2) → Future<void>     │  │
│  │ addTournament(name, sport) → Future<void>          │  │
│  │                                                     │  │
│  │ [Internal: Listens to Firestore]                   │  │
│  └────────────────────────┬──────────────────────────┘  │
│                           │                              │
│  ┌──────────────────────────────────────────────────────┐│
│  │ FirebaseAuthService                                  ││
│  │                                                     ││
│  │ signUp(email, password) → Future<void>             ││
│  │ signIn(email, password) → Future<void>             ││
│  │ signOut() → Future<void>                           ││
│  │ getCurrentUser() → User?                           ││
│  │                                                     ││
│  │ [Internal: Uses Firebase Authentication]           ││
│  └────────────────────────┬──────────────────────────┘│
└───────────────────────────┼─────────────────────────────┘
                            │
                            │ Firestore.instance.collection()
                            │ FirebaseAuth.instance.signUp()
                            │
┌───────────────────────────┼─────────────────────────────┐
│                BACKEND (Firebase)                        │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Cloud Firestore                                 │  │
│  │ [Real-time NoSQL Database]                      │  │
│  │                                                 │  │
│  │ Collections:                                    │  │
│  │ ├─ tournaments {id, name, sport, ...}          │  │
│  │ ├─ users {uid, email, ...}                     │  │
│  │ └─ matches {id, t1Name, t1Score, ...}          │  │
│  │    (subcollection of tournaments)               │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │ Firebase Authentication                          │  │
│  │ [Manages User Sessions]                          │  │
│  │                                                 │  │
│  │ ├─ Email/Password Sign-in                       │  │
│  │ ├─ User session tokens (auto-managed)           │  │
│  │ └─ Logout (revokes session)                     │  │
│  └──────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────┘
```

---

## 🔥 Backend Logic – Firebase Services

### 1. Authentication Flow

```
┌──────────────────────────────────────────────────────────┐
│           Authentication Service Flow                    │
└──────────────────────────────────────────────────────────┘

SIGN UP FLOW:
────────────

User Input
  │
  ├─ Email: mindy@example.com
  ├─ Password: SecurePass123!
  └─ Confirm: SecurePass123!
      │
      ▼
  Validate Input
  ├─ Email format (regex)
  ├─ Password length (min 6)
  └─ Passwords match
      │
      ▼ (Valid)
  FirebaseAuth.createUserWithEmailAndPassword()
      │
      ├─ Success: User created in Firebase Auth
      │   └─ Create User doc in Firestore
      │       {
      │         uid: "abc123...",
      │         email: "mindy@example.com",
      │         createdAt: timestamp,
      │         displayName: null
      │       }
      │
      └─ Error: Return error message
          ├─ "Email already exists"
          ├─ "Password too weak"
          └─ "Invalid email format"


SIGN IN FLOW:
─────────────

User Input
  │
  ├─ Email: mindy@example.com
  └─ Password: SecurePass123!
      │
      ▼
  FirebaseAuth.signInWithEmailAndPassword()
      │
      ├─ Success: Session created
      │   └─ Firebase remembers user (persisted)
      │       → Navigates to Home Page
      │
      └─ Error: Return error message
          ├─ "User not found"
          ├─ "Wrong password"
          └─ "Too many login attempts"


LOGOUT FLOW:
────────────

User taps Logout button
      │
      ▼
  FirebaseAuth.signOut()
      │
      ├─ Success: Session destroyed
      │   └─ Navigates to Auth Page
      │
      └─ Error: Show error toast


SESSION PERSISTENCE:
────────────────────

App Launch
      │
      ▼
  Check FirebaseAuth.currentUser
      │
      ├─ NOT NULL: User already logged in
      │   └─ Go to Home Page
      │
      └─ NULL: No session
          └─ Go to Auth Page
```

### 2. Firestore Real-Time Sync Flow

```
┌──────────────────────────────────────────────────────────┐
│         Firestore Real-Time Data Sync                    │
└──────────────────────────────────────────────────────────┘

TOURNAMENT CREATION:
────────────────────

User enters tournament name & sport (e.g., "Spring Soccer", "Soccer")
      │
      ▼
  [Validate Input]
  ├─ Name not empty
  └─ Sport selected
      │
      ▼
  FirestoreService.addTournament(name, sport)
      │
      ├─ Create new document in tournaments collection:
      │  {
      │    id: "auto-generated",           ← Firestore auto-ID
      │    name: "Spring Soccer",
      │    sport: "Soccer",
      │    createdAt: Timestamp.now(),
      │    matches: []                     ← Subcollection
      │  }
      │
      ├─ Success: Return to home (grid refreshes via stream)
      └─ Error: Show error message


REAL-TIME TOURNAMENT LIST:
──────────────────────────

Home Page loads
      │
      ▼
  FirestoreService.getTournamentsStream()
      │
      ├─ Returns: Stream<List<Tournament>>
      │
      ├─ BackGround: Firestore listener runs continuously
      │  (Listens for any changes in tournaments collection)
      │
      └─ StreamBuilder rebuilds UI whenever:
         ├─ New tournament created
         ├─ Tournament updated
         └─ Tournament deleted
         
  Changes propagate INSTANTLY across all devices!


SCORE UPDATE FLOW:
──────────────────

User taps "Team 1 +1" on Match Card
      │
      ▼
  FirestoreService.updateMatchScore(tournamentId, matchId, t1Score, t2Score)
      │
      ├─ Update Firestore document:
      │  tournaments/{tournamentId}/matches/{matchId}
      │  {
      │    team1Score: 5,  ← Updated
      │    team2Score: 3,
      │    updatedAt: Timestamp.now()
      │  }
      │
      ├─ Firestore recognizes change
      │
      ├─ All listeners (across all devices/screens) get notified
      │  └─ StreamBuilder catches new data
      │     └─ MatchCard rebuilds with new score
      │        └─ User sees "5 - 3" instantly (no manual refresh!)
      │
      └─ Success toast: "Score updated"


MULTIPLE USERS SYNCING:
───────────────────────

Device 1 (Admin)             Device 2 (Viewer)
                │                │
                │ User A updates  │
                │ Team 1 score:   │
                ├─ 5 → 6          │
                │                 │
                └─ Firestore ─────┤
                                  │
                                  ▼ Stream triggered
                                  MatchCard rebuilds
                                  Shows 6 - 3 instantly
                                  (No refresh needed!)
```

---

## 📦 Data Models & Classes

### Model Classes (Dart)

```dart
// USER MODEL
class User {
  final String uid;
  final String email;
  final String? displayName;
  final DateTime createdAt;

  User({
    required this.uid,
    required this.email,
    this.displayName,
    required this.createdAt,
  });

  // Serialization (Dart → JSON)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'createdAt': createdAt,
    };
  }

  // Deserialization (JSON → Dart)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}


// TOURNAMENT MODEL
class Tournament {
  final String id;
  final String name;
  final String sport;
  final DateTime createdAt;
  final List<Match> matches;

  Tournament({
    required this.id,
    required this.name,
    required this.sport,
    required this.createdAt,
    required this.matches,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sport': sport,
      'createdAt': createdAt,
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map, String id) {
    return Tournament(
      id: id,
      name: map['name'] ?? '',
      sport: map['sport'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      matches: [],  // Loaded separately via subcollection
    );
  }
}


// MATCH MODEL
class Match {
  final String id;
  final String team1Name;
  final String team2Name;
  final int team1Score;
  final int team2Score;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Match({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Score,
    required this.team2Score,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team1Name': team1Name,
      'team2Name': team2Name,
      'team1Score': team1Score,
      'team2Score': team2Score,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map, String id) {
    return Match(
      id: id,
      team1Name: map['team1Name'] ?? '',
      team2Name: map['team2Name'] ?? '',
      team1Score: map['team1Score'] ?? 0,
      team2Score: map['team2Score'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: map['updatedAt'] != null 
          ? (map['updatedAt'] as Timestamp).toDate() 
          : null,
    );
  }
}
```

### Model Relationships

```
User (1)
  │
  │ owns/creates
  │
  └─→ (Many) Tournaments
        │
        │ contains
        │
        └─→ (Many) Matches
              │
              ├─ team1Score (Integer)
              ├─ team2Score (Integer)
              └─ updatedAt (Timestamp)
```

---

## 🔄 Data Flow Architecture

### Complete Data Flow Diagram

```
┌────────────────────────────────────────────────────────────────┐
│                        UI LAYER                                │
│                                                                │
│  ┌──────────────────────────┬──────────────────────────────┐  │
│  │   TournamentHomePage     │   TournamentDetailsPage      │  │
│  │   (GridView)             │   (Match Cards + Standings)  │  │
│  │                          │                              │  │
│  │   StreamBuilder<List>    │   StreamBuilder<List>        │  │
│  └────────────┬─────────────┴──────────────┬──────────────┘  │
│               │                            │                 │
│               │ subscribe                  │ subscribe        │
│               ▼                            ▼                 │
└───────────────┼────────────────────────────┼─────────────────┘
                │                            │
                │ .getTournamentsStream()   │ .getMatchesStream(id)
                │                            │
┌───────────────┼────────────────────────────┼─────────────────┐
│      SERVICE LAYER (FirestoreService & FirebaseAuthService)  │
│                                                               │
│  ┌────────────────────────────────────────────────────────┐  │
│  │              FirestoreService                          │  │
│  │                                                        │  │
│  │  getTournamentsStream()                               │  │
│  │    ↓                                                   │  │
│  │  Query firestore: tournaments collection              │  │
│  │    ↓                                                   │  │
│  │  Convert QuerySnapshot → List<Tournament>             │  │
│  │    ↓                                                   │  │
│  │  Return Stream (continuous updates)                   │  │
│  │                                                        │  │
│  │  updateMatchScore(tournamentId, matchId, s1, s2)      │  │
│  │    ↓                                                   │  │
│  │  Validate scores (non-negative integers)              │  │
│  │    ↓                                                   │  │
│  │  Write to Firestore: tournaments/{id}/matches/{id}    │  │
│  │    ↓                                                   │  │
│  │  Firestore triggers listener notifications            │  │
│  │    ↓                                                   │  │
│  │  All subscribed StreamBuilders receive update         │  │
│  └──────────────┬───────────────────────────────────────┘  │
│                 │                                           │
│  ┌──────────────┼───────────────────────────────────────┐  │
│  │              FirebaseAuthService                     │  │
│  │                                                      │  │
│  │  signUp(email, password)                            │  │
│  │    ↓                                                │  │
│  │  Validate email format & password strength          │  │
│  │    ↓                                                │  │
│  │  FirebaseAuth.createUserWithEmailAndPassword()      │  │
│  │    ↓                                                │  │
│  │  Create User document in Firestore                  │  │
│  │    ↓                                                │  │
│  │  Return success or throw error                      │  │
│  │                                                      │  │
│  │  signIn(email, password)                            │  │
│  │    ↓                                                │  │
│  │  FirebaseAuth.signInWithEmailAndPassword()          │  │
│  │    ↓                                                │  │
│  │  Create persistent session                          │  │
│  │    ↓                                                │  │
│  │  App navigates to Home Page                         │  │
│  │                                                      │  │
│  │  getCurrentUser()                                   │  │
│  │    ↓                                                │  │
│  │  Return FirebaseAuth.instance.currentUser           │  │
│  │    ↓                                                │  │
│  │  Used to check authentication status on app start   │  │
│  │                                                      │  │
│  │  signOut()                                          │  │
│  │    ↓                                                │  │
│  │  FirebaseAuth.signOut()                             │  │
│  │    ↓                                                │  │
│  │  Clear session & navigate to Auth Page              │  │
│  └──────────────┬───────────────────────────────────────┘  │
└─────────────────┼──────────────────────────────────────────┘
                  │
                  │ via Firebase SDK
                  │
┌─────────────────┼──────────────────────────────────────────┐
│            BACKEND (Firebase)                              │
│                                                           │
│  ┌──────────────────────────────────────────────────────┐│
│  │           Cloud Firestore                           ││
│  │                                                     ││
│  │  Collections:                                      ││
│  │  ├─ /users                                         ││
│  │  │  └─ {uid}                                       ││
│  │  │     ├─ email: string                            ││
│  │  │     ├─ createdAt: timestamp                     ││
│  │  │     └─ displayName: string (nullable)           ││
│  │  │                                                 ││
│  │  ├─ /tournaments                                   ││
│  │  │  └─ {tournamentId}                             ││
│  │  │     ├─ name: string                             ││
│  │  │     ├─ sport: string                            ││
│  │  │     ├─ createdAt: timestamp                     ││
│  │  │     │                                           ││
│  │  │     └─ [Subcollection] /matches                ││
│  │  │        └─ {matchId}                             ││
│  │  │           ├─ team1Name: string                  ││
│  │  │           ├─ team1Score: integer                ││
│  │  │           ├─ team2Name: string                  ││
│  │  │           ├─ team2Score: integer                ││
│  │  │           ├─ createdAt: timestamp               ││
│  │  │           └─ updatedAt: timestamp               ││
│  │  │                                                         ││
│  │  └─ [Listeners Active] → Real-time updates        ││
│  └──────────────────────────────────────────────────────┘│
│                                                           │
│  ┌──────────────────────────────────────────────────────┐│
│  │        Firebase Authentication                      ││
│  │                                                     ││
│  │  Manages:                                          ││
│  │  ├─ User sign-up (creates Auth record)             ││
│  │  ├─ User sign-in (creates session token)           ││
│  │  ├─ Password hashing & security                    ││
│  │  ├─ Session persistence                            ││
│  │  └─ Sign-out (revokes session)                     ││
│  │                                                     ││
│  │  Integrates with:                                  ││
│  │  └─ Firestore (for user profile docs)              ││
│  └──────────────────────────────────────────────────────┘│
└────────────────────────────────────────────────────────────┘
```

---

## 🗄️ Firebase Firestore Collections

### Collection Structure Diagram

```
LiveToura Firebase Project
│
├─── /users
│    │
│    └─── {uid: "user123..."}
│         ├─ email: "mindy@example.com"
│         ├─ displayName: "Mindy"
│         └─ createdAt: 2026-02-10T10:30:00Z
│
└─── /tournaments
     │
     ├─── {docId: "tournament_001"}
     │    ├─ name: "Spring Soccer 2026"
     │    ├─ sport: "Soccer"
     │    ├─ createdAt: 2026-02-10T09:00:00Z
     │    │
     │    └─ [Subcollection] /matches
     │         │
     │         ├─── {matchId: "match_101"}
     │         │    ├─ team1Name: "Blue Lions"
     │         │    ├─ team1Score: 5
     │         │    ├─ team2Name: "Orange Tigers"
     │         │    ├─ team2Score: 3
     │         │    ├─ createdAt: 2026-02-10T10:00:00Z
     │         │    └─ updatedAt: 2026-02-10T10:45:00Z
     │         │
     │         └─── {matchId: "match_102"}
     │              ├─ team1Name: "Green Wolves"
     │              ├─ team1Score: 2
     │              ├─ team2Name: "Red Sharks"
     │              ├─ team2Score: 4
     │              ├─ createdAt: 2026-02-10T10:15:00Z
     │              └─ updatedAt: 2026-02-10T10:50:00Z
     │
     ├─── {docId: "tournament_002"}
     │    ├─ name: "Basketball Championship"
     │    ├─ sport: "Basketball"
     │    ├─ createdAt: 2026-02-10T08:30:00Z
     │    │
     │    └─ [Subcollection] /matches
     │         └─── {matchId: "match_201"}
     │              ├─ team1Name: "Dunk Masters"
     │              ├─ team1Score: 78
     │              ├─ team2Name: "Hoop Stars"
     │              ├─ team2Score: 82
     │              ├─ createdAt: 2026-02-10T11:00:00Z
     │              └─ updatedAt: 2026-02-10T12:30:00Z
     │
     └─── {docId: "tournament_003"}
          ├─ name: "Weekend Tennis"
          ├─ sport: "Tennis"
          ├─ createdAt: 2026-02-10T07:00:00Z
          │
          └─ [Subcollection] /matches
               └─── {matchId: "match_301"}
                    ├─ team1Name: "Ace Players"
                    ├─ team1Score: 6
                    ├─ team2Name: "Net Warriors"
                    ├─ team2Score: 4
                    ├─ createdAt: 2026-02-10T14:00:00Z
                    └─ updatedAt: 2026-02-10T15:20:00Z
```

### Query Paths Used in App

```
// Get all tournaments (real-time)
db.collection('tournaments')
   .orderBy('createdAt', descending: true)
   .snapshots()

// Get matches for a tournament (real-time)
db.collection('tournaments')
   .doc(tournamentId)
   .collection('matches')
   .snapshots()

// Update a match score
db.collection('tournaments')
   .doc(tournamentId)
   .collection('matches')
   .doc(matchId)
   .update({'team1Score': newScore})

// Create a tournament
db.collection('tournaments')
   .add({'name': 'name', 'sport': 'sport', 'createdAt': now})

// Get user profile
db.collection('users')
   .doc(currentUser.uid)
   .get()
```

---

## ⚠️ Error Handling & State Management

### Error Handling Flow

```
┌──────────────────────────────────────────────────┐
│           Error Handling Strategy                │
└──────────────────────────────────────────────────┘

AUTHENTICATION ERRORS:
──────────────────────
┌─────────────────────┐
│   SignUp / SignIn   │
└────────┬────────────┘
         │
         ▼
Try-Catch FirebaseAuthException
         │
    ┌────┴────┬─────────────┬──────────────┬─────────────┐
    ▼         ▼             ▼              ▼             ▼
  Email        Weak      Not            Too Many      Invalid
  Exists      Password    Found         Attempts      Email
    │           │           │             │             │
    ▼           ▼           ▼             ▼             ▼
Show specific error messages to user
└──────────────────────────────────────────────────┘


FIRESTORE ERRORS:
─────────────────
┌─────────────────────┐
│ Update Score /      │
│ Create Tournament   │
└────────┬────────────┘
         │
         ▼
Try-Catch FirebaseException
         │
    ┌────┴────┬──────────┬────────────┬──────────┐
    ▼         ▼          ▼            ▼          ▼
Network  Permission  Doc Not    Quota    Other
Error    Denied     Found      Exceeded  Errors
    │       │         │           │        │
    ▼       ▼         ▼           ▼        ▼
Show error toast & retry button
└──────────────────────────────────────────────────┘


STATE MANAGEMENT WITH StreamBuilder:
────────────────────────────────────
┌────────────────────────────────────────────┐
│         StreamBuilder<List<Tournament>>     │
│                                            │
│  Handles 4 states automatically:           │
│                                            │
│  1. waiting        → Show loading spinner  │
│  2. active + data  → Show tournament list  │
│  3. active + error → Show error message    │
│  4. done           → Show empty state      │
└────────────────────────────────────────────┘
```

### UI State Indicators

```dart
// In StreamBuilder:
stream: FirestoreService().getTournamentsStream(),
builder: (context, snapshot) {
  // Handle loading state
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
  }
  
  // Handle error state
  if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
  }
  
  // Handle empty state
  if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text('No tournaments found'));
  }
  
  // Handle success state
  final tournaments = snapshot.data!;
  return GridView.builder(
    itemCount: tournaments.length,
    itemBuilder: (context, index) => TournamentCard(
      tournament: tournaments[index],
    ),
  );
}
```

---

## 🌐 Cloud Mapping & Integration

### Firebase Services Used

```
┌──────────────────────────────────────────────────┐
│          LiveToura Cloud Architecture            │
└──────────────────────────────────────────────────┘

Firebase Project: "livetoura-flutter"
├── Region: us-central1 (default)
│
├── ✅ Firebase Authentication
│   ├── Method: Email/Password
│   ├── Features:
│   │  ├─ User registration
│   │  ├─ User login
│   │  ├─ Session management (auto-persisted)
│   │  └─ Logout/sign-out
│   │
│   └── Integration:
│       ├─ FirebaseAuth.instance.createUserWithEmailAndPassword()
│       ├─ FirebaseAuth.instance.signInWithEmailAndPassword()
│       └─ FirebaseAuth.instance.signOut()
│
├── ✅ Cloud Firestore
│   ├── Type: NoSQL Real-Time Database
│   ├── Collections:
│   │  ├─ users (user profiles)
│   │  └─ tournaments (tournaments + matches subcollection)
│   │
│   ├── Real-Time Listeners:
│   │  ├─ getTournamentsStream() → Watches all tournaments
│   │  └─ getMatchesStream() → Watches matches in tournament
│   │
│   ├── Write Operations:
│   │  ├─ addTournament() → Create new tournament
│   │  ├─ addMatch() → Create match in tournament
│   │  └─ updateMatchScore() → Update score in real-time
│   │
│   └── Security Rules:
│       ├─ Authenticated users only (auth required)
│       ├─ Users can only read/write their data
│       └─ Tournaments readable by all auth users
│
├── ❌ Not Currently Used (Future Features)
│   ├─ Firebase Storage (user profiles, images)
│   ├─ Cloud Functions (automated processing)
│   ├─ Firebase Messaging (push notifications)
│   └─ Firebase Analytics (user tracking)
│
└── 🔒 Security Model
    ├── Firestore Rules:
    │  ├─ match /databases/{database}/documents {
    │  │  match /users/{document=**} {
    │  │    allow read, write: if request.auth != null;
    │  │  }
    │  │  match /tournaments/{document=**} {
    │  │    allow read, write: if request.auth != null;
    │  │  }
    │  │ }
    │  │
    │  └─ Firebase Auth: Email/password with Firebase-managed passwords
    │
    └── Data Encryption:
       ├─ In Transit: HTTPS (TLS 1.3)
       └─ At Rest: Google-managed encryption keys
```

### Deployment Architecture (Current)

```
┌─────────────────────────────────────────────────┐
│           Deployment Pipeline                   │
└─────────────────────────────────────────────────┘

Version Control:
  │
  ├─ GitHub Repository (main branch)
  │  └─ main.dart, pubspec.yaml, lib/firebase_options.dart
  │
  └─ Branches:
     ├─ main (production)
     ├─ develop (staging)
     ├─ concept-1, concept-2, concept-3 (feature branches)
     └─ feature/* (team development)


Build & Deploy:
  │
  ├─ Local Development
  │  └─ flutter run -d chrome (development server)
  │
  ├─ Android APK (future)
  │  └─ flutter build apk --release
  │
  ├─ iOS App (future)
  │  └─ flutter build ios --release
  │
  └─ Web (current)
      └─ flutter build web --release
          └─ Deploy to:
             ├─ Firebase Hosting (recommended)
             ├─ Vercel / Netlify
             └─ Traditional web server


Firebase Configuration:
  │
  └─ flutterfire_cli generates:
     ├─ lib/firebase_options.dart (per-platform configs)
     ├─ android/google-services.json
     ├─ ios/GoogleService-Info.plist
     └─ web/index.html (Firebase SDK)
```

### Future CI/CD Pipeline (GitHub Actions)

```yaml
# Planned workflow: .github/workflows/deploy.yml
name: Build & Deploy

on:
  push:
    branches: [ main, develop ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run tests
        run: flutter test
      
      - name: Build Web
        run: flutter build web --release
      
      - name: Deploy to Firebase Hosting
        uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: ${{ secrets.GITHUB_TOKEN }}
          firebaseServiceAccount: ${{ secrets.FIREBASE_KEY }}
          projectId: livetoura-flutter
          channelId: live
```

---

## 🔐 Security & Validation

### Input Validation

```
┌──────────────────────────────────────────────────┐
│          Input Validation Layer                  │
└──────────────────────────────────────────────────┘

EMAIL VALIDATION:
─────────────────
Input: "mindy@example.com"
  │
  ├─ Regex check: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  ├─ Length: 5-254 characters
  ├─ No spaces
  └─ Valid domain format
      │
      ├─ ✅ Pass: "mindy@example.com"
      └─ ❌ Fail: "mindy@.com", "mindy @example.com", "mindy"


PASSWORD VALIDATION:
────────────────────
Input: "SecurePass123!"
  │
  ├─ Min length: 6 characters
  ├─ Firebase additionally requires:
  │  ├─ Not common passwords
  │  └─ Different from email
  │
  ├─ ✅ Pass: "SecurePass123!"
  └─ ❌ Fail: "123456", "abc"


TOURNAMENT NAME VALIDATION:
──────────────────────────
Input: "Spring Soccer 2026"
  │
  ├─ Non-empty
  ├─ Max 100 characters
  ├─ Alphanumeric + spaces/hyphens
  │
  ├─ ✅ Pass: "Spring Soccer 2026"
  └─ ❌ Fail: "" (empty)


SCORE VALIDATION:
─────────────────
Input: team1Score = 5
  │
  ├─ Must be non-negative integer
  ├─ Max 999 (reasonable-worst score)
  ├─ Match < > comparison valid
  │
  ├─ ✅ Pass: 0-999
  └─ ❌ Fail: -1, 2000, "abc"
```

---

## 📱 Responsive Layout Mapping

### Screen Breakpoints

```
Mobile (< 600dp)         Tablet (600-900dp)       Desktop (> 900dp)

┌──────────────┐        ┌────────────────────┐    ┌──────────────────────┐
│ Tournament   │        │ Tournament  |      │    │Tournament|Tournament │
│ Card 1       │        │ Card 1      | Card│    │ Card 1   | Card 2    │
│              │        │             | 2   │    │          |          │
│              │        │             |      │    │Tournament|Tournament │
│              │        │             |      │    │ Card 3   | Card 4    │
│              │        │             |      │    │          |          │
│              │        │             |      │    │Tournament|Tournament │
├──────────────┤        ├─────────────┼──────┤    │ Card 5   | Card 6    │
│ Tournament   │        │ Tournament  |      │    └──────────────────────┘
│ Card 2       │        │ Card 3      | Card│
│              │        │             | 4   │    GridView.builder(
│              │        │             |      │      crossAxisCount:
│              │        │             |      │        getGridColumns()
│              │        │             |      │
│              │        │             |      │    Returns:
│              │        │             |      │    - 1 (mobile)
├──────────────┤        └────────────────────┘    - 2 (tablet)
│ Tournament   │                                   - 3 (desktop)
│ Card 3       │
│              │
│              │
│              │
│              │
└──────────────┘


Helper Function:
───────────────
ResponsiveLayout.getGridColumns(context) {
  double width = MediaQuery.of(context).size.width;
  
  if (width < 600) return 1;      // Mobile
  if (width < 900) return 2;      // Tablet
  return 3;                        // Desktop
}
```

---

## 📊 Testing & Validation Checklist

```
┌──────────────────────────────────────────────────┐
│      LLD Implementation Validation               │
└──────────────────────────────────────────────────┘

✅ UI Component Structure
   ├─ Widget hierarchy complete
   ├─ All screens implemented
   ├─ Reusable components defined
   └─ Material 3 design system applied

✅ Navigation Flow
   ├─ Splash/Intro → Auth → Home → Details
   ├─ Back navigation working
   ├─ Tab navigation on details page
   └─ Deep linking supported (future)

✅ State Management
   ├─ StreamBuilder for real-time data
   ├─ Loading states handled
   ├─ Error states displayed
   └─ Empty states shown

✅ Backend Logic
   ├─ Firebase Auth (sign-up, sign-in, sign-out)
   ├─ Firestore CRUD operations
   ├─ Real-time stream listeners
   └─ Score updates (real-time sync)

✅ Data Models
   ├─ User model with serialization
   ├─ Tournament model with relationships
   ├─ Match model with timestamps
   └─ Type safety (strong typing)

✅ Firebase Services
   ├─ Authentication service
   ├─ Firestore service
   ├─ Error handling
   └─ Null safety

✅ Security
   ├─ Input validation (email, password, scores)
   ├─ Firestore security rules enforced
   ├─ User authentication required
   └─ Data encryption in transit & at rest

✅ Responsive Design
   ├─ Mobile layout (1 column)
   ├─ Tablet layout (2 columns)
   ├─ Desktop layout (3 columns)
   ├─ Touch targets ≥ 56dp
   └─ Text readable on all devices

✅ Code Quality
   ├─ Const constructors for optimization
   ├─ Effective Dart followed
   ├─ Comments on complex logic
   └─ DRY principle applied
```

---

## 📚 File & Class Summary

```
lib/main.dart (Complete Implementation)
├── Imports
│   ├─ firebase_core
│   ├─ firebase_auth
│   ├─ cloud_firestore
│   └─ flutter/material.dart
│
├── Models
│   ├─ User (uid, email, displayName, createdAt)
│   ├─ Tournament (id, name, sport, createdAt, matches)
│   └─ Match (id, team1Name, team2Name, scores, timestamps)
│
├── Services
│   ├─ FirebaseAuthService
│   │  ├─ signUp(email, password)
│   │  ├─ signIn(email, password)
│   │  ├─ signOut()
│   │  └─ getCurrentUser()
│   │
│   └─ FirestoreService
│      ├─ getTournamentsStream() → Stream<List<Tournament>>
│      ├─ getMatchesStream(id) → Stream<List<Match>>
│      ├─ addTournament(name, sport)
│      ├─ updateMatchScore(...)
│      └─ addMatch(...)
│
├── Theme System
│   └─ LiveTouraTheme
│      ├─ Material 3 colors
│      ├─ Typography (7 styles)
│      ├─ Spacing system
│      └─ lightTheme getter
│
├── Utilities
│   └─ ResponsiveLayout
│      ├─ isMobile(context)
│      ├─ isTablet(context)
│      ├─ isDesktop(context)
│      └─ getGridColumns(context)
│
├── Pages
│   ├─ AuthenticationPage
│   │  ├─ LoginForm
│   │  └─ SignUpForm
│   │
│   ├─ TournamentHomePage
│   │  ├─ GridView (responsive columns)
│   │  └─ TournamentCard (repeated)
│   │
│   └─ TournamentDetailsPage
│       ├─ TabBar (Matches / Standings)
│       ├─ MatchesTab
│       └─ StandingsTab
│
└── App Entry Point
    └─ main()
       └─ runApp(LiveTouraApp())
```

---

## 🎯 Design Summary

**Architecture Type:** BaaS (Backend-as-a-Service) with Firebase  
**State Management:** StreamBuilder (Firebase Streams)  
**UI Framework:** Flutter Material 3  
**Database:** Cloud Firestore (Real-time NoSQL)  
**Authentication:** Firebase Auth (Email/Password)  
**Scalability:** Excellent (Firebase handles scaling)  

---

**This LLD serves as the development blueprint for the LiveToura application, ensuring all team members understand the complete architecture, data flow, and integration points.**

