![Logo](https://github.com/fanta1ty/TAlertView/blob/master/Logo/Logo.png)
# TAlertView

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-brightgreen)](https://developer.apple.com/swift/)
[![Version](https://img.shields.io/cocoapods/v/TAlertView.svg?style=flat)](https://cocoapods.org/pods/TAlertView)
[![License](https://img.shields.io/cocoapods/l/TAlertView.svg?style=flat)](https://cocoapods.org/pods/TAlertView)
[![Platform](https://img.shields.io/cocoapods/p/TAlertView.svg?style=flat)](https://cocoapods.org/pods/TAlertView)
[![Email](https://img.shields.io/badge/contact-@thinhnguyen12389@gmail.com-blue)](thinhnguyen12389@gmail.com)

`TAlertView` is a flat customizable alertView, written in Swift

## Requirements
- iOS 12.0+
- Swift 5

### From CocoaPods
`TAlertView` is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod 'TAlertView'
```

Second, install `TAlertView` into your project:
```ruby
pod install
```
### Swift Package
`TAlertView` is designed for Swift 5. To depend on the logging API package, you need to declare your dependency in your `Package.swift`

```swift
.package(url: "https://github.com/fanta1ty/TAlertView.git", brand: "master"),
```

### Presenting an TAlertView
```Swift
let alert = TAlertView()
alert.showAlertInView(
    view: self,
    withTitle: "Alert Title",
    withSubtitle: "This is your alert's subtitle",
    withCustomImage: nil,
    withDoneButtonTitle: "",
    andButtons: []
)
```
![Alert](https://github.com/fanta1ty/TAlertView/blob/master/Screenshots/alert.png)

- **withTitle (String):** You can leave the title as ```""``` or give it a ```String```.

- **withSubtitle (String):** `TAlertView` always requires a subtitle, even if you want just a few words, add it here instead of the title (then leave the title as "").

-  **withCustomImage (UIImage?):** You can leave this image as ```nil``` or give it a ```UIImage``` which will show at the top of the alert.

- **withDoneButtonTitle (String):** You can leave this as ```""``` to show "Ok" as the dismiss button for the alert view, or give it an ```String```.

- **andButtons ([String]):** If you want to add buttons to your alert, simply add an array of 1 or 2 button titles as ```String``` here, anything more will be ignored as 2 is the max custom buttons you can add   

### Alert Types

`TAlertView` comes with 3 pre-designed custom alert types. Success, Caution, or Warning, simply add the type while initializing the `TAlertView`.

#### Success

```Swift
let alert = TAlertView()
alert.makeAlertTypeSuccess()
alert.showAlertInView(
    view: self,
    withTitle: "Alert Title",
    withSubtitle: "This is your alert's subtitle",
    withCustomImage: nil,
    withDoneButtonTitle: "",
    andButtons: []
)
```
![Success](https://github.com/fanta1ty/TAlertView/blob/master/Screenshots/success.png)

#### Caution

```Swift
let alert = TAlertView()
alert.makeAlertTypeCaution()
alert.showAlertInView(
    view: self,
    withTitle: "Alert Title",
    withSubtitle: "This is your alert's subtitle",
    withCustomImage: nil,
    withDoneButtonTitle: "",
    andButtons: []
)
```
![Caution](https://github.com/fanta1ty/TAlertView/blob/master/Screenshots/caution.png)

#### Warning

```Swift
let alert = TAlertView()
alert.makeAlertTypeWarning()
alert.showAlertInView(
    view: self,
    withTitle: "Alert Title",
    withSubtitle: "This is your alert's subtitle",
    withCustomImage: nil,
    withDoneButtonTitle: "",
    andButtons: []
)
```
![Warning](https://github.com/fanta1ty/TAlertView/blob/master/Screenshots/warning.png)

### Dismissing TAlertView

There are multiple ways you can dismiss an `TAlertView`

#### Close on Outside Touch

When the user taps anywhere outside the alert, you can dismiss it by adding this line:

```Swift
alert.dismissOnOutsideTouch = true
```

#### Auto-Close the Alert

Dismiss the AlertView when a certain time has elapsed after the AlertView is presented, by adding this line:

```Swift
alert.autoHideSeconds = 5
```

## Author

thinhnguyen12389, thinhnguyen12389@gmail.com

## License

TAlertView is available under the MIT license. See the LICENSE file for more info.
