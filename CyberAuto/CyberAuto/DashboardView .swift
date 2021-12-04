//
//  DashboardView .swift
//  DashboardView 
//
//  Created by Andrej Kling on 06.10.21.
//

import SwiftUI

struct DashboardView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectionSecondView : Int? = nil
  
    var body: some View {
        
       NavigationView {
            ZStack {
                
                Color.backgroundColor.ignoresSafeArea()
                
                VStack {
                    
                    topView()
                    
                    Image("cyber_tuck_4")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .shadow(color: .lightShadow, radius: 21, x: -4, y: 5)
                    
                    status()
                    
                    info()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
      
            DashboardView()
     
    }
}

extension  DashboardView {
    
    @ViewBuilder
    func topView() -> some View {
        
        HStack {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("menu")
                    .font(.system(size: 18, weight: .regular, design: .serif))
            })
                .buttonStyle(DarkButtonStyle())
            
            Spacer(minLength: 0)
            
            VStack {
                
                Text("Tesla")
                    .kerning(3.3)
                    .font(.system(size: 21, weight: .black, design: .serif))
                    .foregroundColor(.buttonTintColor)
                
                Text("Cybertruck")
                    .kerning(5.3)
                    .font(.system(size: 24, weight: .black, design: .serif))
                    .foregroundColor(.textPrimary)
                
            }
            .padding(.top, 33)
            .shadow(color: .darkShadow, radius: 10, x: 7, y: 7)
            .shadow(color: .lightShadow, radius: 10, x: -7, y: -7)
            .blur(radius: 0.1)
            
            Spacer(minLength: 0)
            
            
            NavigationLink(destination: ControlView( )
                           .navigationTitle("")
                           .navigationBarHidden(true),
                           tag: 2,
                           selection: $selectionSecondView,
                           label: {
                
                
                Button(action: {
                    self.selectionSecondView = 2
                }, label: {
                    Image(systemName: "bolt.car")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                })
                    .buttonStyle(DarkButtonStyle())
                
            })
        }
        .padding(.horizontal)
       // Spacer()
    }
    
    @ViewBuilder
    func status() -> some View {
        
        VStack {
            
            Text("Status")
                .kerning(2.3)
                .font(.system(size: 18, weight: .heavy, design: .serif))
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            HStack(alignment: .top, spacing: 42.0) {
                
                statusItem(title: "Battery", image: "battery", value: "55%")
                
                statusItem(title: "Range", image: "range", value: "297 km")
                
                statusItem(title: "Temperature", image: "temerature", value: "27°C")
            }
        }
    }
    
    struct statusItem :View {
        
        var title : String
        var image : String
        var value : String
        
        var body: some View {
            
            VStack {
                
                Label(title, image: image)
                 .font(.system(size: 18, weight: .regular, design: .serif))
                 .foregroundColor(.buttonTintColor)
                
                Text(value)
                 .font(.system(size: 18, weight: .regular, design: .serif))
                 .foregroundColor(.textPrimary)
            }
        }
    }
    
    @ViewBuilder
    func info() -> some View {
        
        VStack  {
            
            Text("Information")
                .kerning(2.3)
                .font(.system(size: 18, weight: .heavy, design: .serif))
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    
                    InfoItem(title: "Engine", image: "circle", value: "Sleeping mode", isOn: false)
                    
                    InfoItem(title: "Climate", image: "rectangle", value: "A/C is on", isOn: true)
                    
                    InfoItem(title: "Tire", image: "triangle_1", value: "Low pressure", isOn: true)
                }
                .padding()
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 5, y: 5)
            }
        }
        .padding(.top, 24)
    }
    
    struct InfoItem : View {
        
        var title : String
        var image : String
        var value : String
        var isOn : Bool
        
        var body: some View {
            
            
            VStack {
                
                Image(image)
                    .resizable()
                    .shadow(color: Color.white.opacity(0.15), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.15), radius: 5, x: -5, y: -5)
                    .overlay(
                        VStack(alignment: .leading) {
                            Circle()
                                .fill(Color.onCircle)
                                .frame(width: 8, height: 8)
                                .opacity(isOn ? 1 : 0)
                            
                            Spacer().frame(height: 95)
                            
                            VStack(alignment: .leading,spacing: 5) {
                                
                                Text(title)
                                    .font(.system(size: 18, weight: .regular, design: .serif))
                                .foregroundColor(.textPrimary)
                                
                                Text(value)
                                    .font(.system(size: 18, weight: .regular, design: .serif))
                                    .foregroundColor(.buttonTintColor)
                            }
                        }
                            .padding(.leading, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                         
                    )
                
                
            }
            .frame(width: 150, height: 180)
            .background(Color.infoBackground)
            .cornerRadius(12)
        }
    }
}
