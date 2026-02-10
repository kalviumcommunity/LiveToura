# LLD Visual Diagrams - LiveToura Flutter + Firebase

## 🎨 Complete Architecture Diagram

```mermaid
graph TB
    subgraph "UI Layer - Flutter Widgets"
        A["LiveTouraApp<br/>(Main Entry Point)"]
        B["Theme System<br/>(LiveTouraTheme)"]
        C["AuthenticationPage<br/>(Login/Signup)"]
        D["TournamentHomePage<br/>(Dashboard)"]
        E["TournamentDetailsPage<br/>(Match Scores)"]
        
        F["AuthForm<br/>(Email + Password)"]
        G["TournamentGrid<br/>(GridView - Responsive)"]
        H["TournamentCard<br/>(Reusable Component)"]
        I["MatchCard<br/>(Score Display)"]
        J["TabControl<br/>(Matches/Standings)"]
    end
    
    subgraph "State Management"
        K["StreamBuilder<br/>(Tournaments Stream)"]
        L["StreamBuilder<br/>(Matches Stream)"]
        M["UI State Handler<br/>(Loading/Error/Data)"]
    end
    
    subgraph "Service Layer - Firebase Integration"
        N["FirebaseAuthService<br/>(Authentication)"]
        O["FirestoreService<br/>(Database Operations)"]
        P["Error Handler<br/>(Try-Catch Logic)"]
    end
    
    subgraph "Data Models"
        Q["User<br/>(uid, email, createdAt)"]
        R["Tournament<br/>(id, name, sport)"]
        S["Match<br/>(team1, team2, scores)"]
    end
    
    subgraph "Firebase Backend"
        T["Firebase Auth<br/>(Email/Password)"]
        U["Cloud Firestore<br/>(Real-time NoSQL)"]
        V["Collections<br/>(/users, /tournaments,<br/>/matches)"]
        W["Real-time Listeners<br/>(Snapshots)"]
    end
    
    A -->|initializes| T
    A -->|checks auth| N
    A -->|applies| B
    
    N -->|sign up/in/out| T
    O -->|CRUD operations| U
    
    C -->|form input| F
    D -->|displays| G
    G -->|creates| H
    E -->|displays| I
    E -->|tab control| J
    
    K -->|listens to| O
    L -->|listens to| O
    M -->|handles states| K
    M -->|handles states| L
    
    F -->|validate & call| N
    H -->|on tap| E
    I -->|update score| O
    
    O -->|queries| U
    U -->|has collections| V
    U -->|pushes updates| W
    W -->|triggers| K
    W -->|triggers| L
    
    N -->|manages| Q
    O -->|works with| R
    O -->|works with| S
    
    style A fill:#1F51BA,stroke:#000,color:#fff
    style T fill:#FF6B35,stroke:#000,color:#fff
    style U fill:#FF6B35,stroke:#000,color:#fff
    style N fill:#6750A4,stroke:#000,color:#fff
    style O fill:#6750A4,stroke:#000,color:#fff
    style M fill:#6750A4,stroke:#000,color:#fff
```

---

## 📊 Component Hierarchy Diagram

