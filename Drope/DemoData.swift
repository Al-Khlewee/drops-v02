//
//  DemoData.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - DemoData.swift
import SwiftUI
import CoreGraphics

struct DemoData {
    static let characters: [ChineseCharacter] = [
        ChineseCharacter(id: "char-da", character: "大", pinyin: "dà", meaning: "big", radicals: ["大"], strokeCount: 3, examples: ["大人 (dàrén - adult)"], difficulty: 1),
        ChineseCharacter(id: "char-ren", character: "人", pinyin: "rén", meaning: "person", radicals: ["人"], strokeCount: 2, examples: ["人民 (rénmín - the people)"], difficulty: 1),
        ChineseCharacter(id: "char-ni", character: "你", pinyin: "nǐ", meaning: "you", radicals: ["亻", "尔"], strokeCount: 7, examples: ["你好 (nǐhǎo - hello)"], difficulty: 1),
         ChineseCharacter(id: "char-hao", character: "好", pinyin: "hǎo", meaning: "good", radicals: ["女", "子"], strokeCount: 6, examples: ["你好 (nǐhǎo - hello)"], difficulty: 1)
    ]

    static let courses: [ChineseCourse] = [
        ChineseCourse(id: "course-travel", title: "Travel Talk", subtitle: "Essential phrases for your trip", lessons: [
            ChineseLesson(id: "lesson-travel-1", title: "Greetings", subtitle: "Learn basic greetings", difficulty: .beginner, type: .conversation, icon: "hand.wave.fill", exercises: [
                MultipleChoiceExercise(id: "ex-greet-1", instructions: "Choose the correct translation for 'Hello':", difficulty: 1, question: "Hello", options: ["你好", "再见", "谢谢", "请"], correctOptionIndex: 0, audioClip: "nihao.mp3"),
                TranslationExercise(id: "ex-greet-2", instructions: "Translate 'Goodbye' to Chinese:", difficulty: 1, textToTranslate: "Goodbye", correctTranslation: "再见", hintWords: ["再", "见"]),
                 MultipleChoiceExercise(id: "ex-greet-3", instructions: "Which character means 'good'?", difficulty: 1, question: "Which character means 'good'?", options: ["大", "人", "你", "好"], correctOptionIndex: 3)
            ]),
            ChineseLesson(id: "lesson-travel-2", title: "Basic Phrases", subtitle: "Asking for directions and help", difficulty: .beginner, type: .vocabulary, icon: "questionmark.circle.fill", exercises: [
                TranslationExercise(id: "ex-basic-1", instructions: "Translate 'Please' to Chinese:", difficulty: 1, textToTranslate: "Please", correctTranslation: "请", hintWords: ["请"]),
                MultipleChoiceExercise(id: "ex-basic-2", instructions: "How do you say 'Thank you' in Chinese?", difficulty: 1, question: "Thank you", options: ["你好", "再见", "谢谢", "请"], correctOptionIndex: 2),
                TranslationExercise(id: "ex-basic-3", instructions: "Translate 'Where is the bathroom?' to Chinese:", difficulty: 2, textToTranslate: "Where is the bathroom?", correctTranslation: "洗手间在哪里？", hintWords: ["洗手间", "在", "哪里", "？"])
            ], requiredXP: 50, isLocked: false) // Example of a locked lesson
        ]),
        ChineseCourse(id: "course-foundation", title: "Foundation", subtitle: "Learn Kangxi Radicals", lessons: [
               ChineseLesson(id: "lesson-kangxi-1", title: "Radicals 1", subtitle: "Learn basic radicals", difficulty: .beginner, type: .characters, icon: "pencil.and.outline", exercises: [
                   CharacterTraceExercise(id: "ex-char-1", instructions: "Trace the character 大 (dà - big):", difficulty: 1, character: "大", strokeOrder: [], pronunciation: "dà", meaning: "big"),
                   MultipleChoiceExercise(id: "ex-char-2", instructions: "What does 人 (rén) mean?", difficulty: 1, question: "人 (rén)", options: ["Big", "Person", "You", "Good"], correctOptionIndex: 1),
                    CharacterTraceExercise(id: "ex-char-3", instructions: "Trace the character 你 (nǐ - you):", difficulty: 1, character: "你", strokeOrder: [], pronunciation: "nǐ", meaning: "you")
               ], requiredXP: 0, isLocked: false)
           ])
    ]
}