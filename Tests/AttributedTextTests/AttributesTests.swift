@testable import AttributedText
import XCTest

final class AttributesTests: XCTestCase {
    func testFont() {
        let font = Font.systemFont(ofSize: 12)
        let text = "Octree".font(font).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.font: font])
        XCTAssertEqual(text, expected)
    }

    func testFontSize() {
        let font = Font.systemFont(ofSize: 11)
        let text = "Octree".font(.systemFont(ofSize: 11)).fontSize(20).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.font: font])
        XCTAssertEqual(text, expected)
    }

    func testKerning() {
        let text = "Octree".kerning(1).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.kern: 1])
        XCTAssertEqual(text, expected)
    }

    func testStrikeThroughStyle() {
        let text = "Octree".strikeThroughStyle(.single).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(text, expected)
    }

    func testUnderlineStyle() {
        let text = "Octree".underlineStyle(.single).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(text, expected)
    }

    func testStrokeColor() {
        let text = "Octree".strokeColor(.black).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.strokeColor: Color.black])
        XCTAssertEqual(text, expected)
    }

    func testStrokeWidth() {
        let text = "Octree".strokeWidth(3).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.strokeWidth: 3])
        XCTAssertEqual(text, expected)
    }

    func testForegroundColor() {
        let text = "Octree".foreground(color: .black).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.foregroundColor: Color.black])
        XCTAssertEqual(text, expected)
    }

    func testBackgroundColor() {
        let text = "Octree".background(color: .black).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.backgroundColor: Color.black])
        XCTAssertEqual(text, expected)
    }

    func testLink() {
        let link = "https://google.com"
        let text = "Octree".link(link).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.link: link])
        XCTAssertEqual(text, expected)
    }

    func testBaselineOffset() {
        let text = "Octree".baselineOffset(4).build()
        let expected = NSAttributedString(string: "Octree", attributes: [.baselineOffset: 4])
        XCTAssertEqual(text, expected)
    }

    func testGroup() {
        let text = Group {
            "Hello".foreground(color: .white)
            "World".background(color: .black)
        }
        .lineHeight(20)
        .alignment(.left)
        .build()
        let expected = NSMutableAttributedString()
        expected.append(.init(string: "Hello", attributes: [.foregroundColor: Color.white]))
        expected.append(.init(string: "World", attributes: [.backgroundColor: Color.black]))
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 20
        style.minimumLineHeight = 20
        style.alignment = .left
        expected.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: expected.length))
        XCTAssertEqual(text, expected)
    }

    func testNestedGroup() {
        let text = Group {
            "Hello".foreground(color: .white)
            Group {
                "World".foreground(color: .white)
                "Octree"
            }.background(color: .black)
        }
        .lineHeight(20)
        .alignment(.left)
        .foreground(color: .red)
        .build()
        let expected = NSMutableAttributedString()
        expected.append(.init(string: "Hello", attributes: [.foregroundColor: Color.white]))
        expected.append(.init(string: "World", attributes: [.foregroundColor: Color.white,
                                                            .backgroundColor: Color.black]))
        expected.append(.init(string: "Octree", attributes: [.foregroundColor: Color.red,
                                                             .backgroundColor: Color.black]))
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = 20
        style.minimumLineHeight = 20
        style.alignment = .left
        expected.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: expected.length))
        XCTAssertEqual(text, expected)
    }
}
