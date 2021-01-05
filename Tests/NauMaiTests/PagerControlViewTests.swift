import XCTest
import SwiftUI
import ViewInspector
@testable import NauMai

extension PagerControlView: Inspectable { }

final class PagerControlViewTests: XCTestCase {
    func testInit() {
        let control = PagerControlView(action: { _ in }, currentIndex: 0, stepCount: 3)
        XCTAssertEqual(control.currentIndex, 0)
        XCTAssertEqual(control.stepCount, 3)
    }

    func testRendersCorrectNumberOfSteps() throws {
        let stepCount = 3
        let view = PagerControlView(action: { _ in }, currentIndex: 0, stepCount: stepCount)
        for index in 0..<stepCount {
            XCTAssertNoThrow(try view.inspect().hStack().forEach(0).button(index).accessibilityHint())
        }
    }

    func testMessagesInteractedIndices() throws {
        let stepCount = 3
        var interactedIndex = -1
        let action = { interactedIndex = $0 }
        let view = PagerControlView(action: action, currentIndex: 0, stepCount: stepCount)
        for index in 0..<stepCount {
            try view.inspect().hStack().forEach(0).button(index).tap()
            XCTAssertEqual(interactedIndex, index)
        }
    }
    
    static var allTests = [
        ("testInit", testInit),
        ("testRendersCorrectNumberOfSteps", testRendersCorrectNumberOfSteps),
        ("testMessagesInteractedIndices", testMessagesInteractedIndices),
    ]
}
