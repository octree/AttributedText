# AttributedText

An elegant way to build `NSAttributedString` . Powered by swift function builder.



## Usage

```swift
"Hello world".bold.italic.fontSize(20).build()
```



### Group

 ```swift
let text = Group {
	"Hello".foreground(color: .white).bold
	"World".background(color: .black).italic
	}
	.lineHeight(20)
	.alignment(.left)
	.build()
 ```



## License

AttributedText is available under the MIT license. See the LICENSE file for more info.