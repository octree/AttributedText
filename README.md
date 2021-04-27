# AttributedText

An elegant way to build `NSAttributedString` . Powered by swift function builder.



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



## License

AttributedText is available under the MIT license. See the LICENSE file for more info.