```mermaid
graph TD
    App["🎯 LiveTouraApp<br/>(Main Application)"]
    
    Auth["🔐 AuthenticationPage"]
    Login["📧 LoginForm<br/>- Email Input<br/>- Password Input<br/>- Login Button"]
    Signup["✍️ SignUpForm<br/>- Email Input<br/>- Password Input<br/>- Confirm Password<br/>- SignUp Button"]
    
    Home["🏠 TournamentHomePage<br/>(Dashboard)"]
    Grid["📋 GridView<br/>(Responsive: 1-3 cols)"]
    Card["🎖️ TournamentCard<br/>- Sport Badge<br/>- Tournament Name<br/>- Live Indicator<br/>- Join Button"]
    
    Details["📊 TournamentDetailsPage"]
    Tab["📑 TabBar"]
    Matches["⚽ Matches Tab<br/>- StreamBuilder<br/>- Match List"]
    Score["📈 MatchCard<br/>- Team 1 Name<br/>- Score Display<br/>- Team 2 Name<br/>- Update Buttons"]
    Standing["🏆 Standings Tab<br/>- Table View<br/>- Rankings"]
    
    App -->|authenticated| home: true
    App -->|not authenticated| Auth
    
    Auth -->|sign up| Signup
    Auth -->|sign in| Login
    
    Home -->|TAP CARD| Details
    Home -->|GRID DISPLAY| Grid
    Grid -->|REPEATED| Card
    
    Details -->|INIT| Tab
    Tab -->|MATCHES| Matches
    Tab -->|STANDINGS| Standing
    
    Matches -->|REPEATED| Score
    Score -->|TAP BUTTON| updateScore["Update Score<br/>in Firestore"]
    
    style App fill:#1F51BA,stroke:#000,color:#fff,font-weight:bold
    style Auth fill:#6750A4,stroke:#000,color:#fff
    style Home fill:#6750A4,stroke:#000,color:#fff
    style Details fill:#6750A4,stroke:#000,color:#fff
    style Grid fill:#FF6B35,stroke:#000,color:#fff
    style Card fill:#FFFBFE,stroke:#1F51BA,color:#000
    style Score fill:#FFFBFE,stroke:#1F51BA,color:#000
    style updateScore fill:#B3261E,stroke:#000,color:#fff
```

---

## 🔄 Data Flow Diagram

```mermaid
graph LR
    User["👤 User<br/>Input"]
    UI["📱 UI Widget<br/>(StreamBuilder)"]
    Service["⚙️ Service Layer<br/>(Firebase Service)"]
    Backend["☁️ Firebase Backend<br/>(Real-time DB)"]
    
    User -->|tap button| UI
    UI -->|call method| Service
    Service -->|query/update| Backend
    
    Backend -->|snapshot| Stream["📡 Stream<br/>(Real-time Update)"]
    Stream -->|new data| UI
    UI -->|rebuild| Display["🎨 Display<br/>Updated UI"]
    
    style User fill:#6750A4,stroke:#000,color:#fff
    style UI fill:#1F51BA,stroke:#000,color:#fff
    style Service fill:#FF6B35,stroke:#000,color:#fff
    style Backend fill:#FF6B35,stroke:#000,color:#fff
    style Stream fill:#6750A4,stroke:#000,color:#fff
    style Display fill:#1F51BA,stroke:#000,color:#fff
```

---

## 🗄️ Firestore Structure Diagram

```mermaid
graph TB
    DB["🔥 Cloud Firestore<br/>(Real-time NoSQL)"]
    
    Users["📁 /users<br/>(Collection)"]
    UserDoc["👤 uid: 'user123'<br/>- email: string<br/>- displayName: string<br/>- createdAt: timestamp"]
    
    Tournaments["📁 /tournaments<br/>(Collection)"]
    TourDoc["🏆 docId: 'tour_001'<br/>- name: string<br/>- sport: string<br/>- createdAt: timestamp"]
    
    Matches["📁 /matches<br/>(Subcollection)"]
    MatchDoc["⚽ matchId: 'match_101'<br/>- team1Name: string<br/>- team1Score: integer<br/>- team2Name: string<br/>- team2Score: integer<br/>- createdAt: timestamp<br/>- updatedAt: timestamp"]
    
    DB -->|contains| Users
    DB -->|contains| Tournaments
    Users -->|has docs| UserDoc
    Tournaments -->|has docs| TourDoc
    TourDoc -->|has subcollection| Matches
    Matches -->|has docs| MatchDoc
    
    style DB fill:#FF6B35,stroke:#000,color:#fff,font-weight:bold
    style Users fill:#1F51BA,stroke:#000,color:#fff
    style Tournaments fill:#1F51BA,stroke:#000,color:#fff
    style Matches fill:#1F51BA,stroke:#000,color:#fff
    style UserDoc fill:#FFFBFE,stroke:#1F51BA
    style TourDoc fill:#FFFBFE,stroke:#1F51BA
    style MatchDoc fill:#FFFBFE,stroke:#1F51BA
```

---

## 🔐 Authentication Flow Diagram

