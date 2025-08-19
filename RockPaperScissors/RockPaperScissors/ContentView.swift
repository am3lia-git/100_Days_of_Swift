//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Amelia Riddell on 8/19/25.
//

import SwiftUI

struct resetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct ContentView: View {
    @State var options = ["🪨", "📄", "✂️"]
    @State var playerScore = 0
    @State var computerScore = 0
    @State var roundNumber = 1
    @State var computerChoice = Int.random(in: 0...2)
    @State var playerChoice: Int?
    @State var alertText = ""
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .white],
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
            VStack {
                Text("Round \(roundNumber)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                VStack {
                    Text("You: \(playerScore) \t Computer: \(computerScore)")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                    VStack(spacing: 20) {
                        ForEach(0..<3){ number in
                            Button{
                                playerChoice = number
                                optionPicked(number)
                            } label:{
                                Text("\(options[number])")
                                    .font(.system(size: 140, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    
                            }
                        }
                    }.frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20)).padding()
                    Spacer()
                    Button("Reset Game"){
                        resetGame()
                    }.buttonStyle(resetButtonStyle())
                    
                    
                }
                
            }
            
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("\(alertText)"),
                  message: Text("Computer chose \(options[computerChoice]) \n Player chose \(options[playerChoice ?? 0])"),
                  dismissButton: .default(Text("OK")){
                roundNumber += 1
                computerChoice = Int.random(in: 0...2)
            }
                  
            )
            
        }
        
    }
    func optionPicked(_ number: Int) {
        let playerChoice = number
        let compChoice = computerChoice
            
        if playerChoice == compChoice {
            alertText = "It's a tie!"
        } else if (playerChoice == 0 && compChoice == 2) || // Rock beats Scissors
                (playerChoice == 1 && compChoice == 0) || // Paper beats Rock
                (playerChoice == 2 && compChoice == 1) {  // Scissors beats Paper
            playerScore += 1
            alertText = "You win!"
        } else {
            computerScore += 1
            alertText = "You lose!"
        }
            
        // advance to next round
        showAlert = true
    }
    func resetGame() {
        playerScore = 0
        computerScore = 0
        roundNumber = 1
        computerChoice = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
