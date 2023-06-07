//
//  AIView.swift
//  mancala
//
//  Created by User03 on 2023/6/8.
//

import SwiftUI
import AVFoundation


struct AIView: View {
    @Binding var stone: [Int]
    @Binding var havingStone: [Bool]
    @Binding var isGameover: Bool
    @Binding var playerTurn: Int
    @Binding var ShowMenu: Bool
    @Binding var winner: Int
    @State private var whoIsWinner = ["P1 WIN!!! ","AI WIN!!! ","TIE ",""]
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 910, height: 420, alignment: .center)
                .fixedSize()
                .frame(width: 420, height: 910, alignment: .center)
            HStack(alignment: .center, spacing: 20){
                VStack(alignment: .center, spacing: 0){
                    Text("\(whoIsWinner[winner])")
                        .font(.title)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20)
                        .foregroundColor(Color.yellow)
                    
                        .rotationEffect(.degrees(90))
                        .fixedSize()
                        .frame(width: 80, height:180, alignment: .center)
                        .opacity(isGameover ? 1: 0)
                    Button{
                        stone = [4,4,4,4,4,4,0,4,4,4,4,4,4,0]
                        havingStone = [true,true,true,true,true,true,false,true,true,true,true,true,true,false]
                        isGameover = false
                        playerTurn = 1
                        ShowMenu = false
                        winner = 3
                    }label: {
                        Text("Restart")
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
                    }.fullScreenCover(isPresented: $ShowMenu){
                        ContentView()
                    }
                    Button{
                        ShowMenu = true
                    }label: {
                        Text("Back to menu")
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
                    }.fullScreenCover(isPresented: $ShowMenu){
                        ContentView()
                    }
                }
                ZStack{
                    Image("mancala")
                        .resizable()
                        .rotationEffect(.degrees(90))
                        .frame(width: 650, height: 195, alignment: .center)
                        .fixedSize()
                        .frame(width: 195, height: 650, alignment: .center)
                    VStack(alignment: .center, spacing: 20){
                        Pill(stone: $stone[13],player: 2)
                        HStack(alignment: .center, spacing: 41){
                            AIcircleArray(stone: $stone,havingStone: $havingStone,isGameover: $isGameover,playerTurn: $playerTurn,winner: $winner)
                            AIcircleArray2(stone: $stone,havingStone: $havingStone,isGameover: $isGameover,playerTurn: $playerTurn,winner: $winner)
                        }
                        Pill(stone: $stone[6],player: 0)
                    }
                }
            }
        }
    }
}

struct AIcircleArray: View {
    @Binding var stone: [Int]
    @Binding var havingStone: [Bool]
    @Binding var isGameover: Bool
    @Binding var playerTurn: Int
    @Binding var winner: Int
    
    var ButtonPlayer: AVPlayer { AVPlayer.sharedButtonPlayer }
    
