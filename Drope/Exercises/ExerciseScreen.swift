import SwiftUI

struct ExerciseScreen: View {
    let exercise: Exercise
    @EnvironmentObject var appState: ChineseAppState
    @Environment(\.theme) var theme
    @Environment(\.localization) var localization
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

struct ExerciseContentView: View {
    let exercise: Exercise
    @Binding var userAnswer: String
    
    var body: some View {
        Group {
            if let mcExercise = exercise as? MultipleChoiceExercise {
                MultipleChoiceView(exercise: mcExercise, userAnswer: $userAnswer)
            } else if let tExercise = exercise as? TranslationExercise {
                TranslationView(exercise: tExercise, userAnswer: $userAnswer)
            } else if let ctExercise = exercise as? CharacterTraceExercise {
                CharacterTraceView(exercise: ctExercise, userAnswer: $userAnswer)
            } else {
                Text("Unsupported exercise type")
            }
        }
    }
}
