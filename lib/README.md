# Making a Bloodpressure App with AI Step by Step
A Flutter Only Basic Blood Pressure App made step-by-step with help of AI. It will be for android for now, later will add packages and other environments.

## 0. Necessary packages

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
- **Repository interface:** the contract the ViewModels depend on (what the ui calls, so they don’t care whether data is stored in web localStorage or a Windows JSON file).

## 3. Create the storage DTO and mapper
- **DTO (Data Transfer Object):** is what we store in JSON
- **Mapper:** converts between:
    - DTO (storage shape)
    - Domain model (BpReading) (app meaning)

## 4. Implement local data source
- **local data source:** knows how to read/write somewhere (web or desktop) 
- **repository implementation:** uses that data source and returns domain objects to the rest of the app

- This makes BpRepositoryImpl actually persist data on:
    - Web: browser storage (localStorage)
    - Desktop: a local JSON file in the app’s working directory

## Full recap (what you’ve built so far)
1) Domain model
You created the domain entity:

lib/features/blood_pressure/domain/models/bp_reading.dart
BpReading with fields: id, systolic, diastolic, pulse, optional notes, and measuredAt.
2) Repository interface (domain contract)
You created:

lib/features/blood_pressure/domain/repositories/bp_repository.dart
BpRepository with:
getReadings()
addReading(reading)
updateReading(reading)
deleteReading(id)
3) Storage DTO + mapper
You created storage and conversion logic:

lib/features/blood_pressure/data/models/bp_reading_dto.dart
BpReadingDto stored as integers + measuredAtEpochMs
lib/features/blood_pressure/data/mappers/bp_mapper.dart
BpMapper.toDomain(BpReadingDto) -> BpReading
BpMapper.toDto(BpReading) -> BpReadingDto
4) We discussed local data source implementations (and rolled back)
We initially tried web/desktop implementations using dart:html / conditional imports / flutter_web_plugins, but those caused compile/package issues and you eventually changed requirements to:

Android only
no web
no desktop
Then we returned to the “general Step 4” idea: implement a local data source + have the repository persist data via that source.

5) Local data source: what you needed / last completed items
You said you were missing the local Dart file. The correct “Step 4” shape for Android is:

lib/features/blood_pressure/data/datasources/local/bp_local.dart (interface)
lib/features/blood_pressure/data/datasources/local/bp_local_android.dart (Android JSON-file implementation)
(and then later) BpRepositoryImpl that uses BpLocalDataSource
At the end of the conversation, I provided the missing bp_local.dart and the Android implementation bp_local_android.dart (JSON file using path_provider), but you still needed to confirm the mapper/package paths compile.

Next steps to continue (Android only)
Step 4D (finish): ensure the files exist and compile
Confirm you have:

lib/features/blood_pressure/data/datasources/local/bp_local.dart
lib/features/blood_pressure/data/datasources/local/bp_local_android.dart
pubspec.yaml includes:
yaml


dependencies:
  path_provider: ^2.1.4
BpMapper and BpReadingDto paths/imports match your actual folder structure.
If anything fails, paste the exact compile error and the first ~30 lines of the failing file.

Step 5: Create BpRepositoryImpl
Create:

lib/features/blood_pressure/data/repositories/bp_repository_impl.dart
This class will:

take BpLocalDataSource local
implement BpRepository by calling:
local.loadReadings() / local.saveReadings(...)
keep “domain-only” logic in BpRepositoryImpl, while file/JSON logic stays in BpLocalAndroidDataSource.
Step 6: Dependency wiring (DI)
Pick a simple approach:

create dependencies in main.dart (manual wiring)
pass BpRepository into the ViewModels
Since you’re following a structured layout, you likely want:

core/di/ to wire repository + viewmodels (or do it directly in main.dart first).
Step 7: ViewModels
Implement:

bp_list_vm.dart
loads readings from BpRepository.getReadings()
exposes state (list) and a loading/error flag
bp_form_vm.dart
fields for systolic/diastolic/pulse/notes
action methods:
create reading (calls addReading)
update reading (optional now)
Step 8: UI pages (List + Add)
Create:

bp_list_page.dart
uses BpListVm
shows saved readings
FloatingActionButton navigates to add page
bp_add_page.dart
uses BpFormVm
saves and returns
Step 9: Navigation
Update your main.dart / routing so:

app starts at BpListPage
navigation to BpAddPage works
Step 10: UI widgets
Optionally create:

bp_reading_card.dart to keep list UI clean.
To start your new conversation
Reply with:

Whether path_provider is already added and flutter pub get succeeds
Paste your current contents of:
bp_local_android.dart
bp_mapper.dart
bp_reading_dto.dart
Tell me what you want next: Step 5 (BpRepositoryImpl) or jump to Step 7 (ViewModels).