```mermaid
graph TD
    Start["🚀 App Start"]
    Check["🔍 Check Auth Status<br/>FirebaseAuth.currentUser"]
    
    Auth{Is User<br/>Authenticated?}
    
    NoAuth["❌ No Session"]
    YesAuth["✅ Session Exists"]
    
    AuthPage["🔐 Show Auth Page"]
    HomePage["🏠 Show Home Page"]
    
    Signup["📝 User Chooses<br/>Sign Up"]
    SignupForm["✍️ Fill Form<br/>- Email<br/>- Password<br/>- Confirm"]
    
    Signin["🔑 User Chooses<br/>Sign In"]
    SigninForm["✍️ Fill Form<br/>- Email<br/>- Password"]
    
    SignupValidate["✓ Validate Input<br/>- Email format<br/>- Password strength<br/>- Passwords match"]
    SigninValidate["✓ Validate Input<br/>- Email format<br/>- Password not empty"]
    
    SignupFB["📲 Firebase<br/>createUserWithEmail"]
    SigninFB["📲 Firebase<br/>signInWithEmail"]
    
    CreateUser["👤 Create User Doc<br/>in Firestore"]
    
    Success["🎉 Success<br/>→ Home Page"]
    Error["❌ Error<br/>Show Message"]
    
    Logout["🚪 Logout Button"]
    SignoutFB["📲 Firebase<br/>signOut"]
    BackToAuth["🔄 → Auth Page"]
    
    Start --> Check
    Check --> Auth
    Auth -->|No| NoAuth
    Auth -->|Yes| YesAuth
    
    NoAuth --> AuthPage
    YesAuth --> HomePage
    
    AuthPage --> Signup
    AuthPage --> Signin
    
    Signup --> SignupForm
    Signin --> SigninForm
    
    SignupForm --> SignupValidate
    SigninForm --> SigninValidate
    
    SignupValidate -->|Valid| SignupFB
    SigninValidate -->|Valid| SigninFB
    
    SignupValidate -->|Invalid| Error
    SigninValidate -->|Invalid| Error
    
    SignupFB --> CreateUser
    CreateUser --> Success
    SigninFB --> Success
    
    SignupFB -->|Error| Error
    SigninFB -->|Error| Error
    
    Error -->|Retry| AuthPage
    
    HomePage --> Logout
    Logout --> SignoutFB
    SignoutFB --> BackToAuth
    BackToAuth --> AuthPage
    
    style Start fill:#6750A4,stroke:#000,color:#fff
    style Auth fill:#FF6B35,stroke:#000,color:#fff
    style HomePage fill:#1F51BA,stroke:#000,color:#fff
    style AuthPage fill:#1F51BA,stroke:#000,color:#fff
    style Success fill:#06A77D,stroke:#000,color:#fff
    style Error fill:#B3261E,stroke:#000,color:#fff
    style SignupFB fill:#FF6B35,stroke:#000,color:#fff
    style SigninFB fill:#FF6B35,stroke:#000,color:#fff
```

---

## 📡 Real-Time Sync Flow Diagram

```mermaid
graph LR
    Device1["📱 Device 1<br/>(Admin)"]
    Device2["📱 Device 2<br/>(Viewer)"]
    
    UI1["Update Score<br/>5 → 6"]
    UI2["Show Score<br/>5 - 3"]
    
    Service1["FirestoreService<br/>updateMatchScore"]
    Service2["FirestoreService<br/>getMatchesStream"]
    
    Write["✍️ Write to<br/>Firestore"]
    Listen["👂 Real-time<br/>Listener"]
    
    DB["☁️ Firestore<br/>Document"]
    
    Update["📨 Snapshot<br/>Notification"]
    
    UI2up["🔄 Rebuild UI<br/>Show 6 - 3<br/>(Instant!)"]
    
    Device1 -->|tap| UI1
    UI1 -->|call| Service1
    Service1 -->|update| Write
    Write -->|save| DB
    
    Device2 -->|listening| Service2
    Service2 -->|watch| Listen
    DB -->|change detected| Update
    Update -->|notify| Service2
    Service2 -->|emit snapshot| UI2up
    
    UI2 -.->|initial state| DB
    
    style Device1 fill:#1F51BA,stroke:#000,color:#fff
    style Device2 fill:#1F51BA,stroke:#000,color:#fff
    style DB fill:#FF6B35,stroke:#000,color:#fff
    style Update fill:#06A77D,stroke:#000,color:#fff
    style UI2up fill:#06A77D,stroke:#000,color:#fff
    style Write fill:#FF6B35,stroke:#000,color:#fff
```

