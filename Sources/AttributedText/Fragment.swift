//
//  AttributedText.swift
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
#else
import AppKit
#endif

public struct Fragment {
    enum Content {
        case text(String)
        case attachment(NSTextAttachment)
    }
    var content: Content
    var attributes: [NSAttributedString.Key: Any]

    var attributedString: NSAttributedString {
        switch content {
        case let .text(text):
            return .init(string: text, attributes: attributes)
        case let .attachment(attachment):
            let attributed = NSMutableAttributedString(attachment: attachment)
            attributed.addAttributes(attributes, range: NSRange(location: 0, length: attributed.length))
            return attributed
        }
    }

    func replacing(attributes: [NSAttributedString.Key: Any]) -> Self {
        .init(content: content, attributes: attributes)
    }

    static func attachment(_ attachment: NSTextAttachment) -> Self {
        .init(content: .attachment(attachment), attributes: [:])
    }

    static func span(_ text: String, _ attributes: [NSAttributedString.Key: Any]) -> Self {
        .init(content: .text(text), attributes: attributes)
    }
}
