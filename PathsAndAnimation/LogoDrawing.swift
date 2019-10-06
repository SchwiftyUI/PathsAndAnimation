//
//  LogoDrawing.swift
//  PathsAndAnimation
//
//  Created by SchwiftyUI on 10/5/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct LogoDrawing: View {
    @State var textColor = Color.black
    @State var screenColor = Color.black
    @State var buttonOffset = 0.0
    @State var degreesLoaded = 0.0
    
    var body: some View {
        ZStack {
            IPhoneBorder().fill(Color.greenish)
            IPhoneButton(animatableData: buttonOffset).fill(Color.greenish).onTapGesture {
                self.turnScreenOn()
            }
            
            IPhoneScreen().fill(screenColor)
            IPhoneLoadingBar(animatableData: degreesLoaded).stroke(lineWidth: 10).fill(Color.whiteish)
            
            Text("{}").font(.system(size: 100, design: .monospaced)).foregroundColor(textColor)
        }
    }
    
    func turnScreenOn() {
        // Hide Button
        withAnimation(Animation.linear(duration: 0.1)) {
            self.buttonOffset = 10
        }
        
        // Loading Bar
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            withAnimation(Animation.linear(duration: 0.5)) {
                self.degreesLoaded = 360
            }
        }
        
        // Hide loading bar and show text
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) {_ in
            self.degreesLoaded = 0
            
            withAnimation {
                self.screenColor = Color.blackish
                self.textColor = Color.whiteish
            }
        }
        
    }
}

extension Color {
    static let greenish = Color(red: 103/255, green: 183/255, blue: 164/255)
    static let whiteish = Color(red: 208/255, green: 208/255, blue: 208/255)
    static let blackish = Color(red: 30/255, green: 32/255, blue: 36/255)
}

struct IPhoneBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 50))
        path.addQuadCurve(to: CGPoint(x: 50, y: 0), control: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 300, y: 0))
        path.addQuadCurve(to: CGPoint(x: 350, y: 50), control: CGPoint(x: 350, y: 0))
        path.addLine(to: CGPoint(x: 350, y: 600))
        path.addQuadCurve(to: CGPoint(x: 300, y: 650), control: CGPoint(x: 350, y: 650))
        path.addLine(to: CGPoint(x: 50, y: 650))
        path.addQuadCurve(to: CGPoint(x: 0, y: 600), control: CGPoint(x: 0, y: 650))
        path.addLine(to: CGPoint(x: 0, y: 50))
        
        let scale = (rect.width / 350) * (9 / 10)
        let xoffset = (rect.width * (1/10))/2
        let yoffset = (rect.height - rect.height * scale) * (1/10) / 2
        
        return path.applying(CGAffineTransform(scaleX: scale, y: scale)).applying(CGAffineTransform(translationX: xoffset, y: yoffset))
    }
}

struct IPhoneScreen: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 20, y: 50))
        path.addQuadCurve(to: CGPoint(x: 50, y: 20), control: CGPoint(x: 20, y: 20))
        
        path.addLine(to: CGPoint(x: 90, y: 20))
        path.addQuadCurve(to: CGPoint(x: 100, y: 30), control: CGPoint(x: 100, y: 20))
        path.addQuadCurve(to: CGPoint(x: 120, y: 50), control: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 230, y: 50))
        path.addQuadCurve(to: CGPoint(x: 250, y: 30), control: CGPoint(x: 250, y: 50))
        path.addQuadCurve(to: CGPoint(x: 260, y: 20), control: CGPoint(x: 250, y: 20))
        
        path.addLine(to: CGPoint(x: 300, y: 20))
        path.addQuadCurve(to: CGPoint(x: 330, y: 50), control: CGPoint(x: 330, y: 20))
        path.addLine(to: CGPoint(x: 330, y: 600))
        path.addQuadCurve(to: CGPoint(x: 300, y: 630), control: CGPoint(x: 330, y: 630))
        path.addLine(to: CGPoint(x: 50, y: 630))
        path.addQuadCurve(to: CGPoint(x: 20, y: 600), control: CGPoint(x: 20, y: 630))
        path.addLine(to: CGPoint(x: 20, y: 50))
        
        let scale = (rect.width / 350) * (9 / 10)
        let xoffset = (rect.width * (1/10))/2
        let yoffset = (rect.height - rect.height * scale) * (1/10) / 2
        
        return path.applying(CGAffineTransform(scaleX: scale, y: scale)).applying(CGAffineTransform(translationX: xoffset, y: yoffset))
    }
}

struct IPhoneButton: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRoundedRect(in: CGRect(x: 340 - animatableData, y: 100, width: 15, height: 60), cornerSize: CGSize(width: 3, height: 3))
        
        let scale = (rect.width / 350) * (9 / 10)
        let xoffset = (rect.width * (1/10))/2
        let yoffset = (rect.height - rect.height * scale) * (1/10) / 2
        
        return path.applying(CGAffineTransform(scaleX: scale, y: scale)).applying(CGAffineTransform(translationX: xoffset, y: yoffset))
    }
    
    var animatableData: Double
}

struct IPhoneLoadingBar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: 350/2, y: 650/2), radius: 350/4, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: animatableData), clockwise: false)
        
        let scale = (rect.width / 350) * (9 / 10)
        let xoffset = (rect.width * (1/10))/2
        let yoffset = (rect.height - rect.height * scale) * (1/10) / 2
        
        return path.applying(CGAffineTransform(scaleX: scale, y: scale)).applying(CGAffineTransform(translationX: xoffset, y: yoffset))
    }
    
    var animatableData: Double
}

struct LogoDrawing_Previews: PreviewProvider {
    static var previews: some View {
        LogoDrawing()
    }
}
