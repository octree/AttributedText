//
//  _AttributesModifier.swift
//  AttributedText
//
//  Created by Octree on 2021/4/20.
//
//  Copyright (c) 2021 Octree <fouljz@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if canImport(UIKit)
import UIKit
public typealias Color = UIColor
#else
import AppKit
public typealias Color = NSColor
#endif

struct _AttributeModifier {
    var base: AttributedTextSlice
    var modifier: (inout [NSAttributedString.Key: Any]) -> Void
}

extension _AttributeModifier: AttributedTextSlice {
    var texts: [AttributedText] {
        base.texts.map { text in
            var attrs = text.attributes
            modifier(&attrs)
            return AttributedText(text: text.text, attributes: attrs)
        }
    }
}

extension _AttributeModifier {
    init(base: AttributedTextSlice, pagraphStyleModifier: @escaping (NSMutableParagraphStyle) -> Void) {
        self.base = base
        modifier = { attributes in
            let paragraphStyle = (attributes[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
            pagraphStyleModifier(paragraphStyle)
            attributes[.paragraphStyle] = paragraphStyle
        }
    }
}

public extension AttributedTextSlice {
    var bold: AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            let font = (attributes[.font] as? Font) ?? Font()
            attributes[.font] = font.adding(trait: .traitBold).withSize(font.pointSize)
        }
    }

    var italic: AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            let font = (attributes[.font] as? Font) ?? Font()
            attributes[.font] = font.adding(trait: .traitItalic).withSize(font.pointSize)
        }
    }

    func fontSize(_ fontSize: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            let font = (attributes[.font] as? Font) ?? Font()
            attributes[.font] = font.withSize(fontSize)
        }
    }

    func font(_ font: Font) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.font] = font
        }
    }

    func kerning(_ kerning: Double) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.kern] = NSNumber(floatLiteral: kerning)
        }
    }

    func strikeThroughStyle(_ style: NSUnderlineStyle) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.strikethroughStyle] = style.rawValue
        }
    }

    func underlineStyle(_ style: NSUnderlineStyle) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.underlineStyle] = style.rawValue
        }
    }

    func strokeColor(_ strokeColor: Color) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.strokeColor] = strokeColor
        }
    }

    func strokeWidth(_ strokeWidth: Double) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.strokeWidth] = NSNumber(floatLiteral: strokeWidth)
        }
    }

    func foreground(color: Color) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.foregroundColor] = color
        }
    }

    func background(color: Color) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.backgroundColor] = color
        }
    }

    func link(_ link: String) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.link] = link
        }
    }

    func baselineOffset(_ offset: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (attributes: inout [NSAttributedString.Key: Any]) in
            attributes[.baselineOffset] = offset
        }
    }
}

public extension AttributedTextSlice {
    func lineSpacing(_ spacing: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.lineSpacing = spacing
        }
    }

    func paragraphSpacing(_ spacing: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.paragraphSpacing = spacing
        }
    }

    func alignment(_ alignment: NSTextAlignment) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.alignment = alignment
        }
    }

    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.lineBreakMode = lineBreakMode
        }
    }

    func minimumLineHeight(_ minimumLineHeight: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.minimumLineHeight = minimumLineHeight
        }
    }

    func maximumLineHeight(_ maximumLineHeight: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.maximumLineHeight = maximumLineHeight
        }
    }

    func lineHeight(_ lineHeight: CGFloat) -> AttributedTextSlice {
        minimumLineHeight(lineHeight)
            .maximumLineHeight(lineHeight)
    }

    func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> AttributedTextSlice {
        _AttributeModifier(base: self) { (style: NSMutableParagraphStyle) in
            style.lineHeightMultiple = lineHeightMultiple
        }
    }
}
