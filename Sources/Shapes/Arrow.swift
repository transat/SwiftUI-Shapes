//
//  Arrow.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import SwiftUI



/// Starts out small with the bars in an "I" shape
/// once it gets long enough   ↕︎
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct Arrow: Shape {
    
    var arrowOffset: CGFloat
    var length: CGFloat
    
        public var animatableData: AnimatablePair<CGFloat, CGFloat> {
            get { AnimatablePair(arrowOffset, length) }
            set {
                arrowOffset = newValue.first
                length = newValue.second
            }
        }
    
 
    public func path(in rect: CGRect) -> Path {
        Path { path in
            let w = rect.width
            let h = rect.height
            
            path.move(to: CGPoint(x: w/2, y: h/2 - self.length/2))
            path.addLine(to: CGPoint(x: w/2, y: h/2 + self.length/2))
            
            path.move(to: h > 40 ? CGPoint(x: w*self.arrowOffset, y: w*self.arrowOffset +  h/2 - self.length/2) : CGPoint(x: 0, y:  h/2 - self.length/2))
            path.addLine(to: CGPoint(x: w/2, y:  h/2 - self.length/2))
            path.addLine(to:  h > 40 ? CGPoint(x: w-w*self.arrowOffset, y: w*self.arrowOffset + h/2 - self.length/2) : CGPoint(x: w, y:  h/2 - self.length/2))
            
            path.move(to: h > 40 ? CGPoint(x: w*self.arrowOffset, y: h/2 + self.length/2 - w*self.arrowOffset) : CGPoint(x: 0, y: h/2 + self.length/2))
            path.addLine(to: CGPoint(x: w/2, y: h/2 + self.length/2))
            path.addLine(to:  h > 40 ? CGPoint(x: w-w*self.arrowOffset, y: h/2 + self.length/2 - w*self.arrowOffset) : CGPoint(x: w, y: h/2 + self.length/2))
            
            
        }
    }
    
    
}
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct ArrowMeter: View {
    @State var val: Double = 10
    @State var isHidden: Bool = false
    
    
    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(1..<9) { (i)  in
                    Arrow(arrowOffset: self.val > 100 ? 1/(2*1.414) : 0, length: CGFloat(self.val))
                        .stroke(Color("Light Green")).animation(.easeIn(duration: Double(i)/4.0))
                    .frame(width: 40)
                }
            }.frame(height: 300)
            Slider(value: $val, in: 1...250).padding()
            
        }
    }
}
