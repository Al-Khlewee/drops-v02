//
//  ChineseLanguageApp.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - Screens/ChineseLanguageApp.swift
import SwiftUI

struct ChineseLanguageApp: View {
    @StateObject private var appState = ChineseAppState()

    var body: some View {
        let theme = ThemeKey.defaultValue // Use system color scheme
        let localization = LocalizationManager(language: appState.currentLanguage)

        NavigationView {
            TabView(selection: $appState.selectedTab) {
                LessonsScreen()
                    .tabItem { Image(systemName: "list.bullet"); Text(localization.localized("topics")) }
                    .tag(0)
                    .sheet(isPresented: $appState.showingExercise) {
                        if let lesson = appState.currentLesson, lesson.exercises.indices.contains(appState.currentExerciseIndex) {
                            ExerciseScreen(exercise: lesson.exercises[appState.currentExerciseIndex])
                        }
                    }
                DictionaryScreen()
                    .tabItem { Image(systemName: "book.fill"); Text(localization.localized("dictionary")) }
                    .tag(1)
                CharactersScreen()
                    .tabItem { Image(systemName: "square.grid.2x2"); Text(localization.localized("characters")) }
                    .tag(2)
                ProfileScreen()
                    .tabItem { Image(systemName: "person.crop.circle"); Text(localization.localized("profile")) }
                    .tag(3)
            }
            .accentColor(theme.highlightPurple)
            .environmentObject(appState)
            .environment(\.theme, theme)
            .environment(\.localization, localization)
            .environment(\.layoutDirection, appState.currentLanguage.layoutDirection)
        }.onAppear{
            appState.loadUserProgress()
        }
    }
}