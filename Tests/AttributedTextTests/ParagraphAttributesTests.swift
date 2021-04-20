import XCTest
@testable import AttributedText

final class ParagraphAttributesTests: XCTestCase {
    private func expectedText(paragraphStyleBuilder: (NSMutableParagraphStyle) -> Void) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        paragraphStyleBuilder(style)
        return NSAttributedString(string: "Octree", attributes: [.paragraphStyle: style])
    }

    func testLinespacing() {
        let text = "Octree".lineSpacing(4).build()
        let expected = expectedText {
            $0.lineSpacing = 4
        }
        XCTAssertEqual(text, expected)
    }

    func testParagraphSpacing() {
        let text = "Octree".paragraphSpacing(4).build()
        let expected = expectedText {
            $0.paragraphSpacing = 4
        }
        XCTAssertEqual(text, expected)
    }

    func testAlignment() {
        let text = "Octree".alignment(.left).build()
        let expected = expectedText {
            $0.alignment = .left
        }
        XCTAssertEqual(text, expected)
    }

    func testLineBreakMode() {
        let text = "Octree".lineBreakMode(.byWordWrapping).build()
        let expected = expectedText {
            $0.lineBreakMode = .byWordWrapping
        }
        XCTAssertEqual(text, expected)
    }

    func testMinimumLineHeight() {
        let text = "Octree".minimumLineHeight(10).build()
        let expected = expectedText {
            $0.minimumLineHeight = 10
        }
        XCTAssertEqual(text, expected)
    }

    func testMaximumLineHeight() {
        let text = "Octree".maximumLineHeight(10).build()
        let expected = expectedText {
            $0.maximumLineHeight = 10
        }
        XCTAssertEqual(text, expected)
    }

    func testLineHeight() {
        let text = "Octree".lineHeight(10).build()
        let expected = expectedText {
            $0.minimumLineHeight = 10
            $0.maximumLineHeight = 10
        }
        XCTAssertEqual(text, expected)
    }

    func testLineHeightMultiple() {
        let text = "Octree".lineHeightMultiple(2).build()
        let expected = expectedText {
            $0.lineHeightMultiple = 2
        }
        XCTAssertEqual(text, expected)
    }
}
