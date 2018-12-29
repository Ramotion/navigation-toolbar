<a href="https://github.com/Ramotion/navigation-toolbar">
<img align="left" src="https://github.com/Ramotion/navigation-toolbar/blob/master/iOS-Navigation-Toolbar-1x.gif" width="480" height="360" /></a>

<p><h1 align="left">NAVIGATION TOOLBAR</h1></p>

<h4>Navigation toolbar is a Swift slide-modeled UI navigation controller.</h4>


___



<p><h6>We specialize in the designing and coding of custom UI for Mobile Apps and Websites.</h6>
<a href="https://dev.ramotion.com?utm_source=gthb&utm_medium=repo&utm_campaign=navigation-toolbar">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
</p>
<p><h6>Stay tuned for the latest updates:</h6>
<a href="https://goo.gl/rPFpid" >
<img src="https://i.imgur.com/ziSqeSo.png/" width="156" height="28"></a></p>
<h6><a href="https://store.ramotion.com/product/iphone-x-clay-mockups?utm_source=gthb&utm_medium=special&utm_campaign=navigation-toolbar#demo">Get Free Mockup For your project →</a></h6>

</br>

[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/navigation-toolbar.svg)](https://cocoapods.org/pods/Navigation-Toolbar)
[![CocoaPods](https://img.shields.io/cocoapods/v/navigation-toolbar.svg)](http://cocoapods.org/pods/Navigation-Toolbar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-uncompatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/navigation-toolbar)
[![codebeat badge](https://codebeat.co/badges/9460af06-c0f9-4063-8bb5-a802136d3cbf)](https://codebeat.co/projects/github-com-ramotion-navigation-toolbar-master)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/Ramotion)


## Requirements

- iOS 10.0+
- Xcode 9

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:

``` ruby
pod 'Navigation-Toolbar'
```

or [Carthage](https://github.com/Carthage/Carthage) users can simply add to their `Cartfile`:
```
github "Ramotion/navigation-toolbar"
```

## Usage

#### Storyboard

1) Create a new UIView inheriting from ```NavigationView```

2) Create ScreenObject for every required screen with configuration, see example:

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


## 🗂 Check this library on other language:
<a href="https://github.com/Ramotion/navigation-toolbar-android">
<img src="https://github.com/Ramotion/navigation-stack/raw/master/Android_Kotlin@2x.png" width="178" height="81"></a>


## 📄 License

Folding cell is released under the MIT license.
See [LICENSE](./LICENSE) for details.

This library is a part of a <a href="https://github.com/Ramotion/swift-ui-animation-components-and-libraries"><b>selection of our best UI open-source projects.</b></a>

If you use the open-source library in your project, please make sure to credit and backlink to www.ramotion.com

## 📱 Get the Showroom App for iOS to give it a try
Try this UI component and more like this in our iOS app. Contact us if interested.

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=folding-cell&mt=8" >
<img src="https://github.com/ramotion/gliding-collection/raw/master/app_store@2x.png" width="117" height="34"></a>

<a href="https://dev.ramotion.com?utm_source=gthb&utm_medium=repo&utm_campaign=folding-cell">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
<br>
<br>
