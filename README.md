
# BiometricKit – Face ID Authentication Layer for SwiftUI

BiometricKit is a lightweight Swift Package that provides:

* Face ID–based authentication
* Automatic locking when the app goes to the background
* Automatic re-authentication when the app becomes active
* A ready-to-use lock screen view
* Simple SwiftUI integration

This package is designed for applications that require secure access control.

---

# Installation (Swift Package Manager)

1. Open Xcode
2. Navigate to:

```
File → Add Packages…
```

3. Enter the package URL:

```
https://github.com/Excelsior-Technologies-Community/BiometricKit
```

4. Select **Up to Next Major Version**
5. Add the package to your app target

---

# Importing the Package

In any Swift file where biometric authentication is needed:

```swift
import BiometricKit
```

---

# Required Info.plist Permission

Face ID requires a usage description.
Add the following entry to your app’s **Info.plist**:

**Key:**

```
NSFaceIDUsageDescription
```

**Value:**

```
This app uses Face ID to securely authenticate the user.
```

Without this key, the app will terminate when attempting to use Face ID.

---

# Usage Example (SwiftUI Integration)

Below is a working example for integrating BiometricKit in your SwiftUI application.

This handles:

* Authentication on launch
* Displaying your secured view if unlocked
* Showing the built-in lock screen until authentication succeeds
* Locking when the app enters the background
* Re-authenticating when the app becomes active

```swift
import SwiftUI
import BiometricKit

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var biometricManager = BiometricAuthManager()
    
    var body: some View {
        Group {
            if biometricManager.isUnlocked {
                // Your secured main view after successful Face ID authentication
              Text("Unlocked")
            } else {
                // Built-in lock screen view from BiometricKit
                LockScreenView()
                    .environmentObject(biometricManager)
            }
        }
        .onAppear {
            biometricManager.authenticate()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                biometricManager.appMovedToBackground()
            case .active:
                biometricManager.appBecameActive()
            default:
                break
            }
        }
    }
}
```

---

# How It Works

**On app launch:**
The biometric manager triggers Face ID authentication automatically.

**If authentication succeeds:**
`DeliveryTrackingAdminView()` becomes visible.

**If authentication fails:**
The user remains on the `LockScreenView()` until they retry.

**When the app goes into the background:**
The system locks immediately.

**When the app returns to the foreground:**
The biometric manager requests Face ID again if needed.

---
