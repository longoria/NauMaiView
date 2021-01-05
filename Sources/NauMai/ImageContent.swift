import Foundation
import SwiftUI

public struct ImageContent: Identifiable {
    public let id = UUID()
    public let name: String
    public let message: LocalizedStringKey
    public let bundle: Bundle
    private let isSystemImage: Bool

    /**
     Initialize `ImageContent` for use in `NauMaiView` with a custom image
     
     - returns:
     An initialized ImageContent

     - parameters:
        - imageName: Name of a bundle image resource, passed as `name` to SwiftUI `Image`
        - message: Text content to be used as `Image` label content, must be localized.
        - bundle: `Bundle` that is the source for both the image asset and message localization
     */
    public init(imageName: String, message: LocalizedStringKey, bundle: Bundle) {
        self.name = imageName
        self.message = message
        self.bundle = bundle
        self.isSystemImage = false
    }

    /**
     Primarily used for SwiftUI previews. Initialize with a system image with `NauMaiView`
     
     - returns:
     An initialized ImageContent

     - parameters:
        - systemName: Name of a system image, passed as `systemName` to SwiftUI `Image`
        - message: Text content to be used as `Image` label content, must be localized.
        - bundle: `Bundle` that is the source for the message localization
     */
    public init(systemName: String, message: LocalizedStringKey, bundle: Bundle) {
        self.name = systemName
        self.message = message
        self.bundle = bundle
        self.isSystemImage = true
    }
    
    public func imageView() -> AnyView {
        guard isSystemImage == false else {
            return AnyView(
                Image(systemName: name)
                    .resizable()
                    .scaledToFit()
                    .accessibility(label: Text(message, bundle: bundle))
            )
        }
        return AnyView(
            Image(name, bundle: bundle, label: Text(message, bundle: bundle))
                .resizable()
                .scaledToFit()
        )
    }
    
}

extension ImageContent: Equatable {
    public static func == (lhs: ImageContent, rhs: ImageContent) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.message == rhs.message &&
            lhs.bundle == rhs.bundle
    }
}

#if DEBUG
extension ImageContent {
    static let symbols = [
        ImageContent(systemName: "hifispeaker.2", message: "Boom", bundle: .module),
        ImageContent(systemName: "heart", message: "Love", bundle: .module),
        ImageContent(systemName: "flame", message: "Hot", bundle: .module),
        ImageContent(systemName: "hand.thumbsup", message: "OK", bundle: .module)
    ]

}
#endif