    var body: some View {
        VStack(alignment: .center, spacing: 26){
            ForEach(0...5, id: \.self){ i in
                Button{
                    if(stone[i] != 0 && playerTurn == 1 ){
                        ButtonPlayer.playFromStart()
                        let temp = stone[i]
                        
                        if(stone[(i+temp)%14] == 0 && stone[12-(i+temp)%14] != 0  && (i+temp)%14 < 6){
                            stone[6] += stone[12-(i+temp)%14] + 1
                            stone[(i+temp)%14] = -1
                            stone[12-(i+temp)%14] = 0
                            havingStone[12-(i+temp)%14] = false
                        }
                        
                        for j in 1...temp{
                            stone[(i+j)%14] += 1
                            if(stone[(i+j)%14] != 0){
                                havingStone[(i+j)%14] = true
                            }
                        }
                        stone[i] -= temp
                        if(stone[i] == 0){
                            havingStone[i] = false
                        }
                        
                        playerTurn = 2
                        if((i+temp)%14==6){
                            playerTurn = 1
                        }
                    }
                    
                    if((!havingStone[0] && !havingStone[1] && !havingStone[2] && !havingStone[3] && !havingStone[4] && !havingStone[5]) || (!havingStone[7] && !havingStone[8] && !havingStone[9] && !havingStone[10] && !havingStone[11] && !havingStone[12])){
                        isGameover = true
                        for j in 0...5{
                            if(stone[j] != 0){
                                stone[6] += stone[j]
                                stone[j] = 0
                                havingStone[j] = false
                            }
                        }
                        for j in 7...12{
                            if(stone[j] != 0){
                                stone[13] += stone[j]
                                stone[j] = 0
                                havingStone[j] = false
                            }
                        }
                        if(stone[6]>stone[13]){
                            winner = 0
                        }else if(stone[6]<stone[13]){
                            winner = 1
                        }else if(stone[6]==stone[13]){
                            winner = 2
                        }
                    }
                    //AI
                    while(playerTurn == 2 && isGameover == false){
                        var k = Int.random(in: 7...12)
                        while stone[k] == 0{
                            k = Int.random(in: 7...12)
                        }
                        
                        
                        if(stone[k] != 0 && playerTurn == 2){
                            let temp = stone[k]
                            
                            if(stone[(k+temp)%14]==0 && (k+temp)%14 != 13 && (k+temp)%14 > 6 && stone[12-(k+temp)%14] != 0){
                                stone[13] += stone[12-(k+temp)%14] + 1
                                stone[(k+temp)%14] = -1
                                stone[12-(k+temp)%14] = 0
                                havingStone[12-(k+temp)%14] = false
                            }
                            
                            for j in 1...temp{
                                stone[(k+j)%14] += 1
                                if(stone[(k+j)%14] != 0){
                                    havingStone[(k+j)%14] = true
                                }
                            }
                            stone[k] -= temp
                            if(stone[k] == 0){
                                havingStone[k] = false
                            }
                            
                            
                            
                            playerTurn = 1
                            if((k+temp)%14==13){
                                playerTurn = 2
                            }
                        }
                        
                        if((!havingStone[0] && !havingStone[1] && !havingStone[2] && !havingStone[3] && !havingStone[4] && !havingStone[5]) || (!havingStone[7] && !havingStone[8] && !havingStone[9] && !havingStone[10] && !havingStone[11] && !havingStone[12])){
                            isGameover = true
                            for j in 0...5{
                                if(stone[j] != 0){
                                    stone[6] += stone[j]
                                    stone[j] = 0
                                    havingStone[j] = false
                                }
                            }
                            for j in 7...12{
                                if(stone[j] != 0){
                                    stone[13] += stone[j]
                                    stone[j] = 0
                                    havingStone[j] = false
                                }
                            }
                            
                            if(stone[6]>stone[13]){
                                winner = 0
                            }else if(stone[6]<stone[13]){
                                winner = 1
                            }else if(stone[6]==stone[13]){
                                winner = 2
                            }
                            
                        }
                    }
                    
                }label:{
                    ZStack{
                        Circle()
                            .frame(width: diameter, height: diameter, alignment: .center)
                            .fixedSize()
                            .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                            .overlay(
                                Circle()
                                    .stroke(Color(red: 1.0, green: 0.039, blue: 0.902),lineWidth: 3)
                                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .opacity(havingStone[i] && (playerTurn == 1) ? 1: 0)
                                
                            )
                        Text("\(stone[i])")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.black)
                            .offset(x: -30, y: 30)
                        ForEach(0...stone[i], id: \.self){ j in
                            if(j != 0){
                                if(j%5==0){
                                    Image("isaki")
                                        .resizable()
                                        .rotationEffect(.degrees(90))
                                        .frame(width: isakiHeight*8/9, height: isakiHeight, alignment: .center)
                                        .fixedSize()
                                        .frame(width: isakiHeight, height: isakiHeight, alignment: .center)
                                        .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                                }else if(j%5==1){
                                    Image("nagi")
                                        .resizable()
                                        .rotationEffect(.degrees(90))
                                        .frame(width: nagiHeight*20/11, height: nagiHeight, alignment: .center)
                                        .fixedSize()
                                        .frame(width: nagiHeight, height: nagiHeight, alignment: .center)
                                        .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                                }else if(j%5==2){
                                    Image("bachira")
                                        .resizable()
                                        .rotationEffect(.degrees(90))
                                        .frame(width: bachiraHeight*7/4, height:bachiraHeight , alignment: .center)
                                        .fixedSize()
                                        .frame(width: bachiraHeight, height: bachiraHeight, alignment: .center)
                                        .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                                }else if(j%5==3){
                                    Image("barou")
                                        .resizable()
                                        .rotationEffect(.degrees(90))
                                        .frame(width: bachiraHeight*7/4, height:bachiraHeight , alignment: .center)
                                        .fixedSize()
                                        .frame(width: bachiraHeight, height: bachiraHeight, alignment: .center)
                                        .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                                }else if(j%5==4){
                                    Image("kunigami")
                                        .resizable()
                                        .rotationEffect(.degrees(90))
                                        .frame(width: bachiraHeight, height:bachiraHeight, alignment: .center)
                                        .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
struct AIcircleArray2: View {
    @Binding var stone: [Int]
    @Binding var havingStone: [Bool]
    @Binding var isGameover: Bool
    @Binding var playerTurn: Int
    @Binding var winner: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 26){
            ForEach(7...12, id: \.self){ i in
                ZStack{
                    Circle()
                        .frame(width: diameter, height: diameter, alignment: .center)
                        .fixedSize()
                        .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.0))
                    Text("\(stone[19-i])")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.black)
                        .offset(x: -30, y: 30)
                    ForEach(0...stone[19-i], id: \.self){ j in
                        if(j != 0){
                            if(j%5==0){
                                Image("isaki")
                                    .resizable()
                                    .rotationEffect(.degrees(90))
                                    .frame(width: isakiHeight*8/9, height: isakiHeight, alignment: .center)
                                    .fixedSize()
                                    .frame(width: isakiHeight, height: isakiHeight, alignment: .center)
                                    .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                            }else if(j%5==1){
                                Image("nagi")
                                    .resizable()
                                    .rotationEffect(.degrees(90))
                                    .frame(width: nagiHeight*20/11, height: nagiHeight, alignment: .center)
                                    .fixedSize()
                                    .frame(width: nagiHeight, height: nagiHeight, alignment: .center)
                                    .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                            }else if(j%5==2){
                                Image("bachira")
                                    .resizable()
                                    .rotationEffect(.degrees(90))
                                    .frame(width: bachiraHeight*7/4, height:bachiraHeight , alignment: .center)
                                    .fixedSize()
                                    .frame(width: bachiraHeight, height: bachiraHeight, alignment: .center)
                                    .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                            }else if(j%5==3){
                                Image("barou")
                                    .resizable()
                                    .rotationEffect(.degrees(90))
                                    .frame(width: bachiraHeight*7/4, height:bachiraHeight , alignment: .center)
                                    .fixedSize()
                                    .frame(width: bachiraHeight, height: bachiraHeight, alignment: .center)
                                    .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                            }else if(j%5==4){
                                Image("kunigami")
                                    .resizable()
                                    .rotationEffect(.degrees(90))
                                    .frame(width: bachiraHeight, height:bachiraHeight, alignment: .center)
                                    .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AIView_Previews: PreviewProvider {
    
    
    struct AIViewDemo: View {
        @State private var stone: [Int] = [0,0,0,0,0,1,0,0,0,0,0,0,0,0]
        //[4,4,4,4,4,4,0,4,4,4,4,4,4,0]
        @State private var havingStone = [false,false,false,false,false,true,false,false,false,false,false,false,false,false]
        //[true,true,true,true,true,true,false,true,true,true,true,true,true,false]
        @State private var isGameover = false
        @State private var playerTurn = 1
        @State private var ShowMenu = false
        @State private var winner = 3
        @State private var whoIsWinner = ["P1 WIN!!!","AI WIN!!!","TIE",""]
        
        var body: some View {
            ZStack {
                Image("background")
                    .resizable()
                    .rotationEffect(.degrees(90))
                    .frame(width: 910, height: 420, alignment: .center)
                    .fixedSize()
                    .frame(width: 420, height: 910, alignment: .center)
                HStack(alignment: .center, spacing: 20){
                    VStack(alignment: .center, spacing: 0){
                        Text("\(whoIsWinner[winner])")
                            .font(.title)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(20)
                            .foregroundColor(Color.yellow)
                        
                            .rotationEffect(.degrees(90))
                            .fixedSize()
                            .frame(width: 80, height:180, alignment: .center)
                            .opacity(isGameover ? 1: 0)
                        Button{
                            stone = [4,4,4,4,4,4,0,4,4,4,4,4,4,0]
                            havingStone = [true,true,true,true,true,true,false,true,true,true,true,true,true,false]
                            isGameover = false
                            playerTurn = 1
                            ShowMenu = false
                        }label: {
                            Text("Restart")
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
                        }.fullScreenCover(isPresented: $ShowMenu){
                            ContentView()
                        }
                        Button{
                            ShowMenu = true
                        }label: {
                            Text("Back to menu")
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
                        }.fullScreenCover(isPresented: $ShowMenu){
                            ContentView()
                        }
                    }
                    ZStack{
                        Image("mancala")
                            .resizable()
                            .rotationEffect(.degrees(90))
                            .frame(width: 650, height: 195, alignment: .center)
                            .fixedSize()
                            .frame(width: 195, height: 650, alignment: .center)
                        VStack(alignment: .center, spacing: 20){
                            Pill(stone: $stone[13],player: 2)
                            HStack(alignment: .center, spacing: 41){
                                AIcircleArray(stone: $stone,havingStone: $havingStone,isGameover: $isGameover,playerTurn: $playerTurn,winner: $winner)
                                AIcircleArray2(stone: $stone,havingStone: $havingStone,isGameover: $isGameover,playerTurn: $playerTurn,winner: $winner)
                            }
                            Pill(stone: $stone[6],player: 0)
                        }
                    }
                }
            }
        }
    }
    
    static var previews: some View {
        AIViewDemo()
    }
}
