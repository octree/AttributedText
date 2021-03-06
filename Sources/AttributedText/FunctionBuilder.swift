//
//  FunctionBuilder.swift
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

import Foundation

@resultBuilder public enum AttributedTextBuilder {

    public static func buildExpression(_ slice: AttributedTextSlice) -> [AttributedTextSlice] {
        [slice]
    }

    public static func buildBlock(_ items: [AttributedTextSlice]...) -> [AttributedTextSlice] {
        items.flatMap { $0 }
    }

    public static func buildIf(_ items: [AttributedTextSlice]?...) -> [AttributedTextSlice] {
        items.flatMap { $0 ?? [] }
    }

    public static func buildArray(_ components: [[AttributedTextSlice]]) -> [AttributedTextSlice] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: [AttributedTextSlice]) -> [AttributedTextSlice] {
        component
    }

    public static func buildEither(first component: [AttributedTextSlice]) -> [AttributedTextSlice] {
        component
    }

    public static func buildEither(second component: [AttributedTextSlice]) -> [AttributedTextSlice] {
        component
    }

    public static func buildOptional(_ component: [AttributedTextSlice]?) -> [AttributedTextSlice] {
        component ?? []
    }
}

public struct Group: AttributedTextSlice {
    public var separator: [AttributedTextSlice]
    public var base: [AttributedTextSlice]
    public init(@AttributedTextBuilder separator: () -> [AttributedTextSlice],  @AttributedTextBuilder content: () -> [AttributedTextSlice]) {
        self.separator = separator()
        base = content()
    }

    public init(separator: String,  @AttributedTextBuilder content: () -> [AttributedTextSlice]) {
        self.separator = [separator]
        base = content()
    }

    public init(separator: AttributedTextSlice,  @AttributedTextBuilder content: () -> [AttributedTextSlice]) {
        self.separator = [separator]
        base = content()
    }

    public init(@AttributedTextBuilder content: () -> [AttributedTextSlice]) {
        self.separator = []
        base = content()
    }

    public func fragments(with attributes: [NSAttributedString.Key: Any]) -> [Fragment] {
        guard let first = base.first else { return [] }
        let separator = separator.fragments(with: attributes)
        var fragments: [Fragment] = first.fragments(with: attributes)
        for element in base.dropFirst() {
            fragments.append(contentsOf: separator)
            fragments.append(contentsOf: element.fragments(with: attributes))
        }
        return fragments
    }
}

public extension NSAttributedString {
    struct Builder: AttributedTextSlice {
        public var base: [AttributedTextSlice]
        public init(@AttributedTextBuilder builder: () -> [AttributedTextSlice]) {
            base = builder()
        }

        public func fragments(with attributes: [NSAttributedString.Key: Any]) -> [Fragment] {
            base.fragments(with: attributes)
        }
    }
}
