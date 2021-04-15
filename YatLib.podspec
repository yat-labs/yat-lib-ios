Pod::Spec.new do |spec|

  spec.name         = "YatLib"
  spec.version      = "0.1.4"
  spec.summary      = "y.at partner integration library for iOS."

  spec.description  = <<-DESC
  # Yat Partner Integration iOS Framework

This framework is designed to make it easy for Yat partners to integrate the Yat purchase or connect flows into their apps.

## Requirements

- iOS 13.0+
- Swift 5

## Installation

### Using Cocoapods

You can use [CocoaPods](http://cocoapods.org/) to install `YatLib` by adding it to your `Podfile`:

```ruby
use_frameworks!

target 'MyApp' do
    pod 'YatLib', '0.1.4'
end
```

## Usage

1. Create your app, add `YatLib` as a pod dependency as described above, and do a `pod install`.

2. `YatLib` uses deep links to return from the Yat web application back to the application. URL scheme of the deep link is agreed upon in between the Yat development team and the integration partner. Currently used scheme is `{partner_key}://y.at?{query_params}`. Setup your deep links in your project accordingly.

    1. Select your project in the project browser.
    2. Select your app target under `Targets`.
    3. Select the `Info` tab and expand the `URL types` section.
    4. Click the `+` button, and enter the app's URL scheme into the `URL Schemes` text box.

3. Open `SceneDelegate.swift` file, and update and add the below functions:

    ```swift
    import UIKit
    import YatLib

    class SceneDelegate: UIResponder, UIWindowSceneDelegate {

        func scene(_ scene: UIScene,
                   willConnectTo session: UISceneSession,
                   options connectionOptions: UIScene.ConnectionOptions
        ) {
            guard let _ = (scene as? UIWindowScene) else { return }
	        self.scene(scene, openURLContexts: connectionOptions.urlContexts)
	    }

        internal func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            if let url = URLContexts.first?.url {
                YatLib.processDeepLink(url)
            }
        }

        // ... rest of the implementation ...

    }
	```

4. Define and set the app-specific constants, which will be delivered to you by the Yat development team, and define the crypto records to be linked to the Yat.

    ```swift
    import YatLib

    class MyViewController: UIViewController {
        /**
        * These values are provided to the app developer by the Yat development team.
        */
        private let yatAppConfig = YatAppConfig(
            name: "Super Cool Wallet",
            sourceName: "SCW",
            pathKey: "scw",
            pubKey: "{64 character hex public key}",
            code: "66b6a5aa-11b4-12a9-1c1e-84765ef174ab",
            authToken: "AppToken84765783"
        )
        /**
        * Sample data that will be attached to the Yat.
        */
        private let yatRecords = [
            YatRecord(
                type: .BTCAddress,
                value: "1NDyJtNTjmwk5xPNhjgAMu4HDHigtobu1s"
            ),
            YatRecord(
                type: .ETHAddress,
                value: "108dEFa0272dC118EF03a7993e4fC7A8AcF3a3d1"
            ),
            YatRecord(
                type: .XTRAddress,
                value: "d2e4db6dac593a9af36987a35676838ede4f69684ba433baeed68bce048e111b".uppercased()
            ),
            YatRecord(
                type: .XMRStandardAddress,
                value: "4AdUndXHHZ6cfufTMvppY6JwXNouMBzSkbLYfpAV5Usx3skxNgYeYTRj5UzqtReoS44qo9mtmXCqY45DJ852K5Jv2684Rge"
            )
        ]
    }
    ```

6. Implement a delegate for the library:

    ```swift
    extension ViewController: YatLibDelegate {
    
        func onYatIntegrationComplete(yat: String) {
            // ... your code ...
        }
        
    }
    ```

5. Initialize the library using the values defined in the previous steps:

    ```swift
    YatLib.initialize(
        appConfig: yatAppConfig,
        /* random user id */
        userId: UUID().uuidString,
        /* random password */
        userPassword: UUID().uuidString,
        colorMode: .dark,
        delegate: self,
        records: yatRecords
    )
    ```

6. Launch the library with a host view controller that will present the root view controller of the library:

    ```swift
    YatLib.start(hostViewController: self)
    ```

7. Library will call its delegate's `onYatIntegrationComplete(yat: String)` function on successful completion, and will exit silently if the user cancels the flow.
                   DESC

  spec.homepage     = "https://github.com/yat-labs/yat-lib-ios"

  spec.license      = "3-Clause BSD License"
  spec.author = { "The Tari Development Team" => "info@tari.com" }

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5"

  spec.source       = { :git => "https://github.com/yat-labs/yat-lib-ios.git", :tag => "#{spec.version}" }
  spec.source_files = "YatLib/**/*.{h,swift}"

  # spec.public_header_files = "Classes/**/*.h"
  # spec.resource  = "icon.png"
  spec.resources = "YatLib/**/*.{lproj,xcassets,otf}"
  # spec.resource_bundles = {'YatLib' => ['YatLib/**/*.{lproj,xcassets,otf}']}

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

end