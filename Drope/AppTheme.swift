//
//  AppTheme.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - AppTheme.swift
import SwiftUI

struct AppTheme {
    let primaryPurple: Color
    let deepPurple: Color
    let lightPurple: Color
    let highlightPurple: Color
    let cardPurple: Color
    let background: Color
    let textPrimary: Color
    let textSecondary: Color
    let accent: Color
    
    static let light = AppTheme(
        primaryPurple: Color(red: 0.3, green: 0.1, blue: 0.5),
        deepPurple: Color(red: 0.2, green: 0.05, blue: 0.4),
        lightPurple: Color(red: 0.55, green: 0.35, blue: 0.7),
        highlightPurple: Color(red: 0.6, green: 0.2, blue: 0.9),
        cardPurple: Color(red: 0.5, green: 0.3, blue: 0.65),
        background: .white,
        textPrimary: .black,
        textSecondary: .gray,
        accent: .yellow
    )
    
    static let dark = AppTheme(
        primaryPurple: Color(red: 0.2, green: 0.05, blue: 0.35),
        deepPurple: Color(red: 0.12, green: 0.03, blue: 0.25),
        lightPurple: Color(red: 0.4, green: 0.25, blue: 0.55),
        highlightPurple: Color(red: 0.5, green: 0.15, blue: 0.8),
        cardPurple: Color(red: 0.35, green: 0.2, blue: 0.5),
        background: Color(red: 0.1, green: 0.1, blue: 0.15),
        textPrimary: .white,
        textSecondary: Color.gray.opacity(0.7),
        accent: .orange
    )
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme.light
}

struct LocalizationKey: EnvironmentKey {
    static let defaultValue = LocalizationManager(language: .english)
}

extension EnvironmentValues {
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
    
    var localization: LocalizationManager {
        get { self[LocalizationKey.self] }
        set { self[LocalizationKey.self] = newValue }
    }
}
