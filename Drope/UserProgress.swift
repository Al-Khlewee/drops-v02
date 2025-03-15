//
//  UserProgress.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - Models.swift
import SwiftUI
import CoreGraphics

struct UserProgress: Codable {
    var completedLessons: Set<String> = []
    var wordsLearned: Int = 0
    var currentStreak: Int = 0
    var lastCompletedDate: Date?
    var xpPoints: Int = 0
    
    mutating func completeLesson(id: String, xpEarned: Int = 10) {
        completedLessons.insert(id)
        xpPoints += xpEarned
        let calendar = Calendar.current
        let today = Date()
        if let lastDate = lastCompletedDate, calendar.isDate(lastDate, inSameDayAs: today) {}
        else if let lastDate = lastCompletedDate, calendar.isDateInYesterday(lastDate) { currentStreak += 1 }
        else { currentStreak = 1 }
        lastCompletedDate = today
    }
}

struct ChineseLesson: Identifiable {
    var id: String
    var title: String
    var subtitle: String
    var difficulty: LessonDifficulty
    var type: LessonType
    var icon: String
    var exercises: [Exercise]
    var requiredXP: Int = 0
    var isLocked: Bool = false
    
    enum LessonDifficulty: String, Codable { case beginner, intermediate, advanced }
    enum LessonType: String, Codable { case vocabulary, grammar, conversation, characters, culture }
}

protocol Exercise {
    var id: String { get }
    var instructions: String { get }
    var difficulty: Int { get }
}

struct MultipleChoiceExercise: Exercise {
    var id: String;  var instructions: String; var difficulty: Int
    var question: String; var options: [String]; var correctOptionIndex: Int
    var audioClip: String?
}

struct TranslationExercise: Exercise {
    var id: String; var instructions: String; var difficulty: Int
    var textToTranslate: String; var correctTranslation: String; var hintWords: [String]
}

struct CharacterTraceExercise: Exercise { // Simplified
    var id: String; var instructions: String; var difficulty: Int
    var character: String; var strokeOrder: [CGPath]; var pronunciation: String; var meaning: String
}

struct ChineseCharacter: Identifiable {
    var id: String; var character: String; var pinyin: String; var meaning: String
    var radicals: [String]; var strokeCount: Int; var strokeOrder: [CGPath] = []
    var examples: [String]; var difficulty: Int
}

struct ChineseCourse: Identifiable {
    var id: String;  var title: String; var subtitle: String; var lessons: [ChineseLesson]
}