//
//  ContentView.swift
//  mancala
//
//  Created by User03 on 2023/6/8.
//

import SwiftUI

struct ContentView: View {
    @State private var stone = [4,4,4,4,4,4,0,
                                4,4,4,4,4,4,0]
    @State private var havingStone = [true,true,true,true,true,true,false,
                                      true,true,true,true,true,true,false]
    @State private var isGameover = false
    @State private var playerTurn = 1
    @State private var ShowAIView = false
    @State private var ShowPlayView = false
    @State private var ShowHowView = false
    @State private var ShowMenu = false
    @State private var winner = 3
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 910, height: 420, alignment: .center)
                .fixedSize()
                .frame(width: 420, height: 910, alignment: .center)
            HStack(alignment: .center, spacing: 50){
                HStack(alignment: .center, spacing: 0){
                    Button{
                        ShowHowView = true
                    }label:{
                        Text("How to play")
                            .font(.title3)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(40)
                            .foregroundColor(Color.yellow)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                            .rotationEffect(.degrees(90))
                            .fixedSize()
                            .frame(width: 80, height:180, alignment: .center)
                        
                    }.fullScreenCover(isPresented: $ShowHowView){
                        HowView(ShowMenu: $ShowMenu)
                    }
                    
                    VStack(alignment: .center, spacing: 0){
                        Button{
                            ShowAIView = true
                        }label:{
                            Text("VS Computer")
                                .font(.title3)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(40)
                                .foregroundColor(Color.yellow)
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.black, lineWidth: 5)
                                )
                                .rotationEffect(.degrees(90))
                                .fixedSize()
                                .frame(width: 80, height:180, alignment: .center)
                        }.fullScreenCover(isPresented: $ShowAIView){
                            AIView(stone: $stone , havingStone: $havingStone , isGameover: $isGameover , playerTurn: $playerTurn,ShowMenu: $ShowMenu,winner: $winner)
                        }
                        
                        Button{
                            ShowPlayView = true
                        }label:{
                            Text("VS Human")
                                .font(.title3)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(40)
                                .foregroundColor(Color.yellow)
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.black, lineWidth: 5)
                                )
                                .rotationEffect(.degrees(90))
                                .fixedSize()
                                .frame(width: 80, height:160, alignment: .center)
                        }.fullScreenCover(isPresented: $ShowPlayView){
                            playView(stone: $stone , havingStone: $havingStone , isGameover: $isGameover , playerTurn: $playerTurn,ShowMenu: $ShowMenu,winner: $winner)
                        }
                    }
                }
                
                Image("Title")
                    .resizable()
                    .frame(width: 700, height: 150, alignment: .center)
                    .fixedSize()
                    .frame(width: 100, height: 700, alignment: .center)
                    .rotationEffect(.degrees(90))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
