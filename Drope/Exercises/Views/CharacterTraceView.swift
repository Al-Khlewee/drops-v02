import SwiftUI

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
