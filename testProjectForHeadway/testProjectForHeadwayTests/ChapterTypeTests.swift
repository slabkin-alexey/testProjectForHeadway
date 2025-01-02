//
//  ChapterTypeTests.swift
//

@testable import testProjectForHeadway
import XCTest
import SwiftUI

class ChapterTypeTests: XCTestCase {
    func test_chapter_description() {
        for chapter in ChapterType.allCases {
            XCTAssertEqual(chapter.description, "chapter_\(chapter.id)".localized)
        }
    }
    
    func test_chapter_title() {
        for chapter in ChapterType.allCases {
            XCTAssertEqual(chapter.title, "book_title".localized)
        }
    }
    
    func test_chapter_chapterNumber() {
        for chapter in ChapterType.allCases {
            XCTAssertEqual(chapter.chapterNumber, "chapter_number".localized(with: chapter.id))
        }
    }
    
    func test_chapter_audioFileName() {
        for chapter in ChapterType.allCases {
            XCTAssertEqual(chapter.audioFileName, "chapter_\(chapter.id)")
        }
    }
    
    func test_chapter_isAtStartOfList() {
        XCTAssertEqual(ChapterType.chapter1.isAtStartOfList, true)
        XCTAssertEqual(ChapterType.chapter2.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter3.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter4.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter5.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter6.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter7.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter8.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter9.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter10.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter11.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter12.isAtStartOfList, false)
        XCTAssertEqual(ChapterType.chapter13.isAtStartOfList, false)
    }
    
    func test_chapter_isAtEndOfList() {
        XCTAssertEqual(ChapterType.chapter1.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter2.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter3.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter4.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter5.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter6.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter7.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter8.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter9.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter10.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter11.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter12.isAtEndOfList, false)
        XCTAssertEqual(ChapterType.chapter13.isAtEndOfList, true)
    }
    
    func test_chapter_uiImage() {
        XCTAssertEqual(ChapterType.chapter1.uiImage, .cover1)
        XCTAssertEqual(ChapterType.chapter2.uiImage, .cover2)
        XCTAssertEqual(ChapterType.chapter3.uiImage, .cover3)
        XCTAssertEqual(ChapterType.chapter4.uiImage, .cover4)
        XCTAssertEqual(ChapterType.chapter5.uiImage, .cover5)
        XCTAssertEqual(ChapterType.chapter6.uiImage, .cover6)
        XCTAssertEqual(ChapterType.chapter7.uiImage, .cover7)
        XCTAssertEqual(ChapterType.chapter8.uiImage, .cover8)
        XCTAssertEqual(ChapterType.chapter9.uiImage, .cover9)
        XCTAssertEqual(ChapterType.chapter10.uiImage, .cover10)
        XCTAssertEqual(ChapterType.chapter11.uiImage, .cover11)
        XCTAssertEqual(ChapterType.chapter12.uiImage, .cover12)
        XCTAssertEqual(ChapterType.chapter13.uiImage, .cover13)
    }
}
