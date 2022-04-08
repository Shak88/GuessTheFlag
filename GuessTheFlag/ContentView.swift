//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shokri Alnajjar on 05/04/2022.
//

import SwiftUI

struct FlagImage : View {
    var name : String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France","Germany", "Ireland", "Italy", "Nigeria", "Poland",
                                    "Russia", "Spain", "UK", "US"].shuffled()
    
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreValue = 0
    @State private var flagSelected = ""
    @State private var shouldRestart = false
    @State private var roundsCount = 0
     
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                        
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3 ) { number in
                        Button {
                            //flagTapped is a method defined below
                            flagTapped(number)
                        } label: {
                            //this is new View created at the top of th
                            FlagImage(name: countries[number])
                                                        }
                        
                    }
                }
                .frame(maxWidth : .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                Text("Score : \(scoreValue)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }message : {
            if scoreTitle == "Wrong" {
                Text("Wrong this is the flag of \(flagSelected)")
            }
            Text("Your Score is \(scoreValue)")
        }
        
        .alert("Thank you for playing", isPresented: $shouldRestart){
            Button("Restart", action: restartGame)
        }message : {
            Text("Game is finished and score will be restarted")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong"
            flagSelected = countries[number]
        }
        
        showingScore = true
        
        roundsCount += 1
        if roundsCount == 8 {
            roundsCount = 0
            shouldRestart = true
        }
    }
    
    func restartGame() {
        scoreValue = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
