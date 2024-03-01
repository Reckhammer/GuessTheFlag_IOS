//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Joshua Rechkemmer on 2/29/24.
//

import SwiftUI

struct ContentView: View 
{
    @State private var showingScore = false;
    
    @State private var score = 0;
    @State private var scoreTitle = "";
    @State private var scoreMsg = "";
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled();
    @State var correctAnswer = Int.random(in: 0...2);
    
    var body: some View
    {
        ZStack
        {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.15, green: 0.76, blue: 0.90), location: 0.3)],
                center: .top,
                startRadius: 200, 
                endRadius: 700)
                .ignoresSafeArea();
            
            VStack 
            {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white);
                
                Spacer();
                
                VStack(spacing: 15)
                {
                    VStack
                    {
                        Text("Tap the Flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy));
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold));
                    }
                    
                    ForEach(0..<3)
                    {
                        number in
                        
                        Button
                        {
                            flagTapped(number);
                        }
                    label:
                        {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5);
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer();
                
                Text("\(score)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.semibold));
            }
            .padding();
        }
        .alert(scoreTitle, isPresented: $showingScore)
        {
            Button("Continue", action: askQuestion);
        }
    message:
        {
            Spacer();
            Spacer();
            
            Text(scoreMsg);
            
            Spacer();
        }
    }
    
    func flagTapped(_ number: Int)
    {
        if number == correctAnswer
        {
            scoreTitle = "Correct";
            score += 1;
        }
        else
        {
            scoreTitle = "Wrong";
        }
        
        scoreMsg = "That is the flag of \(countries[number])";
        showingScore = true;
    }
    
    func askQuestion()
    {
        countries.shuffle();
        correctAnswer = Int.random(in: 0...2);
    }
}

#Preview 
{
    ContentView()
}
