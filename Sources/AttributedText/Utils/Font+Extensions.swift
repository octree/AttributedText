//
//  Font+Extensions.swift
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
public typealias Font = UIFont
public typealias FontDescriptor = UIFontDescriptor
#else
import AppKit
public typealias Font = NSFont
public typealias FontDescriptor = NSFontDescriptor
extension FontDescriptor.SymbolicTraits {
    public static var traitBold: NSFontDescriptor.SymbolicTraits {
        .bold
    }
    public static var traitItalic: NSFontDescriptor.SymbolicTraits {
        .italic
    }
    public static var traitMonoSpace: NSFontDescriptor.SymbolicTraits {
        .monoSpace
    }
}
#endif

public extension Font {
    /// Font traits.
    var traits: FontDescriptor.SymbolicTraits {
        fontDescriptor.symbolicTraits
    }

    /// A bool value indicates whether the font contains a bold trait.
    var isBold: Bool {
        traits.contains(.traitBold)
    }

    /// A bool value indicates whether the font conatins an italics trait.
    var isItalics: Bool {
        traits.contains(.traitItalic)
    }

    /// A bool value indicates whether the font conatains a mono space trait.
    var isMonoSpaced: Bool {
        traits.contains(.traitMonoSpace)
    }

    /// A bool value indicates whether the font is apple emoji font.
    var isAppleEmoji: Bool {
        return fontName == ".AppleColorEmojiUI" || fontName == "LastResort"
    }

    func toggled(trait: FontDescriptor.SymbolicTraits) -> Font {
        let updatedFont: Font
        if self.contains(trait: trait) {
            updatedFont = removing(trait: trait)
        } else {
            updatedFont = adding(trait: trait)
        }

        return updatedFont
    }

    func contains(trait: FontDescriptor.SymbolicTraits) -> Bool {
        return traits.contains(trait)
    }

    /// Returns a font by adding a specific trait.
    /// - Parameter trait: The trait to add.
    /// - Returns: A font.
    func adding(trait: FontDescriptor.SymbolicTraits) -> Font {
        var traits = self.traits
        traits.formUnion(trait)
        #if canImport(UIKit)
        guard let updatedFontDescriptor = fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        return Font(descriptor: updatedFontDescriptor, size: 0.0)
        #else
        let updatedFontDescriptor = fontDescriptor.withSymbolicTraits(traits)
        return Font(descriptor: updatedFontDescriptor, size: 0.0) ?? self
        #endif
    }

    /// Returns a font by removing a specific trait.
    /// - Parameter trait: The trait to remove.
    /// - Returns: A font.
    func removing(trait: FontDescriptor.SymbolicTraits) -> Font {
        var traits = self.traits
        traits.subtract(trait)
        #if canImport(UIKit)
        guard let updatedFontDescriptor = fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        return UIFont(descriptor: updatedFontDescriptor, size: 0.0)
        #else
        let updatedFontDescriptor = fontDescriptor.withSymbolicTraits(traits)
        return Font(descriptor: updatedFontDescriptor, size: 0.0) ?? self
        #endif
    }
}
