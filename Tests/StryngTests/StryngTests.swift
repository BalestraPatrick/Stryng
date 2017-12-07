//
//  StryngTests.swift
//  Stryng
//
//  Created by Patrick Balestra on 12/2/17.
//  Copyright © 2017 Stryng. All rights reserved.
//

import Foundation
import XCTest
import Stryng

class StryngTests: XCTestCase {

    func testSubscriptRange() {
        let example = "Example"
        XCTAssertEqual(example[0..<2], "Ex")
    }

    func testSubscriptRangeEmpty() {
        let example = "Example"
        XCTAssertEqual(example[0..<0], "")
    }

    func testSubscriptRangeOutOfBounds() {
        let example = "Example"
        XCTAssertNil(example[10..<12])
        XCTAssertNil(example[0..<12])
    }

    func testSubscriptClosedRangeEmoji() {
        let example = "👨‍👩‍👧‍👧"
        XCTAssertEqual(example[0...0], "👨‍👩‍👧‍👧")
    }

    func testSubscriptClosedRangeOutOfBounds() {
        let example = "Example"
        XCTAssertNil(example[0...8])
        XCTAssertNil(example[10...11])
    }

    func testSubscriptPartialRangeUpTo() {
        let example = "Example"
        let result = example[..<1]
        XCTAssertEqual(result, "E")
    }

    func testSubscriptPartialRangeUpToOutOfBounds() {
        let example = "Example"
        let result = example[..<8]
        XCTAssertNil(result)
    }

    func testSubscriptPartialRangeThroughTo() {
        let example = "Example"
        let result = example[...1]
        XCTAssertEqual(result, "Ex")
    }

    func testSubscriptPartialRangeThroughToOutOfBounds() {
        let example = "Example"
        let result = example[...8]
        XCTAssertNil(result)
    }

    func testSubscriptPartialRangeFrom() {
        let example = "Example"
        let result = example[1...]
        XCTAssertEqual(result, "xample")
    }

    func testSubscriptPartialRangeFromOutOfBounds() {
        let example = "Example"
        let result = example[10...]
        XCTAssertNil(result)
    }

    func testSubscriptOfSubstringOccurence() {
        let example = "Example"
        let occurence = example["xa"].first
        let left = example.distance(from: example.startIndex, to: occurence!.lowerBound)
        let right = example.distance(from: example.startIndex, to: occurence!.upperBound)
        XCTAssertEqual(left, 1)
        XCTAssertEqual(right, 3)
        XCTAssertEqual(example[left..<right], "xa")
    }

    func testSubscriptOfSubstringOccurences() {
        let example = "Example Example"
        let occurences = example["xa"]
        XCTAssertEqual(occurences.count, 2)
        do {
            let left = example.distance(from: example.startIndex, to: occurences[0].lowerBound)
            let right = example.distance(from: example.startIndex, to: occurences[0].upperBound)
            XCTAssertEqual(left, 1)
            XCTAssertEqual(right, 3)
            XCTAssertEqual(example[left..<right], "xa")
        }
        do {
            let left = example.distance(from: example.startIndex, to: occurences[1].lowerBound)
            let right = example.distance(from: example.startIndex, to: occurences[1].upperBound)
            XCTAssertEqual(left, 9)
            XCTAssertEqual(right, 11)
            XCTAssertEqual(example[left..<right], "xa")
        }
    }

    func testSubscriptOfStringsClosedRange() {
        let example = "Example Example"
        let occurences = example["E"..."e"]
        XCTAssertEqual(occurences.count, 2)
        do {
            let left = example.distance(from: example.startIndex, to: occurences[0].lowerBound)
            let right = example.distance(from: example.startIndex, to: occurences[0].upperBound)
            XCTAssertEqual(left, 0)
            XCTAssertEqual(right, 7)
            XCTAssertEqual(example[left..<right], "Example")
        }
        do {
            let left = example.distance(from: example.startIndex, to: occurences[1].lowerBound)
            let right = example.distance(from: example.startIndex, to: occurences[1].upperBound)
            XCTAssertEqual(left, 8)
            XCTAssertEqual(right, 15)
            XCTAssertEqual(example[left..<right], "Example")
        }
    }

    func testSubscriptOfStringsRange() {
        let example = "Example Example"
        let occurences = example["E"..<"e"]
        XCTAssertEqual(occurences.count, 2)
        do {
            let left = example.distance(from: example.startIndex, to: occurences[0].lowerBound)
            let right = example.distance(from: example.startIndex, to: occurences[0].upperBound)
            XCTAssertEqual(left, 1)
            XCTAssertEqual(right, 6)
            XCTAssertEqual(example[left..<right], "xampl")
        }
        do {
            let left = example.distance(from: example.startIndex, to: occurences[1].lowerBound)
            let right = example.distance(from: example.startIndex, to: occurences[1].upperBound)
            XCTAssertEqual(left, 9)
            XCTAssertEqual(right, 14)
            XCTAssertEqual(example[left..<right], "xampl")
        }
    }

    func testSubscriptOfStringPartialRangeFrom() {
        let example = "Example Example"
        let occurence = example["Example "...]!
        let left = example.distance(from: example.startIndex, to: occurence.lowerBound)
        XCTAssertEqual(left, 8)
        XCTAssertEqual(example[left...], "Example")
    }

    func testSubscriptOfStringRangeThroughTo() {
        let example = "Example Example"
        let occurence = example[..." Example"]!
        let right = example.distance(from: example.startIndex, to: occurence.upperBound)
        XCTAssertEqual(right, 7)
        XCTAssertEqual(example[..<right], "Example")
    }
    
    static var allTests = [
        ("testSubscript", testSubscriptRange),
        ("testSubscriptRangeEmpty", testSubscriptRangeEmpty),
        ("testSubscriptRangeOutOfBounds", testSubscriptRangeOutOfBounds),
        ("testSubscriptClosedRangeEmoji", testSubscriptClosedRangeEmoji),
        ("testSubscriptClosedRangeOutOfBounds", testSubscriptClosedRangeOutOfBounds),
        ("testSubscriptPartialRangeUpTo", testSubscriptPartialRangeUpTo),
        ("testSubscriptPartialRangeUpToOutOfBounds", testSubscriptPartialRangeUpToOutOfBounds),
        ("testSubscriptPartialRangeThroughTo", testSubscriptPartialRangeThroughTo),
        ("testSubscriptPartialRangeThroughToOutOfBounds", testSubscriptPartialRangeThroughToOutOfBounds),
        ("testSubscriptPartialRangeFrom", testSubscriptPartialRangeFrom),
        ("testSubscriptPartialRangeFromOutOfBounds", testSubscriptPartialRangeFromOutOfBounds),
        ("testSubscriptOfSubstringOccurence", testSubscriptOfSubstringOccurence),
        ("testSubscriptOfSubstringOccurences", testSubscriptOfSubstringOccurences),
        ("testSubscriptOfStringsClosedRange", testSubscriptOfStringsClosedRange),
        ("testSubscriptOfStringsRange", testSubscriptOfStringsRange),
        ("testSubscriptOfStringPartialRangeFrom", testSubscriptOfStringPartialRangeFrom)
    ]
}
