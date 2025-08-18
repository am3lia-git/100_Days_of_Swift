//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Amelia Riddell on 8/13/25.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body : some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var currentQuestion = 0
    @State private var showingReset = false
    @State private var alertText = ""


    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                       .font(.largeTitle.weight(.bold))
                       .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        }label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(alertText) Your score is \(score).")
            
        }
        .alert("Game over", isPresented: $showingReset){
            Button("Reset game", action: resetGame)
        } message:{
            Text("Your final score was \(score)")
        }
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            alertText = ""
        } else {
            scoreTitle = "Wrong"
            score -= 1
            alertText = "Wrong! That's the flag of \(countries[number]). \n"
        }

        showingScore = true
    }
    func askQuestion() {
        if currentQuestion == 8{
            showingReset = true
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentQuestion += 1
    }
    func resetGame() {
        score = 0
        currentQuestion = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
