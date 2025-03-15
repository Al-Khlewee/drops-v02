// MARK: - ChineseAppState.swift
import SwiftUI

class ChineseAppState: ObservableObject {
    @Published var userProgress = UserProgress()
    @Published var selectedTab = 0
    @Published var currentLanguage: AppSettings.Language = .english
    @Published var currentCourse: ChineseCourse?
    @Published var currentLesson: ChineseLesson?
    @Published var currentExerciseIndex = 0
    @Published var showingExercise = false
    
    let availableCourses = DemoData.courses  // Load demo data
    
    func startLesson(_ lesson: ChineseLesson) {
        if !lesson.isLocked {
            currentLesson = lesson
            currentExerciseIndex = 0
            showingExercise = true
        }
    }
    
    func nextExercise() {
        guard let lesson = currentLesson else { return }
        if currentExerciseIndex < lesson.exercises.count - 1 { currentExerciseIndex += 1 }
        else { completeCurrentLesson() }
    }
    
    func completeCurrentLesson() {
        guard let lesson = currentLesson else { return }
        userProgress.completeLesson(id: lesson.id)
        showingExercise = false; currentLesson = nil; currentExerciseIndex = 0
        saveUserProgress() // Call save here
    }

    func saveUserProgress() {
         // Basic UserDefaults example.  Handles encoding/decoding.
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(userProgress) {
             UserDefaults.standard.set(encoded, forKey: "userProgress")
         }
     }

     func loadUserProgress() {
         // Basic UserDefaults example
         if let savedProgress = UserDefaults.standard.object(forKey: "userProgress") as? Data {
             let decoder = JSONDecoder()
             if let loadedProgress = try? decoder.decode(UserProgress.self, from: savedProgress) {
                 userProgress = loadedProgress
             }
         }
     }
}
