# Making a Bloodpressure App with AI Step by Step

## 1. Folder Structure
**These folder structures are recommend by AI:**
### Feature-First Approach (Small-to-Large apps)
```
lib/
  main.dart
  app.dart

  core/
    di/                 // dependency wiring (create repo/datasources/viewmodels)
    errors/             // shared error types (optional)
    theme/              // theme constants (optional)
    utils/              // shared helpers (formatters, small generic utils)

  features/
    blood_pressure/
      data/
        datasources/
          local/       // local storage implementations (web/windows)
            bp_local.dart
        mappers/        // dto <-> domain transforms
          bp_mapper.dart

      domain/
        models/        // domain entities (what the app uses)
          bp_reading.dart
        repositories/  // repository interfaces (contracts)
          bp_repository.dart

      presentation/
        viewmodels/    // ChangeNotifier state + actions
          bp_list_vm.dart
          bp_form_vm.dart
        pages/          // screens/routes
          bp_list_page.dart
          bp_add_page.dart
        widgets/        // reusable UI components
          bp_reading_card.dart

    //Future Features could be: medications, analytics, settings, sync, etc.
    //They would all contain a /data/, /domain/ and /presentation/ subfolder

  widgets/              // truly app-wide reusable widgets (optional)
  services/            // optional non-feature services (e.g., clock/time provider)

```
### Type-First Approach (Small-To-Medium Apps)
```
lib/
  main.dart

  core/
    di/                      // where you wire dependencies (repo/datasources/viewmodels)
    theme/                   // app theme (optional)
    utils/                   // shared small helpers (optional)

  data/
    datasources/local/       // local storage implementations (web + windows)
    mappers/                 // dto <-> domain converters
    models/                  // DTOs (JSON/storage shapes)

  domain/
    models/                  // domain entities (what the app uses)
    repositories/            // repository interfaces (contracts)

  presentation/
    pages/                   // screens (List/Add)
    viewmodels/             // ChangeNotifier state/actions
    widgets/                 // reusable UI widgets

  services/
    clock_service.dart       // optional: time provider (optional)
```

## 2. Create domain model and repository interface
- **Domain Model:** app's "meaning" of a blood pressure reading (what UI/ViewModel uses)
- **Repository interface:** the contract the ViewModels depend on (so they don’t care whether data is stored in web localStorage or a Windows JSON file).

## 3. Create the storage DTO and mapper
- **DTO (Data Transfer Object):** is what we store in JSON
- **Mapper:** converts between:
    - DTO (storage shape)
    - Domain model (BpReading) (app meaning)