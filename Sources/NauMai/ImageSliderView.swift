import SwiftUI

/**
 SwiftUI View that handles positioning of active image and propagating user gestures for swiping
 
 - returns:
 An initialized `ImageSliderView`

 - parameters:
    - images: An array of `ImageContent` instances describing your welcome content
    - size: Size of the total image cumulative
    - currentIndex: Active image position to display
    - action: Closure that is called when a swipe gesture is detected
 */
public struct ImageSliderView: View {
    let images: [ImageContent]
    let size: CGSize
    let currentIndex: Int
    let action: (_ direction: SwipeDirection) -> Void
    
    @State private var offsetX: CGFloat = 0.0

    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(images) { content in
                content.imageView()
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                handleDrag(with: gesture)
                            }
                            .onEnded { gesture in
                                handleDragFinish(with: gesture)
                            }
                    )
            }
        }
        .frame(width: size.width, height: size.height, alignment: .leading)
        .offset(x: (CGFloat(currentIndex) * -size.width) + offsetX, y: 0.0)
        .animation(.spring())
    }
    
    private func handleDrag(with gesture: DragGesture.Value) {
        offsetX = gesture.translation.width
    }
    
    private func handleDragFinish(with gesture: DragGesture.Value) {
        guard abs(offsetX) > size.width / 3 else {
            offsetX = 0
            return
        }
        if offsetX >= 0 {
            action(.backward)
        } else if offsetX < 0 {
            action(.forward)
        }
        offsetX = 0.0
    }
}

struct ImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSliderView(
            images: ImageContent.symbols,
            size: CGSize(width: 300, height: 300),
            currentIndex: 0,
            action: { _ in })
    }
}
