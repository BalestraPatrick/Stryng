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

    func testIndex() {
        let example = "Example"
        XCTAssertEqual(example[1], "x")
    }

    func testRange() {
        let example = "Example"
        XCTAssertEqual(example[0..<2], "Ex")
    }

    func testRangeEmpty() {
        let example = "Example"
        XCTAssertEqual(example[0..<0], "")
    }

    func testRangeOutOfBounds() {
        let example = "Example"
        XCTAssertNil(example[10..<12])
        XCTAssertNil(example[0..<12])
    }
    
    func testRangeNegative() {
        let example = "Example"
        XCTAssertEqual(example[..<(-1)], "Exampl")
        XCTAssertEqual(example[..<(-3)], "Exam")
    }

    func testClosedRangeEmoji() {
        let example = "👨‍👩‍👧‍👧"
        XCTAssertEqual(example[0...0], "👨‍👩‍👧‍👧")
    }

    func testClosedRangeOutOfBounds() {
        let example = "Example"
        XCTAssertNil(example[0...8])
        XCTAssertNil(example[10...11])

    }
    
    func testClosedRangeNegative() {
        let example = "Example"
        XCTAssertEqual(example[-2...(-1)], "le")
        XCTAssertEqual(example[-4...(-1)], "mple")
        XCTAssertNil(example[-10...(-1)])
    }

    func testPartialRangeUpTo() {
        let example = "Example"
        let result = example[..<1]
        XCTAssertEqual(result, "E")
    }

    func testPartialRangeUpToOutOfBounds() {
        let example = "Example"
        let result = example[..<8]
        XCTAssertNil(result)
        
    }

    func testPartialRangeThroughTo() {
        let example = "Example"
        let result = example[...1]
        XCTAssertEqual(result, "Ex")
    }

    func testPartialRangeThroughToOutOfBounds() {
        let example = "Example"
        let result = example[...8]
        XCTAssertNil(result)
    }

    func testPartialRangeFrom() {
        let example = "Example"
        let result = example[1...]
        XCTAssertEqual(result, "xample")
    }

    func testPartialRangeFromOutOfBounds() {
        let example = "Example"
        let result = example[10...]
        XCTAssertNil(result)
    }

    func testSubstringOccurence() {
        let example = "Example"
        let occurence = example["xa"].first
        let left = example.distance(from: example.startIndex, to: occurence!.lowerBound)
        let right = example.distance(from: example.startIndex, to: occurence!.upperBound)
        XCTAssertEqual(left, 1)
        XCTAssertEqual(right, 3)
        XCTAssertEqual(example[left..<right], "xa")
    }

    func testSingleCharacterOccurence() {
        let example = "Example Example"
        let occurences = example[Character("a")]
        XCTAssertEqual(occurences.count, 2)
        XCTAssertEqual(example[occurences[0]], "a")
        XCTAssertEqual(example[occurences[1]], "a")
    }

    func testSubstringOccurences() {
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

    func testStringsClosedRange() {
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

    func testStringsRange() {
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

    func testStringPartialRangeFrom() {
        let example = "Example Example"
        let occurence = example["Example "...]!
        let left = example.distance(from: example.startIndex, to: occurence.lowerBound)
        XCTAssertEqual(left, 8)
        XCTAssertEqual(example[left...], "Example")
    }

    func testStringRangeThroughTo() {
        let example = "Example Example"
        let occurence = example[..." Example"]!
        let right = example.distance(from: example.startIndex, to: occurence.upperBound)
        XCTAssertEqual(right, 7)
        XCTAssertEqual(example[..<right], "Example")
    }
    
    static var allTests = [
        ("testIndex", testIndex),
        ("testRange", testRange),
        ("testRangeEmpty", testRangeEmpty),
        ("testRangeOutOfBounds", testRangeOutOfBounds),
        ("testClosedRangeEmoji", testClosedRangeEmoji),
        ("testClosedRangeOutOfBounds", testClosedRangeOutOfBounds),
        ("testPartialRangeUpTo", testPartialRangeUpTo),
        ("testPartialRangeUpToOutOfBounds", testPartialRangeUpToOutOfBounds),
        ("testPartialRangeThroughTo", testPartialRangeThroughTo),
        ("testPartialRangeThroughToOutOfBounds", testPartialRangeThroughToOutOfBounds),
        ("testPartialRangeFrom", testPartialRangeFrom),
        ("testPartialRangeFromOutOfBounds", testPartialRangeFromOutOfBounds),
        ("testSingleCharacterOccurence", testSingleCharacterOccurence),
        ("testSubstringOccurence", testSubstringOccurence),
        ("testSubstringOccurences", testSubstringOccurences),
        ("testStringsClosedRange", testStringsClosedRange),
        ("testStringsRange", testStringsRange),
        ("testStringPartialRangeFrom", testStringPartialRangeFrom)
    ]
}
