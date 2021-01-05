import XCTest
import SwiftUI
import ViewInspector
@testable import NauMai

extension ImageSliderView: Inspectable { }
extension Image: Inspectable { }

final class ImageSliderViewTests: XCTestCase {
    func testInit() {
        let control = ImageSliderView(images: ImageContent.symbols, size: CGSize.zero, currentIndex: 0, action: { _ in })
        XCTAssertEqual(control.images, ImageContent.symbols)
        XCTAssertEqual(control.size, CGSize.zero)
        XCTAssertEqual(control.currentIndex, 0)
        
    }

    func testRendersCorrectNumberOfImages() throws {
        let control = ImageSliderView(images: ImageContent.symbols, size: CGSize.zero, currentIndex: 0, action: { _ in })
        for index in ImageContent.symbols.indices {
            XCTAssertNoThrow(try control.inspect().hStack().forEach(0).anyView(index))
        }
    }
    
    static var allTests = [
        ("testInit", testInit),
        ("testRendersCorrectNumberOfImages", testRendersCorrectNumberOfImages),
    ]
}
