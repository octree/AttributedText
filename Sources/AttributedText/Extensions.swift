//
//  Extensions.swift
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
typealias Image = UIImage
#else
import AppKit
#endif

extension Fragment: AttributedTextSlice {
    public func fragments(with attributes: [NSAttributedString.Key: Any]) -> [Fragment] {
        [merging(attributes: attributes)]
    }
}

extension String: AttributedTextSlice {
    public func fragments(with attributes: [NSAttributedString.Key: Any]) -> [Fragment] {
        [.span(self, attributes)]
    }
}

extension Array where Self.Element == AttributedTextSlice {
    func fragments(with attributes: [NSAttributedString.Key: Any]) -> [Fragment] {
        flatMap { $0.fragments(with: attributes) }
    }
}

extension NSTextAttachment: AttributedTextSlice {
    public func fragments(with attributes: [NSAttributedString.Key: Any]) -> [Fragment] {
        [.attachment(self).merging(attributes: attributes)]
    }
}
