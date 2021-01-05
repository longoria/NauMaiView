import SwiftUI

#if os(macOS)
let pagePadding: CGFloat = 5.0
let pagerDotSize: CGFloat = 10.0
let dotMagnifier: CGFloat = 1.01
#else
let pagePadding: CGFloat = 10.0
let pagerDotSize: CGFloat = 20.0
let dotMagnifier: CGFloat = 1.5
#endif

/**
 SwiftUI View that creates "paging dot" controls that are interactive
 
 - returns:
 An initialized `PagerControlView`

 - parameters:
    - action: Closure that is called when a "paging dot" is interacted with
    - currentIndex: Active image position to indicate
    - stepCount: Number of steps that need to be accounted for
 */
public struct PagerControlView: View {
    let action: (_ index: Int) -> Void
    let currentIndex: Int
    let stepCount: Int

    public var body: some View {
        HStack {
            ForEach(0..<stepCount, id: \.self) { index in
                Button(action: { action(index) }, label: {
                    Circle()
                        .size(width: pagerDotSize - (CGFloat(abs(index - currentIndex)) * dotMagnifier), height: pagerDotSize)
                        .fill(currentIndex == index ? Color.primary : Color.secondary)
                        .animation(.easeIn)
                })
                .accessibility(hint: Text("View step \(index + 1)", bundle: .module))
                .frame(width: 20, height: 20, alignment: .center)
                .buttonStyle(BorderlessButtonStyle())
                .padding(pagePadding)
            }
        }
    }
}

struct PagerControlView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PagerControlView(action: { _ in }, currentIndex: 2, stepCount: 4)
            PagerControlView(action: { _ in }, currentIndex: 2, stepCount: 4)
                .preferredColorScheme(.dark)
        }.padding(0)
    }
}
