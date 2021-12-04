//
//  ControlView.swift
//  ControlView
//
//  Created by Andrej Kling on 06.10.21.
//

import SwiftUI

struct ControlView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var status = true
    @State private var progress : CGFloat = 0
    @State private var angleValue : CGFloat = 0.0
    let radius : CGFloat = 110
    let strokeWidth: CGFloat = 40
    let knobRadius : CGFloat = 21
     
    let config = CircularProgress(minValue: 0, maxValue: 40, totalValue: 40)
     
    var body: some View {
        
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false){
                
                VStack(spacing: 33) {
                    
                    QuickControl()
                    
                    mainControlView()
                    
                    SpeedView()
                        .padding(.top, 55)
                    
                    ModeView()
                        .padding(.top, 21)
                        .padding(.bottom, 33)
                    
                }
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
    }
}

extension ControlView {
    
    @ViewBuilder
    func QuickControl() -> some View {
        
        HStack(alignment: .top) {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
              
            }, label: {
                Image("menu")
                    .font(.system(size: 18, weight: .regular, design: .serif))
            })
                .buttonStyle(DarkButtonStyle())
            
            Spacer(minLength: 0)
            
            VStack {
                
                Text( status ? "A/C is ON" : "A/C is OFF")
                    .kerning(5.5)
                    .font(.system(size: 21, weight: .heavy, design: .serif))
                    .foregroundColor(.textPrimary)
                
                Text( status ? "Tap to turn off or swipe up \nfor a fast setup" : "Tap to turn on or swipe up \nfor a fast setup")
                    .kerning(0.2)
                 .font(.system(size: 18, weight: .regular, design: .serif))
                 .multilineTextAlignment(.center)
                 .lineLimit(nil)
                 .foregroundColor(.buttonTintColor)
            }
            .padding(.top, 33)
            .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0)
            .blur(radius: 0.1)
            
            Spacer(minLength: 0)
            
            Toggle(isOn: $status, label: {
                
                Image("power")
            })
                .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0)
                .toggleStyle(CustomToggleStyle(diametr: 55))
            
        }
        .padding()
    }
    
    @ViewBuilder
    func mainControlView() -> some View {
        
        ZStack {
            
            progressBackgroundView(radius: radius)
        
            Circle()
                .trim(from: 0.0, to: progress / config.totalValue)
                .stroke(Color.blueIndicaor, style: StrokeStyle(lineWidth: strokeWidth + 5, lineCap: .round))
                .frame(width: radius * 2, height: radius * 2)
                .rotationEffect(.degrees(90))
            
            knobView(radius: knobRadius)
                .offset(y: -radius)
                .rotationEffect(.degrees(Double(angleValue)))
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: -4)
                .gesture(DragGesture(minimumDistance:10)
                  
                            .onChanged({ value in
                    
                    self.changeProgress(location: value.location)
                })
                )
                .rotationEffect(.degrees(180))
            
            ProgressIndicatorsView(progress: $progress, totalValue: config.totalValue)
                .rotationEffect(.degrees(90))
            
            VStack(alignment: .leading, spacing: 5) {
                
                if progress == 0 {
                    
                    
                    Text("\(String.init(format: "%.0f",  progress))°C")
                        .font(.system(size: 24, weight: .regular, design: .serif))
                        .foregroundColor(.textPrimary)
                      
                    
                } else  if progress > 20 {
                    
                    Text("\(String.init(format: "%.0f",  progress))°C")
                        .font(.system(size: 24, weight: .regular, design: .serif))
                        .foregroundColor(.textPrimary)
                        
                    
                } else if progress < 20 {
                    
                    Text("-\(String.init(format: "%.0f",  progress))°C")
                        .font(.system(size: 24, weight: .regular, design: .serif))
                        .foregroundColor(.textPrimary)
                        
                }
            
                if progress == 0 {
                    
                    
                    Text("Temp")
                        .font(.system(size: 21, weight: .regular, design: .serif))
                        .foregroundColor(.textPrimary)
                        .opacity(0.6)
                    
                } else  if progress > 20 {
                    
                    Text("Hot")
                        .font(.system(size: 21, weight: .regular, design: .serif))
                        .foregroundColor(.textPrimary)
                        .opacity(0.6)
                    
                } else if progress < 20 {
                    
                    Text("Cool")
                        .font(.system(size: 21, weight: .regular, design: .serif))
                        .foregroundColor(.textPrimary)
                        .opacity(0.6)
                }
            }
            
        }
        .padding(.top, 55)
    }
    
    @ViewBuilder
    func progressBackgroundView(radius: CGFloat) -> some View {
        
        ZStack {
            
            Circle()
                .fill(Color.sliderBackgroundEnd)
                .frame(width: radius * 2, height: radius * 2)
                .scaleEffect(1.3)
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: -5, y: -5)

            Circle()
                .stroke(Color.backgroundColor, lineWidth: 55)
                .frame(width: radius * 2, height: radius * 2)
        }
    }
    
    @ViewBuilder
    private func knobView(radius : CGFloat) -> some View {
        ZStack {
            
            Circle()
                .fill(Color.knobLinear)
                .frame(width: radius * 2, height: radius * 2)
            
            Circle()
                .fill(Color.blueIndicaor)
                .frame(width: 4, height: 4)
        }
        .shadow(color: Color.white.opacity(0.5), radius: 3, x: 0, y: 0)
        
    }
    
    struct CircularProgress {
        
        let minValue : CGFloat
        let maxValue : CGFloat
        let totalValue : CGFloat
        
    }
    
    private func changeProgress(location: CGPoint) {
        
        let vector = CGVector(dx: location.x, dy: location.y)
        let angle = atan2(vector.dy - knobRadius, vector.dx - knobRadius) + .pi / 2.0
        
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        
        if value > config.minValue && value < config.maxValue {
            
            progress = value
            angleValue = fixedAngle * 180 / .pi
        }
    }
    
    struct ProgressIndicatorsView : View {
        
        @Binding var progress : CGFloat
        
        let totalValue : CGFloat
        let indicatorCount = 8
        
        var body: some View {
            
            ZStack {
                
                ForEach(Array(stride(from: 0, to: indicatorCount, by: 1)), id:\.self) { i in
                    
                    IndicatorView(isOn: progress >= CGFloat(i) * totalValue / CGFloat(indicatorCount), offsetValue: 160)
                        .rotationEffect(.degrees(Double(i * 360 / indicatorCount)))
                    
                }
            }
        }
    }
    
    struct IndicatorView: View {
        
        let isOn : Bool
        let offsetValue : CGFloat
        
        var body: some View {
            
            RoundedRectangle(cornerRadius: 2)
                .fill(isOn ? Color.blueIndicaor : Color.white.opacity(0.3))
                .frame(width: 15, height: 3)
                .offset(x: offsetValue)
        }
    }
    
    @ViewBuilder
    func SpeedView() -> some View {
        
        VStack {
            
            Text("Speed")
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(.textPrimary)
            
            GeometryReader { geometry in
                
                speedLine(width: geometry.size.width)
                    .padding(.top, 8)
            }
            .frame(height: 51)
        }
    }
    
    struct speedLine : View {
        
        @State private var progress : CGFloat = 0.0
        @State private var radiusPosition : CGFloat = 0.0
        
        let configSpeed = SpeedConfiguration()
        let width : CGFloat
        
        var body: some View {
            
            VStack {
                
                HStack {
                    
                    ForEach(1...5, id:\.self) { s in
                        
                        Text("\(s)")
                        
                        if s != 5 {
                            
                            Spacer()
                        }
                    }
                }
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(.white)
                
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.darkShadow)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.black.opacity(0.95))
                                .blur(radius: 5)
                                .mask(RoundedRectangle(cornerRadius: 5))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.sliderTopShadow)
                                .blur(radius: 3)
                                .offset(y: 6)
                                .mask(RoundedRectangle(cornerRadius: 5))
                        )
                        .frame(height: 7)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blueIndicaor)
                        .frame(width: radiusPosition, height: 2)
                    
                    knobsView(radius: configSpeed.radius)
                        .offset(x: radiusPosition)
                        .gesture(DragGesture(minimumDistance: 0)
                                 
                                    .onChanged({ value in
                            calculateProgressWidth(xLocation: value.location.x)
                        })
                                    .onEnded({ value in
                            
                            calculateStep(xLocation: value.location.x)
                        })
                        )
                }
            }
           // .padding(.horizontal)
        }
        func calculateProgressWidth(xLocation: CGFloat){
            
            let tempProgress = xLocation / width
            if tempProgress > 0 && tempProgress <= 1 {
                
                progress = (tempProgress * (configSpeed.maximum - configSpeed.minimum)) + configSpeed.minimum
                
                let tempPosition = (tempProgress * width) - configSpeed.radius
                radiusPosition = tempPosition > 0 ? tempPosition : 0
            }
        }
        
        func calculateStep(xLocation: CGFloat){
            
            let tempProgress = xLocation / width
            
            if tempProgress >= 0 && tempProgress <= 1 {
                
                var roundedProgress = (tempProgress * (configSpeed.maximum - configSpeed.minimum)) + configSpeed.minimum
                
                roundedProgress = roundedProgress.rounded() // return exactly same width...
                
                 progress = roundedProgress
                
                let updatedTempProgress = (roundedProgress - configSpeed.minimum) / (configSpeed.maximum - configSpeed.minimum)
                
                radiusPosition = updatedTempProgress == 0 ? 0 : (updatedTempProgress * width) - configSpeed.radius
            }
        }
    }
    
    struct knobsView : View {
        let radius: CGFloat
        var body: some View {
            
            ZStack {
                
                Circle()
                .fill(Color.knobLinear)
                .frame(width: radius * 2, height: radius * 2)
                .shadow(color: Color.white.opacity(0.3), radius: 3, x: 0, y: 0)
                
                Circle()
                    .fill(Color.blueIndicaor)
                    .frame(width: 4, height: 4)
                
            }
        }
    }
    
    struct SpeedConfiguration {
        
        let minimum :CGFloat = 1.0
        let maximum : CGFloat = 5.0
        let radius : CGFloat = 14
    }
    
    struct ACMode : Identifiable {
        
        let id : Int
        let title : String
        let imageName : String
        var selected : Bool = false
    }
    
    struct Data {
        
        static let data = [
        
            ACMode(id: 0, title: "Auto", imageName: "A"),
            ACMode(id: 1, title: "Dry", imageName: "dry"),
            ACMode(id: 2, title: "Cool", imageName: "cool"),
            ACMode(id: 3, title: "Program", imageName: "program"),
        
        ]
    }
    
    class  ACModeManager : ObservableObject {
        
        @Published var modeData = Data.data
        @Published var selectedIndex = -1
        
        func selectMode(index: Int){
            
            if selectedIndex != index {
                
                modeData[index].selected = true
                
                if selectedIndex != -1 {
                    
                    modeData[selectedIndex].selected = false
                    
                }
                
                selectedIndex = index
            }
        }
    }
    
    struct ModeView: View {
        
        @ObservedObject var modeManager = ACModeManager()
        
        var body: some View {
            
            
            HStack(spacing: 21) {
                
                ForEach(modeManager.modeData) { data in
                    
                    ModeItemView(mode: data)
                        .onTapGesture {
                            withAnimation(.spring()){
                                modeManager.selectMode(index: data.id)
                            }
                        }
                }
                
            }
            
        }
    }
    
    struct ModeItemView : View {
        let mode: ACMode
        var body: some View {
            
            VStack {
                
                Text(mode.title)
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundColor(.buttonTintColor)
                
                Image(mode.imageName)
                    .renderingMode(.template)
                    .foregroundColor(mode.selected ? .white : .gray)
                    .frame(width: 31, height: 31)
                    .padding(22)
                    .background(ACModeBackground(shape: Circle(), isHighlited: mode.selected))
                
            }
        }
    }
    
    struct ACModeBackground<S: Shape> : View {
        
        var shape: S
        var isHighlited : Bool
        
        var body: some View {
            
            ZStack {
                
                if isHighlited {
                    
                    shape
                        .fill(Color.blueButtonBackground)
                        .overlay(
                        
                            shape.stroke(Color.blueButtonBorder, lineWidth: 1.5)
                            
                        )
                        .shadow(color: .black, radius: 10, x: 7, y: 7)
                        .shadow(color: .darkStart, radius: 10, x: -7, y: -7)
                    
                } else {
                    
                    shape.fill(Color.buttonBackground)
                        .overlay(
                        
                            shape.stroke(Color.buttonSelectedEnd, lineWidth: 1.5)
                        )
                        .shadow(color: .black, radius: 10, x: 7, y: 7)
                        .shadow(color: .darkStart, radius: 10, x: -7, y: -7)
                }
                
            }
        }
    }
}
