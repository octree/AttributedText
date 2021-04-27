# AttributedText

An elegant way to build `NSAttributedString` using `@resultBuilder`. 



## Usage

```swift
let list = ["hello", "world"]
let attributedText: NSAttributedString = .Builder {
    "@resultBuilder".bold.italic.fontSize(18).foreground(color: .purple)
    for elt in list {
        elt.bold.link("https://swift.org")
    }
    if #available(iOS 14, *) {
        "Wow".lineHeight(20)
    }
}.build()
```



## Installation

### Swift Package Manager
* File > Swift Packages > Add Package Dependency
* Add https://github.com/octree/SwiftWKBridge.git
* Select "Up to Next Major" with "1.0.0"



## License

AttributedText is available under the MIT license. See the LICENSE file for more info.