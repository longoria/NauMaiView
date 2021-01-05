import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NauMaiViewTests.allTests),
        testCase(ImageContentTests.allTests),
        testCase(ImageSliderViewTests.allTests),
        testCase(PagerControlViewTests.allTests),
    ]
}
#endif