---

## 🏗️ Responsive Design Architecture

```mermaid
graph TB
    GridView["GridView.builder<br/>(Responsive)"]
    Helper["ResponsiveLayout<br/>Helper"]
    
    Width["📏 Check Screen Width<br/>MediaQuery.of"]
    
    Mobile["📱 < 600dp<br/>MOBILE"]
    Tablet["📱 600-900dp<br/>TABLET"]
    Desktop["💻 > 900dp<br/>DESKTOP"]
    
    Col1["Grid Columns: 1"]
    Col2["Grid Columns: 2"]
    Col3["Grid Columns: 3"]
    
    Display1["┌─────┐<br/>│ C1  │<br/>├─────┤<br/>│ C2  │<br/>├─────┤<br/>│ C3  │<br/>└─────┘"]
    
    Display2["┌──────┬──────┐<br/>│ C1   │ C2   │<br/>├──────┼──────┤<br/>│ C3   │ C4   │<br/>└──────┴──────┘"]
    
    Display3["┌──────┬──────┬──────┐<br/>│ C1   │ C2   │ C3   │<br/>├──────┼──────┼──────┤<br/>│ C4   │ C5   │ C6   │<br/>└──────┴──────┴──────┘"]
    
    GridView -->|uses| Helper
    Helper -->|checks| Width
    
    Width --> Mobile
    Width --> Tablet
    Width --> Desktop
    
    Mobile -->|returns| Col1
    Tablet -->|returns| Col2
    Desktop -->|returns| Col3
    
    Col1 -->|renders| Display1
    Col2 -->|renders| Display2
    Col3 -->|renders| Display3
    
    style GridView fill:#6750A4,stroke:#000,color:#fff
    style Helper fill:#FF6B35,stroke:#000,color:#fff
    style Mobile fill:#1F51BA,stroke:#000,color:#fff
    style Tablet fill:#1F51BA,stroke:#000,color:#fff
    style Desktop fill:#1F51BA,stroke:#000,color:#fff
```

---

## ✅ Error Handling Flow

```mermaid
graph TD
    Operation["🔄 Operation<br/>(SignUp/Update/Query)"]
    Try["try {"]
    Execute["Execute Firebase Call"]
    Success["✅ Success<br/>Return Data"]
    Catch["} catch (e) {"]
    Error["❌ Catch Exception<br/>FirebaseException"]
    
    CheckError{Exception<br/>Type?}
    
    AuthE["🔐 Auth Error<br/>- Email exists<br/>- Wrong password<br/>- Invalid email"]
    FirestoreE["🗄️ Firestore Error<br/>- Permission denied<br/>- Document not found<br/>- Network error"]
    OtherE["⚠️ Other Error<br/>- Unknown error"]
    
    AuthMsg["Show Auth<br/>Error Message"]
    FirestoreMsg["Show DB<br/>Error Toast"]
    OtherMsg["Show Generic<br/>Error Message"]
    
    UserFeel["👤 User Experience<br/>- Retry available<br/>- Clear message<br/>- Don't crash app"]
    
    Operation --> Try
    Try --> Execute
    Execute --> Success
    Execute --> Catch
    
    Catch --> Error
    Error --> CheckError
    
    CheckError -->|Firebase Auth| AuthE
    CheckError -->|Cloud Firestore| FirestoreE
    CheckError -->|Other| OtherE
    
    AuthE --> AuthMsg
    FirestoreE --> FirestoreMsg
    OtherE --> OtherMsg
    
    AuthMsg --> UserFeel
    FirestoreMsg --> UserFeel
    OtherMsg --> UserFeel
    
    style Success fill:#06A77D,stroke:#000,color:#fff
    style Error fill:#B3261E,stroke:#000,color:#fff
    style AuthE fill:#B3261E,stroke:#000,color:#fff
    style FirestoreE fill:#B3261E,stroke:#000,color:#fff
    style UserFeel fill:#06A77D,stroke:#000,color:#fff
```

