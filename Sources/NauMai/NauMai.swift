import SwiftUI
import Combine

public let defaultPassivePause: TimeInterval = 6
public let defaultActivePause: TimeInterval = 18
private let pageControlHeight: CGFloat = 30.0

enum SwipeDirection {
    case forward
    case backward
}

public struct NauMaiView: View {
    private let images: [ImageContent]
    private let passivePause: TimeInterval
    private let activePause: TimeInterval
    
    @State private var currentIndex: Int = 0
    @State private var manualControl = false
    @State private var timer = Timer.publish(every: defaultPassivePause, on: .main, in: .common).autoconnect()

    /**
     Create a "NauMai" SwiftUI welcome view
     
     - returns:
     An initialized NauMaiView

     - parameters:
        - images: An array of `ImageContent` instances describing your welcome content
        - passivePause: (Optional. Default: `defaultPassivePause`) Pause before stepping when user is not actively engaing with the steps
        - activePause: (Optional. Default: `defaultActivePause`) Pause before stepping when user has engaged via interacting with the paging controls or swiping on images
     */
    public init(images: [ImageContent], passivePause: TimeInterval = defaultPassivePause, activePause: TimeInterval = defaultActivePause) {
        self.images = images
        self.passivePause = passivePause
        self.activePause = activePause
        self.timer = Timer.publish(every: passivePause, on: .main, in: .common).autoconnect()
        self.currentIndex = images.startIndex
    }
        
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                ImageSliderView(images: images, size: geo.size, currentIndex: currentIndex, action: handleSwipe)
                    .offset(x: 0, y: -pageControlHeight)
                    .onReceive(timer) { handlePauseStep(with: $0) }
                VStack(alignment: .trailing, spacing: 0) {
                    PagerControlView(action: { handlePageTap(to: $0) }, currentIndex: currentIndex, stepCount: images.count)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
            }
        }
    }
    
    private func handleSwipe(_ direction: SwipeDirection) {
        if (direction == .forward && currentIndex >= images.endIndex - 1) {
            return
        }
        if (direction == .backward && currentIndex <= images.startIndex) {
            return
        }
        let newIndex = nextIndex(in: direction)
        handlePageTap(to: newIndex)
    }
    
    private func handlePauseStep(with time: Date) {
        currentIndex = nextIndex(in: .forward)
        if (manualControl == true) {
            manualControl = false
            timer = Timer.publish(every: passivePause, on: .main, in: .common).autoconnect()
        }
    }
    
    private func nextIndex(in direction: SwipeDirection) -> Int {
        if (direction == .forward) {
            if currentIndex >= images.endIndex - 1 {
                return images.startIndex
            } else {
                return currentIndex + 1
            }
        } else {
            if currentIndex <= images.startIndex {
                return images.endIndex - 1
            } else {
                return currentIndex - 1
            }
        }
    }
    
    private func handlePageTap(to index: Int) {
        if (manualControl == false) {
            manualControl = true
            timer = Timer.publish(every: activePause, on: .main, in: .common).autoconnect()
        }
        currentIndex = index
    }
}

struct NauMai_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NauMaiView(images: ImageContent.symbols).frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(EdgeInsets(top: 40.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
        }
        .clipped()
        .padding(5.0)
    }
}
