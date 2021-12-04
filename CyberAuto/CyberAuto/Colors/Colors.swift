//
//  Colors.swift
//  Colors
//
//  Created by Andrej Kling on 05.10.21.
//

import SwiftUI

extension Color {
    
    static let buttonTintColor          = Color.init(red: 127/255, green: 132/255, blue: 137/255)
    static let textPrimary              = Color.init(red: 253/255, green: 253/255, blue: 253/255)
    
    static let darkStart                = Color.init(red: 47/255, green: 53/255, blue: 58/255)
    static let darkEnd                  = Color.init(red: 28/255, green: 31/255, blue: 34/255)
    
    static let darkShadow               = Color.init(red: 31/255, green: 36/255, blue: 39/255)
    static let lightShadow              = Color.init(red: 72/255, green: 80/255, blue: 87/255)

    static let buttonSelectedStart      = Color.init(red: 29/255, green: 35/255, blue: 40/255)
    static let buttonSelectedEnd        = Color.init(red: 19/255, green: 19/255, blue: 20/255)
    
    static let blueButtonBorderStart    = Color.init(red: 17/255, green: 168/255, blue: 253/255)
    static let blueButtonBorderEnd      = Color.init(red: 0/255, green: 94/255, blue: 163/255)
    
    static let backgroundStart          = Color.init(red: 53/255, green: 58/255, blue: 64/255)
    static let backgroundEnd            = Color.init(red: 22/255, green: 23/255, blue: 27/255)
    
    static let backgroundBorderStart    = Color.init(red: 66/255, green: 71/255, blue: 80/255)
    static let backgroundBorderEnd      = Color.init(red: 32/255, green: 35/255, blue: 38/255)
    
    static let blueButtonStart          = Color.init(red: 0/255, green: 94/255, blue: 163/255)
    static let blueButtonEnd            = Color.init(red: 17/255, green: 168/255, blue: 253/255)
    
    static let sliderIndicator          = Color.init(red: 23/255, green: 24/255, blue: 28/255)
    static let sliderIndicatorShadow    = Color.init(red: 83/255, green: 89/255, blue: 96/255)

    static let sliderBackgroundEnd      = Color.init(red: 19/255, green: 19/255, blue: 20/255)
    static let sliderInnerBackground    = Color.init(red: 31/255, green: 33/255, blue: 36/255)
    
    static let sliderTopShadow          = Color.init(red: 72/255, green: 80/255, blue: 87/255)
    static let sliderBottomShadow       = Color.init(red: 20/255, green: 20/255, blue: 21/255)
    
    static let blueIndicaorShadow       = Color.init(red: 10/255, green: 138/255, blue: 218/255)
    static let blueIndicaor             = Color.init(red: 14/255, green: 155/255, blue: 239/255)
    
    static let knobStart                = Color.init(red: 20/255, green: 21/255, blue: 21/255)
    static let knobEnd                  = Color.init(red: 46/255, green: 50/255, blue: 54/255)
    
    static let infoBackground           = Color.init(red: 31/255, green: 35/255, blue: 40/255)
    static let infoShadowTop            = Color.init(red: 16/255, green: 16/255, blue: 18/255)
    static let infoShadowBottom         = Color.init(red: 38/255, green: 46/255, blue: 50/255)
    
    static let onCircle                 = Color.init(red: 1/255, green: 114/255, blue: 190/255)
    static let onCircleShadow           = Color.init(red: 10/255, green: 141/255, blue: 221/255)
    
    static let knobLinear = LinearGradient(
        gradient: Gradient(
            colors: [knobStart,knobEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)

    static let buttonSelectedBackground = LinearGradient(
        gradient: Gradient(
            colors: [buttonSelectedStart,buttonSelectedEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    static let buttonSelectedReverseBackground = LinearGradient(
        gradient: Gradient(
            colors: [buttonSelectedEnd,buttonSelectedStart]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    static let buttonBackground = LinearGradient(
        gradient: Gradient(
            colors: [darkStart,darkEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    static let blueButtonBorder = LinearGradient(
        gradient: Gradient(
            colors: [blueButtonBorderStart,blueButtonBorderEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    static let backgroundColor = LinearGradient(
        gradient: Gradient(
            colors: [backgroundStart, backgroundEnd]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let backgroundBorderColor = LinearGradient(
        gradient: Gradient(
            colors: [backgroundBorderStart, backgroundBorderEnd]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let blueButtonBackground = LinearGradient(
        gradient: Gradient(
            colors: [blueButtonStart, blueButtonEnd]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}