---

## 📋 State Management with StreamBuilder

```mermaid
graph TB
    Stream["📡 Stream<br/><List<Tournament>>"]
    
    SBuild["StreamBuilder<br/>builder:"]
    
    ConnectionState{Connection<br/>State}
    
    Waiting["⏳ waiting"]
    Active["🟢 active"]
    Done["⏹️ done"]
    
    HasData{Has<br/>Data?}
    HasError{Has<br/>Error?}
    
    Loading["🔄 CircularProgressIndicator<br/>Loading..."]
    Empty["📭 Empty State<br/>No tournaments found"]
    Data["✅ Display Data<br/>GridView with cards"]
    ErrorMsg["❌ Error Message<br/>Display error"]
    
    Stream -->|emits| SBuild
    SBuild -->|matches snapshot| ConnectionState
    
    ConnectionState -->|waiting| Waiting
    ConnectionState -->|active| Active
    ConnectionState -->|done| Done
    
    Waiting --> Loading
    Active --> HasData
    Done --> HasError
    
    HasData -->|yes| Data
    HasData -->|no| Empty
    
    HasError -->|yes| ErrorMsg
    HasError -->|no| Empty
    
    style Stream fill:#FF6B35,stroke:#000,color:#fff
    style SBuild fill:#6750A4,stroke:#000,color:#fff
    style Loading fill:#FFB703,stroke:#000
    style Data fill:#06A77D,stroke:#000,color:#fff
    style Empty fill:#FFB703,stroke:#000
    style ErrorMsg fill:#B3261E,stroke:#000,color:#fff
```

---

## 🎯 Complete Data Model Relationships

```mermaid
erDiagram
    USER ||--o{ TOURNAMENT : creates
    USER ||--o{ MATCH : organizes
    TOURNAMENT ||--o{ MATCH : contains
    
    USER {
        string uid PK
        string email
        string displayName
        timestamp createdAt
    }
    
    TOURNAMENT {
        string id PK
        string name
        string sport
        timestamp createdAt
        string userId FK
    }
    
    MATCH {
        string id PK
        string tournament_id FK
        string team1Name
        int team1Score
        string team2Name
        int team2Score
        timestamp createdAt
        timestamp updatedAt
    }
```

---

## 🌐 Cloud Services Integration Map

```mermaid
graph TB
    App["🎯 Flutter App"]
    
    Auth["🔐 Firebase Auth"]
    SignUp["Sign Up<br/>Email/Password"]
    SignIn["Sign In<br/>Email/Password"]
    SignOut["Sign Out"]
    
    DB["🗄️ Cloud Firestore<br/>(Real-time NoSQL)"]
    Users["📁 /users<br/>collection"]
    Tournaments["📁 /tournaments<br/>collection"]
    
    Storage["☁️ Cloud Storage<br/>(Future)"]
    Images["Images, Files"]
    
    FCM["🔔 Firebase Cloud<br/>Messaging (Future)"]
    Notifications["Push Notifications"]
    
    Analytics["📊 Firebase<br/>Analytics (Future)"]
    Tracking["User Behavior<br/>Tracking"]
    
    App -->|authenticate| Auth
    Auth -->|manages| SignUp
    Auth -->|manages| SignIn
    Auth -->|manages| SignOut
    
    App -->|queries/updates| DB
    DB -->|stores| Users
    DB -->|stores| Tournaments
    
    App -.->|planned| Storage
    Storage -.->|stores| Images
    
    App -.->|planned| FCM
    FCM -.->|sends| Notifications
    
    App -.->|planned| Analytics
    Analytics -.->|collects| Tracking
    
    style App fill:#1F51BA,stroke:#000,color:#fff
    style Auth fill:#FF6B35,stroke:#000,color:#fff
    style DB fill:#FF6B35,stroke:#000,color:#fff
    style Storage fill:#888,stroke:#000,color:#fff,stroke-dasharray: 5 5
    style FCM fill:#888,stroke:#000,color:#fff,stroke-dasharray: 5 5
    style Analytics fill:#888,stroke:#000,color:#fff,stroke-dasharray: 5 5
```

---

**All diagrams above can be to take screenshots for your LLD submission!**

