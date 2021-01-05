import XCTest
import SwiftUI
import ViewInspector
@testable import NauMai

extension NauMaiView: Inspectable { }

final class NauMaiViewTests: XCTestCase {
    func testInit() throws {
        let view = NauMaiView(images: ImageContent.symbols)
        XCTAssertNotNil(try view.inspect().geometryReader().zStack().view(ImageSliderView.self, 0))
        let customPauseView = NauMaiView(images: ImageContent.symbols, passivePause: 2, activePause: 4)
        XCTAssertNotNil(try customPauseView.inspect().geometryReader().zStack().view(ImageSliderView.self, 0))
    }

    static var allTests = [
        ("testInit", testInit),
    ]
}
