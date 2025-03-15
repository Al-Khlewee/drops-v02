//
//  DictionaryScreen.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - Screens/OtherScreens.swift
import SwiftUI

struct DictionaryScreen: View {
    @Environment(\.theme) var theme
    var body: some View {
        VStack { Text("Dictionary").font(.largeTitle).foregroundColor(theme.textPrimary)
            Text("Search for Chinese characters and words").foregroundColor(theme.textSecondary) }
    }
}

struct CharactersScreen: View {
    @Environment(\.theme) var theme
    var body: some View {
        VStack { Text("Character Library").font(.largeTitle).foregroundColor(theme.textPrimary)
            Text("Browse and practice Chinese characters").foregroundColor(theme.textSecondary) }
    }
}

struct ProfileScreen: View {
    @Environment(\.theme) var theme
    @EnvironmentObject var appState: ChineseAppState
    var body: some View {
        VStack(spacing: 20) {
            Text("Your Profile").font(.largeTitle).foregroundColor(theme.textPrimary)
            VStack(spacing: 8) {
                Text("Streak: \(appState.userProgress.currentStreak) days").foregroundColor(theme.textPrimary)
                Text("XP Points: \(appState.userProgress.xpPoints)").foregroundColor(theme.textPrimary)
                Text("Words Learned: \(appState.userProgress.wordsLearned)").foregroundColor(theme.textPrimary)
            }
            .padding().background(theme.cardPurple.opacity(0.3)).cornerRadius(12)
        }
    }
}