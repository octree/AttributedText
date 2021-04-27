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
    public static func buildBlock(_ items: AttributedTextSlice...) -> AttributedTextSlice {
        return items.flatMap { $0.texts }
    }

    public static func buildIf(_ items: AttributedTextSlice?...) -> AttributedTextSlice {
        return items.flatMap { $0?.texts ?? [] }
    }

    public static func buildExpression(_ slice: AttributedTextSlice) -> AttributedTextSlice {
        return slice
    }

    public static func buildArray(_ components: [AttributedTextSlice]) -> AttributedTextSlice {
        return components.flatMap { $0.texts }
    }

    public static func buildLimitedAvailability(_ component: AttributedTextSlice) -> AttributedTextSlice {
        return component
    }

    public static func buildEither(first component: AttributedTextSlice) -> AttributedTextSlice {
        return component
    }

    public static func buildEither(second component: AttributedTextSlice) -> AttributedTextSlice {
        component
    }

    public static func buildOptional(_ component: AttributedTextSlice?) -> AttributedTextSlice {
        component ?? [AttributedText]()
    }
}

public struct Group: AttributedTextSlice {
    public var texts: [AttributedText]
    public init(@AttributedTextBuilder builder: () -> AttributedTextSlice) {
        texts = builder().texts
    }
}

public extension NSAttributedString {
    struct Builder: AttributedTextSlice {
        public var texts: [AttributedText]
        public init(@AttributedTextBuilder builder: () -> AttributedTextSlice) {
            texts = builder().texts
        }
    }
}
