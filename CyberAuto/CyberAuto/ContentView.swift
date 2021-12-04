//
//  ContentView.swift
//  CyberAuto
//
//  Created by Andrej Kling on 05.10.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.backgroundColor.ignoresSafeArea()
                
                WelcomeView()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeView : View {
    
    @State private var selection : Int? = nil
    @State private var toggleStatus = false
    
    var body: some View{
        
        VStack {
            
            HStack{
                
                Spacer()
                
                NavigationLink(
                    destination: DashboardView()
                        .navigationTitle("")
                        .navigationBarHidden(true),
                    tag: 1,
                    selection: $selection,
                    label: {
                        Button(action: {
                            self.selection = 1
                        }, label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 21, weight: .regular, design: .serif))
                        })
                            .buttonStyle(DarkButtonStyle())
                    })
            }
            .padding(.top,  getRect().height < 750 ? 38 : 0 )
            .padding(.trailing, 24)
            
            
            Group {
                
                Text("Tesla")
                    .kerning(1.8)
                    .font(.system(size: 33, weight: .regular, design: .serif))
                    .foregroundColor(.buttonTintColor)
                
                Text("Cybertruck")
                    .kerning(5.5)
                    .font(.system(size: getRect().height < 750 ? 35 : 45, weight: .black, design: .serif))
                    .foregroundColor(Color.textPrimary)
            }
            .shadow(color: .darkShadow, radius: 10, x: 7, y: 7)
            .shadow(color: .lightShadow, radius: 10, x: -7, y: -7)
            
            ZStack(alignment: .topLeading) {
                
                HStack(alignment: .top) {
                    
                    Text("297")
                       // .kerning(3.5)
                        .font(.system(size: 175, weight: .ultraLight))
                        .foregroundColor(Color.textPrimary)
                    
                    Text("km")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color.textPrimary)
                }
                .shadow(color: .darkShadow, radius: 10, x: 7, y: 7)
                .shadow(color: .lightShadow, radius: 10, x: -7, y: -7)
            
                if getRect().height < 750 {
                    
                    Image("cyber_truck")
                        .resizable()
                       .frame(maxWidth: .infinity)
                        .frame(height: 227)
                        .padding(.top, 101)
                        .shadow(color: .lightShadow, radius: 18, x: -7, y: -7)
                } else {
                    
                    Image("cyber_truck")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 91)
                        .shadow(color: .lightShadow, radius: 18, x: -7, y: -7)
                    
                }

            }
            
            Group {
                
                Text( toggleStatus ? "A/C is turned on" : "A/C is turned off")
                    .font(.system(size: 24, weight: .ultraLight, design: .monospaced))
                    .foregroundColor(.buttonTintColor)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.4), radius: 5, x: -5, y: -5)
                    .blur(radius: 0.1)
                
                Toggle(isOn: $toggleStatus, label: {
                    Image(systemName: toggleStatus ? "lock.open" : "lock")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                })
                    .toggleStyle(CustomToggleStyle(diametr: 75))
                
                Text(toggleStatus ? "Car is open" : "Open the car" )
                    .font(.footnote)
                    .foregroundColor(.textPrimary).opacity(0.7)
                    .padding(.bottom,  getRect().height < 750 ? 55 : 33 )
            }
        }
    }
}
 
struct  CustomToggleStyle : ToggleStyle {
    
    var diametr : CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            
            Circle()
                .fill(configuration.isOn ?
                
                        Color.buttonSelectedReverseBackground :
                        Color.blueButtonBackground
                )
                .overlay(
                    Circle()
                        .strokeBorder(configuration.isOn ?
                               
                                        Color.buttonSelectedBackground :
                                        Color.blueButtonBorder ,
                                      lineWidth: 4
                                     )
                )
                .shadow(color: .black, radius: diametr == 75 ? 40 : 20, x: 10, y: 15)
              //  .shadow(color: .darkStart, radius: diametr == 95 ? 40 : 20, x: -10, y: -15)
                .frame(width: diametr, height: diametr)
            
            configuration.label
                .foregroundColor(.white)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

extension View {
    
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}
    
struct DarkButtonStyle : ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.buttonTintColor)
            .padding( getRect().height < 750 ? 15 : 21)
            .contentShape(Circle())
            .background(DarkButtonBackground(shape: Circle(), isHighlighted: configuration.isPressed))
        
    }
    func getRect() -> CGRect {
        
        return UIScreen.main.bounds
    }
}

struct DarkButtonBackground<S: Shape> : View {
    
    var shape : S
    var isHighlighted : Bool
    
    var body: some View {
        
        ZStack {
            
            if isHighlighted {
                
                shape
                    .fill(Color.darkStart)
                    .shadow(color: .darkShadow, radius: 10, x: 7, y: 7)
                    .shadow(color: .lightShadow, radius: 10, x: -7, y: -7)
                
            } else {
                
                shape
                    .fill(Color.buttonBackground)
                    .shadow(color: .darkShadow, radius: 10, x: 7, y: 7)
                    .shadow(color: .lightShadow, radius: 10, x: -7, y: -7)
                
            }
        }
    }
}
 
 
