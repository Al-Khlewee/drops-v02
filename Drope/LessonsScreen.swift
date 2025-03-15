// MARK: - Screens/LessonsScreen.swift
import SwiftUI

struct LessonsScreen: View {
    @EnvironmentObject var appState: ChineseAppState
    @Environment(\.theme) var theme
    @Environment(\.localization) var localization
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(appState.userProgress.currentStreak) Day Streak").font(.headline).foregroundColor(theme.textPrimary)
                        Text("\(appState.userProgress.wordsLearned) Words Learned").font(.subheadline).foregroundColor(theme.textSecondary)
                    }
                    Spacer()
                    HStack {
                        Text("\(appState.userProgress.xpPoints) XP").font(.headline).foregroundColor(theme.textPrimary)
                        Image(systemName: "flame.fill").foregroundColor(theme.accent)
                    }
                }
                .padding().background(theme.cardPurple.opacity(0.3)).cornerRadius(12)
                
                ForEach(appState.availableCourses) { course in
                    CourseSectionView(course: course)
                }
            }
            .padding()
        }
        .navigationTitle("Learn Chinese")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { appState.currentLanguage = appState.currentLanguage == .english ? .arabic : .english }) {
                    Text(appState.currentLanguage == .english ? "AR" : "EN")
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(theme.highlightPurple.opacity(0.5)).cornerRadius(8)
                }
            }
        }
    }
}

struct CourseSectionView: View {
    let course: ChineseCourse
    @EnvironmentObject var appState: ChineseAppState
    @Environment(\.theme) var theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(course.title).font(.title2).fontWeight(.bold).foregroundColor(theme.textPrimary)
            Text(course.subtitle).font(.subheadline).foregroundColor(theme.textSecondary)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(course.lessons) { lesson in
                        Button(action: { appState.startLesson(lesson) }) {
                            LessonCard(lesson: lesson)
                        }
                    }
                    if course.lessons.isEmpty { ForEach(1...3, id: \.self) { _ in LessonCardPlaceholder() } }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct LessonCard: View {
    let lesson: ChineseLesson
    @Environment(\.theme) var theme
    @EnvironmentObject var appState: ChineseAppState
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(lesson.isLocked ? theme.cardPurple.opacity(0.3) : theme.cardPurple)
                .frame(width: 180, height: 180)
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(lesson.title).font(.headline).foregroundColor(theme.textPrimary).lineLimit(2)
                    Text(lesson.type.rawValue.capitalized).font(.caption).foregroundColor(theme.textSecondary)
                }
                Spacer()
                Image(systemName: lesson.icon).font(.system(size: 50)).foregroundColor(theme.textPrimary.opacity(0.2))
                HStack {
                    if lesson.isLocked {
                        Image(systemName: "lock.fill").foregroundColor(theme.textSecondary)
                        Text("\(lesson.requiredXP) XP needed").font(.caption).foregroundColor(theme.textSecondary)
                    } else {
                        let isStarted = appState.userProgress.completedLessons.contains(lesson.id)
                        if isStarted { Capsule().frame(width: 40, height: 8).foregroundColor(theme.accent) }
                        else { Text("New").font(.caption).foregroundColor(theme.accent).padding(.horizontal, 8).padding(.vertical, 2).background(theme.accent.opacity(0.2)).cornerRadius(4) }
                    }
                    Spacer()
                    Button(action: {}) { Image(systemName: "info.circle").foregroundColor(theme.textSecondary) }
                }
            }
            .padding().frame(width: 180, height: 180, alignment: .leading)
        }
    }
}

struct LessonCardPlaceholder: View {
    @Environment(\.theme) var theme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(theme.cardPurple.opacity(0.3)).frame(width: 180, height: 180)
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 4).fill(theme.textSecondary.opacity(0.3)).frame(height: 16).padding(.horizontal)
                RoundedRectangle(cornerRadius: 4).fill(theme.textSecondary.opacity(0.3)).frame(height: 12).padding(.horizontal)
                Spacer()
                Circle().fill(theme.textSecondary.opacity(0.3)).frame(width: 50, height: 50)
            }
            .padding()
        }
    }
}
