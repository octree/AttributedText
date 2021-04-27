import XCTest
@testable import AttributedText

final class FunctionBuilderTests: XCTestCase {
    func testBuildBlock() {
        let text: NSAttributedString = .Builder {
            "hello"
            " world"
        }.build()
        XCTAssertEqual(text.string, "hello world")
    }

    func testBuildIf() {
        let flag1 = true
        let flag2 = false
        let text: NSAttributedString = .Builder {
            if flag1 {
                "iPhone"
            } else {
                "Macbook"
            }
            if flag2 {
                " Pro"
            } else {
                " Air"
            }
        }.build()
        XCTAssertEqual(text.string, "iPhone Air")
    }

    func testBuildArray() {
        let list = ["hello", "world"]
        let text: NSAttributedString = .Builder {
            for (index, elt) in list.enumerated() {
                "\(index) "
                elt
            }
        }.build()
        XCTAssertEqual(text.string, "0 hello1 world")
    }
}

