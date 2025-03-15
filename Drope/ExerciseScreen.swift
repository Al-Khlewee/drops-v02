//
//  ExerciseScreen.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//


// MARK: - Screens/ExerciseScreen.swift
import SwiftUI

struct ExerciseScreen: View {
    let exercise: Exercise
    @EnvironmentObject var appState: ChineseAppState
    @Environment(\.theme) var theme
    @Environment(\.localization) var localization // Add localization
    @State private var userAnswer: String = ""
    @State private var hasSubmitted = false
    @State private var isCorrect = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let lesson = appState.currentLesson {
                HStack(spacing: 4) {
                    ForEach(0..<lesson.exercises.count, id: \.self) { index in
                        Capsule()
                            .fill(index <= appState.currentExerciseIndex ? theme.accent : theme.textSecondary.opacity(0.3))
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal).padding(.top, 8)
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    Text(exercise.instructions)
                        .font(.headline).foregroundColor(theme.textPrimary).padding().multilineTextAlignment(.center)
                    
                    Group {
                        if let mcExercise = exercise as? MultipleChoiceExercise {
                            MultipleChoiceView(exercise: mcExercise, userAnswer: $userAnswer)
                        } else if let tExercise = exercise as? TranslationExercise {
                            TranslationView(exercise: tExercise, userAnswer: $userAnswer)
                        } else if let ctExercise = exercise as? CharacterTraceExercise {
                            CharacterTraceView(exercise: ctExercise, userAnswer: $userAnswer)  // Pass localization
                        } else {
                            Text("Unsupported exercise type").foregroundColor(theme.textSecondary)
                        }
                    }
                    .padding()
                }
            }
            Spacer()
            
            if hasSubmitted {
                Text(isCorrect ? "Correct! 🎉" : "Try again!").foregroundColor(isCorrect ? .green : .red).font(.headline).padding(.bottom, 8)
            }
            
            VStack(spacing: 12) {
                if hasSubmitted {
                    Button(action: {
                        if isCorrect { appState.nextExercise(); hasSubmitted = false; userAnswer = "" }
                        else { hasSubmitted = false; userAnswer = "" }
                    }) {
                        Text(isCorrect ? "Continue" : "Try Again").font(.headline).foregroundColor(.white)
                            .frame(maxWidth: .infinity).padding().background(theme.highlightPurple).cornerRadius(12)
                    }
                } else {
                    Button(action: { checkAnswer() }) {
                        Text("Check").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding()
                            .background(userAnswer.isEmpty ? theme.textSecondary : theme.highlightPurple).cornerRadius(12)
                    }
                    .disabled(userAnswer.isEmpty)
                }
            }
            .padding(.horizontal).padding(.bottom, 8)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { appState.showingExercise = false }) {
                    Image(systemName: "xmark").foregroundColor(theme.textPrimary)
                }
            }
            ToolbarItem(placement: .principal) {
                if let lesson = appState.currentLesson {
                    Text("Exercise \(appState.currentExerciseIndex + 1)/\(lesson.exercises.count)").font(.headline).foregroundColor(theme.textPrimary)
                }
            }
        }
    }
    
    private func checkAnswer() {
        switch exercise {
        case let mcExercise as MultipleChoiceExercise:
            isCorrect = userAnswer == String(mcExercise.correctOptionIndex)
        case let tExercise as TranslationExercise:
            let normalizedAnswer = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            let normalizedCorrect = tExercise.correctTranslation.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            isCorrect = normalizedAnswer == normalizedCorrect
        case is CharacterTraceExercise:
            isCorrect = !userAnswer.isEmpty // Simplified check for tracing
        default:
            isCorrect = false
        }
        hasSubmitted = true
    }
}

struct MultipleChoiceView: View {
    let exercise: MultipleChoiceExercise
    @Binding var userAnswer: String
    @Environment(\.theme) var theme
    
    var body: some View {
        VStack(spacing: 20) {
            Text(exercise.question).font(.title2).foregroundColor(theme.textPrimary).multilineTextAlignment(.center).padding()
            if exercise.audioClip != nil { /* Audio button */ }
            VStack(spacing: 12) {
                ForEach(0..<exercise.options.count, id: \.self) { index in
                    Button(action: { userAnswer = String(index) }) {
                        HStack {
                            Text(exercise.options[index]).foregroundColor(theme.textPrimary)
                            Spacer()
                            if userAnswer == String(index) { Image(systemName: "checkmark.circle.fill").foregroundColor(theme.accent) }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(userAnswer == String(index) ? theme.accent.opacity(0.2) : theme.cardPurple.opacity(0.3)))
                    }
                }
            }
        }
    }
}

struct TranslationView: View {
    let exercise: TranslationExercise
    @Binding var userAnswer: String
    @Environment(\.theme) var theme
    @State private var selectedHints: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text(exercise.textToTranslate).font(.title).foregroundColor(theme.textPrimary).multilineTextAlignment(.center).padding()
            TextField("Your translation", text: $userAnswer).padding().background(theme.cardPurple.opacity(0.3)).cornerRadius(8)
            Text("Hints").font(.caption).foregroundColor(theme.textSecondary)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(exercise.hintWords, id: \.self) { word in
                        Button(action: {
                            if !selectedHints.contains(word) {
                                selectedHints.append(word)
                                if !userAnswer.isEmpty && !userAnswer.hasSuffix(" ") { userAnswer += " " }
                                userAnswer += word
                            }
                        }) {
                            Text(word).foregroundColor(selectedHints.contains(word) ? theme.textSecondary : theme.textPrimary)
                                .padding(.horizontal, 12).padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 16).fill(selectedHints.contains(word) ? theme.textSecondary.opacity(0.3) : theme.cardPurple.opacity(0.5)))
                        }
                    }
                }
            }
        }
    }
}

struct CharacterTraceView: View {
    let exercise: CharacterTraceExercise
    @Binding var userAnswer: String // Keep this for the simplified check
    @Environment(\.theme) var theme

    var body: some View {
        VStack(spacing: 20) {
            Text(exercise.character)
                .font(.system(size: 100))
                .foregroundColor(theme.textPrimary.opacity(0.5))

            HStack(spacing: 20) {
                VStack {
                    Text("Pinyin").font(.caption).foregroundColor(theme.textSecondary)
                    Text(exercise.pronunciation).font(.headline).foregroundColor(theme.textPrimary)
                }
                VStack {
                    Text("Meaning").font(.caption).foregroundColor(theme.textSecondary)
                    Text(exercise.meaning).font(.headline).foregroundColor(theme.textPrimary)
                }
            }

            // Simplified drawing area
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(theme.textSecondary, lineWidth: 2)
                    .background(theme.cardPurple.opacity(0.1))
                    .cornerRadius(12)
                Text("Tracing area (Tap to mark as traced)") // Instructions
                    .foregroundColor(theme.textSecondary)
            }
            .frame(height: 200)
            .padding()
            .onTapGesture {
                userAnswer = "traced" // Mark as traced on tap
            }

            // Simplified controls (Clear button only)
            HStack {
                Button(action: {
                    userAnswer = "" // Clear the "traced" status
                }) {
                    Text("Clear")
                        .foregroundColor(theme.textPrimary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(theme.cardPurple.opacity(0.3))
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
