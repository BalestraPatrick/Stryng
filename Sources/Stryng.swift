//
//  Stryng.swift
//  Stryng
//
//  Created by Patrick Balestra on 12/2/17.
//  Copyright © 2017 Stryng. All rights reserved.
//

import Foundation

extension String {

    // String[1]
    public subscript(index: Int) -> Character? {
        guard let stringIndex = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else { return nil }
        return self[stringIndex]
    }

    // String[0..<1]
    public subscript(range: Range<Int>) -> Substring? {
        guard let left = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) else { return nil }
        guard let right = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else { return nil }
        return self[left..<right]
    }

    // String[0...1]
    public subscript(range: ClosedRange<Int>) -> Substring? {
        guard let left = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) else { return nil }
        guard let right = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else { return nil }
        return self[left...right]
    }

    // String[..<1]
    public subscript(value: PartialRangeUpTo<Int>) -> Substring? {
        guard let right = self + value.upperBound else { return nil }
        return self[..<right]
    }

    // String[...1]
    public subscript(value: PartialRangeThrough<Int>) -> Substring? {
        guard let right = self + value.upperBound else { return nil }
        return self[...right]
    }

    // String[1...]
    public subscript(value: PartialRangeFrom<Int>) -> Substring? {
        guard let left = self + value.lowerBound else { return nil }
        return self[left...]
    }

    // String["substring"]
    public subscript(_ string: String) -> [Range<String.Index>] {
        var occurences = [Range<String.Index>]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let range = self.range(of: string, options: [], range: initialLeftBound..<endIndex, locale: nil) else { break }
            occurences.append(range)
            initialLeftBound = range.upperBound
        }
        return occurences
    }

    // String["begin"..."end"]
    public subscript(range: ClosedRange<String>) -> [ClosedRange<String.Index>] {
        var occurences = [ClosedRange<String.Index>]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let beginRange = self.range(of: range.lowerBound, options: [], range: initialLeftBound..<endIndex, locale: nil) else { break }
            guard let endRange = self.range(of: range.upperBound, options: [], range: beginRange.upperBound..<endIndex, locale: nil) else { break }
            occurences.append(beginRange.lowerBound...endRange.upperBound)
            initialLeftBound = endRange.upperBound
        }
        return occurences
    }

    // String["begin"..<"end"]
    public subscript(range: Range<String>) -> [Range<String.Index>] {
        var occurences = [Range<String.Index>]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let beginRange = self.range(of: range.lowerBound, options: [], range: initialLeftBound..<endIndex, locale: nil) else { break }
            guard let endRange = self.range(of: range.upperBound, options: [], range: beginRange.upperBound..<endIndex, locale: nil) else { break }
            occurences.append(beginRange.upperBound..<endRange.lowerBound)
            initialLeftBound = endRange.upperBound
        }
        return occurences
    }

    // String["begin"...]
    public subscript(range: PartialRangeFrom<String>) -> PartialRangeFrom<String.Index>? {
        guard (self + range.lowerBound.count) != nil else { return nil }
        guard let beginRange = self.range(of: range.lowerBound, options: [], range: startIndex..<endIndex, locale: nil) else { return nil }
        return beginRange.upperBound...
    }

    // String[..."end"]
    public subscript(range: PartialRangeThrough<String>) -> PartialRangeThrough<String.Index>? {
        guard (self + range.upperBound.count) != nil else { return nil }
        guard let endRange = self.range(of: range.upperBound, options: [], range: startIndex..<endIndex, locale: nil) else { return nil }
        return ...endRange.lowerBound
    }

    // String + 1
    static internal func + (string: String, distance: Int) -> String.Index? {
        return string.index(string.startIndex, offsetBy: distance, limitedBy: string.endIndex)
    }
}
