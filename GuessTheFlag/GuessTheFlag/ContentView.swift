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
    @State private var scoreTitle = "";
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled();
    @State var correctAnswer = Int.random(in: 0...2);
    
    var body: some View
    {
        ZStack
        {
            LinearGradient(colors: [.indigo, .teal], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea();
            
            VStack(spacing: 30)
            {
                VStack
                {
                    Text("Tap the Flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy));
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
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
        }
        .alert(scoreTitle, isPresented: $showingScore)
        {
            Button("Continue", action: askQuestion);
        }
    message:
        {
            Text("Your score is ???");
        }
    }
    
    func flagTapped(_ number: Int)
    {
        if number == correctAnswer
        {
            scoreTitle = "Correct";
        }
        else
        {
            scoreTitle = "Wrong";
        }
        
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
