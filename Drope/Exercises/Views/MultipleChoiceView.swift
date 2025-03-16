import SwiftUI

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