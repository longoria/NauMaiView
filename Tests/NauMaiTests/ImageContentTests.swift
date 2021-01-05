import XCTest
import SwiftUI
@testable import NauMai

final class ImageContentTests: XCTestCase {
    func testInit() {
        let nonSystem = ImageContent(imageName: "hello", message: "message", bundle: .module)
        XCTAssertEqual(nonSystem.name, "hello")
        XCTAssertEqual(nonSystem.bundle, .module)
        let systemImage = ImageContent(systemName: "hello", message: "message", bundle: .module)
        XCTAssertEqual(systemImage.name, "hello")
        XCTAssertEqual(systemImage.bundle, .module)
    }

    func testProducesNonSystemImage() throws {
        let nonSystem = ImageContent(imageName: "hello", message: "message", bundle: .module)
        XCTAssertNotNil(nonSystem.imageView())
    }

    func testProducesSystemImage() throws {
        let systemImage = ImageContent(systemName: "hello", message: "message", bundle: .module)
        XCTAssertNotNil(systemImage.imageView())
    }
    
    static var allTests = [
        ("testInit", testInit),
        ("testProducesNonSystemImage", testProducesNonSystemImage),
        ("testProducesSystemImage", testProducesSystemImage),
    ]
}
