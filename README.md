![header](./header.png)
<img src="https://github.com/Ramotion/paper-onboarding/blob/master/paper-onboarding.gif" width="600" height="450" />
<br><br/>

# navigation-toolbar
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/paper-onboarding.svg)](https://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/v/paper-onboarding.svg)](http://cocoapods.org/pods/paper-onboarding)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/paper-onboarding)
[![Travis](https://img.shields.io/travis/Ramotion/paper-onboarding.svg)](https://travis-ci.org/Ramotion/paper-onboarding)
[![codebeat badge](https://codebeat.co/badges/d06237c6-6ff7-4560-9602-b6cc65063383)](https://codebeat.co/projects/github-com-ramotion-paper-onboarding)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/Ramotion)

# Check this library on other platforms:
<a href="https://github.com/Ramotion/navigation-toolbar-android">
<img src="https://github.com/Ramotion/navigation-stack/raw/master/Android_Kotlin@2x.png" width="178" height="81"></a>

**Looking for developers for your project?**<br>
This project is maintained by Ramotion, Inc. We specialize in the designing and coding of custom UI for Mobile Apps and Websites.

<a href="mailto:alex.a@ramotion.com?subject=Project%20inquiry%20from%20Github">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a> <br>

The [iPhone mockup](https://store.ramotion.com/product/iphone-x-clay-mockups?utm_source=gthb&utm_medium=special&utm_campaign=navigation-toolbar) available [here](https://store.ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=navigation-toolbar).

## Requirements

- iOS 10.0+
- Xcode 9

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:

``` ruby
pod 'navigation-toolbar'
```

or [Carthage](https://github.com/Carthage/Carthage) users can simply add to their `Cartfile`:
```
github "Ramotion/navigation-toolbar"
```

## Usage

#### Storyboard

1) Create a new UIView inheriting from ```NavigationView```

2) Create ScreenObject for every screen:

``` swift
class ViewController: UIViewController {

  private var navigationView: NavigationView?

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationView = NavigationView.init(frame: view.bounds,
                                    middleView: MiddleView(),
                                       screens: [
                                                 ScreenObject(title: "MUSIC",
                                                         startColor: .red,
                                                           endColor: .blue,
                                                              image: UIImage(named : "image1")!,
                                                         controller: YourFirstViewController()),
                                                         
                                                 ScreenObject(title: "EDUCATION",
                                                         startColor: .black,
                                                           endColor: .white,
                                                              image: UIImage(named : "image2")!,
                                                         controller: YourSecondViewController()),
                                                ],
                               backgroundImage: #imageLiteral(resourceName: "background"))
                               
    navigationView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(navigationView!)
  }
  
}
```


This library is a part of a <a href="https://github.com/Ramotion/swift-ui-animation-components-and-libraries"><b>selection of our best UI open-source projects.</b></a>

## License

navigation-toolbar is released under the MIT license.
See [LICENSE](./LICENSE) for details.

<br>

# Get the Showroom App for iOS to give it a try
Try this UI component and more like this in our iOS app. Contact us if interested.

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=navigation-toolbar&mt=8" >
<img src="https://github.com/ramotion/gliding-collection/raw/master/app_store@2x.png" width="117" height="34"></a>

<a href="mailto:alex.a@ramotion.com?subject=Project%20inquiry%20from%20Github">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
<br>
<br>

Follow us for the latest updates<br>
<a href="https://goo.gl/rPFpid" >
<img src="https://i.imgur.com/ziSqeSo.png/" width="156" height="28"></a>
