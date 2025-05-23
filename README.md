# Untold - Flutter Video Streaming App

Untold is a mobile streaming application built with Flutter.  
It allows users to watch featured movies, interact through likes and comments, manage their profile and subscriptions, and more.

## 🚀 Features

- Firebase Authentication (Google & Apple)
- Onboarding with profile photo and name
- Home screen with movies in cartaz
- Video player with subtitle support
- Comments saved in Firebase Firestore
- Profile screen with account management
- Theme, state management, and clean architecture patterns

## 🧪 Tech Stack

- Flutter
- Firebase (Auth & Firestore)
- Dio + Retrofit
- MobX + GetIt
- Dartz (for error handling with Either)
- MVVM + Clean Architecture (adapted)
- l10n - Language and Internacionalization

---

### Chosen Architecture: MVVM + Clean Architecture Concepts

Since the app focuses heavily on UI/UX and reactivity, MVVM becomes a great choice as it provides clear separation of concerns without adding excessive complexity, unlike a full Clean Architecture setup with deeply nested layers.

Clean Architecture concepts are still adopted to ensure a proper separation between business logic and data layers, but without going too deep into abstraction.

Some design patterns being used include:
 - State Pattern
 - Repository Pattern
 - Use Case Pattern
 - Service Locator Pattern
 - Either Pattern

Other patterns may be added over time, depending on development needs, recommendations, the complexity of certain features, or opportunities to speed up the development process.

---

### Why aren’t there abstract classes for use cases and why are some combined in a single file?

In Clean Architecture adapted for Flutter, many projects do not use abstract classes for use cases. Additionally, I don’t see the need to create a separate file for each use case when they are very small. Grouping 2 or 3 related use cases (e.g., login use cases) in a single file like login_use_case.dart improves maintainability and speeds up development.

Of course, this is acceptable only when the use cases are simple and not complex enough to justify further abstraction. For larger or more complex use cases—or in projects that require stricter separation—it makes sense to isolate each use case in its own file and possibly introduce abstraction.

This section outlines future improvements, architectural inspirations, and development goals to make the application more robust, scalable, and developer-friendly.

### Architectural Philosophy & Inspirations

The architectural decisions made so far are inspired by:
 - GitHub open-source projects I follow
 - Jacob Moura’s videos on Flutter architecture
 - Augusto Galego’s clean and scalable implementations
 - Critiques and best practices shared by Lucas Montano (often with humor, but with real insight)

I aimed to strike a balance between robustness and simplicity. While I didn’t fully embrace “pure” Clean Architecture, I extracted meaningful concepts from it—mainly the separation between data, domain, and presentation layers—and adapted them to work efficiently within an MVVM structure.

This hybrid approach enables:
 - Easier scalability as the app grows
 - Faster development without unnecessary boilerplate
 - Cleaner, more maintainable code

### Planned Enhancements & Tooling

1. Playback Controls & Media Features
 - Add a resolution switcher for videos (e.g., 1080p, 720p, 480p)
 - Support manual subtitle file upload and selection
 - Improve player UI/UX with smoother controls and auto-hiding logic

2. UI/UX Improvements
 - Implement proper profile picture upload with image cropping support
 - Add a “Categories” section on the Home screen beside “Watch now”, with subtle styling:
 - “Watch now” as the active tab in bold
 - Other categories in light white font below or beside it

3. Code Optimization & Maintenance
 - Create a consistent TextStyle strategy using constants and AppTextStyle extensions
 - Reduce duplicate widget definitions by using base/shared components

4. DevOps & Infra Considerations
 - CI/CD pipeline using GitHub Actions or Bitrise for:
 - Linting
 - Testing
 - Deployment to Firebase Hosting or Play Store/TestFlight
 - Use Firebase Performance Monitoring and Crashlytics for insight into production issues
 - Plan for a modularization strategy if the app grows significantly in scope

### Testing Strategy
 - Continue improving test coverage:
 - Add unit tests for business logic in UseCases
 - Add widget tests for UI behavior
 - Add integration tests for onboarding and login flows

MERMAID: https://mermaid.live/edit#pako:eNplk0tu2zAQhq9CEMiqjqGXLVuLAo2VAF0U6KLtorRhsNJYJiqRwpDKo0EOU3RRoNsewRfrSHZiqtmR3wzn8c_wkRemBJ7xCmW7Z5_ytWbsnWik0tNSotuwy8u37EpYLDZr3RuvBrIShUHYnEEuSumkB65FafowHroRLYIF7aRTRp_iXVywlWxkKdmKIrJL1jlVK3f4icpYBkzpHUqwDjvXoexfrI4VhEK2Ldt4JKKitHU-ikWp_HsiANGg9dlMwL0DbakmO4o3F0o7wJ0sYGxIhQW8Vf_jhbDUGozYUrg9NGMWBuJW1qocZGCvdMhJSNJBNW1NL0mtw-_DL0NSFKbptCqe71Q06kGR_DiCXhF1zHQikWhovLUdwVggtMYqZ1CB3fZ5fHPy0tzryoaJUm0ItC-WlcA0VIe_hTK94_Vx8KGgopVTz-qccDRK61ti0VkopD0-GKf86G0MJf78nr1hXxTcfRj66n1vjrsV0vCb1mhyPgY_8UjsDFbGbVtp7Z3B0jfGYm8a8EkialOdtvaEZsLob0ZiqXTl87mwqtJd67O0bwW3LZqdqkeBF-JWlWC2bS0fAM995tCCLg9_dKFIUaqePkEx9O51d31WKz-PasUn9G9VyTP6HTDhDSDNh678sXda82H11jyjI33m72u-1k_0ppX6qzHN8zM0XbXn2U7Wlm5dS3sJuZI04eaFItUIuDKddjyLZ-kQhGeP_J5ns3i6DONZMg_iNI2CdJ5M-APPwmQxTefzRZiG4TINokXyNOE_hrzhNAqTIAiWUZSSS7x8-gfAzGiZ

## 🔧 How to run


```bash
flutter pub get
flutter run
```

