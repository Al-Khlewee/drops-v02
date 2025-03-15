//
//  AppSettings.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - AppSettings.swift
import SwiftUI

class AppSettings: ObservableObject {
    @Published var isDarkMode = false
    @Published var currentLanguage = Language.arabic
    
    enum Language: String, CaseIterable, Identifiable {
        case english = "en"
        case arabic = "ar"
        
        var id: String { self.rawValue }
        
        var layoutDirection: LayoutDirection {
            switch self {
            case .arabic:
                return .rightToLeft
            case .english:
                return .leftToRight
            }
        }
        
        var displayName: String {
            switch self {
            case .english: return "English"
            case .arabic: return "العربية"
            }
        }
    }
}