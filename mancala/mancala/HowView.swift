//
//  HowView.swift
//  mancala
//
//  Created by User03 on 2023/6/8.
//

import SwiftUI

struct HowView: View {
    @Binding var ShowMenu: Bool
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 910, height: 420, alignment: .center)
                .fixedSize()
                .frame(width: 420, height: 910, alignment: .center)
        HStack{
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
            Text(" 特殊規則：\n當最後分配的一顆棋子落在己方計分洞時，該玩家必須選擇任一己方小洞中再進行分配動作。\n當最後分配的一顆棋子落在己方原本無棋子的小洞裡時，且對方正對面洞剛好有棋子時，此兩條件都符合的話，就將分配的最後一顆棋子與正對面的棋子都放取得。")
                .font(.headline)
                .foregroundColor(Color.black)
                .frame(width: 650, height: 150, alignment: .center)
                .rotationEffect(.degrees(90))
                .fixedSize()
                .frame(width: 120, height:650, alignment: .center)
            Text("基本進行方式：是雙方輪流從己方任一有棋子的小洞取出該洞的所有棋子，以逆時針方向分配到其他小洞中，一洞分配一顆，直到分配完，分配棋子時也要經過己方的計分洞，並且分配一顆。\n當一方獲得超過總棋子數量一半時得勝。")
                .font(.headline)
                .foregroundColor(Color.black)
                .frame(width: 650, height: 100, alignment: .center)
                .rotationEffect(.degrees(90))
                .fixedSize()
                .frame(width: 90, height:650, alignment: .center)
            }
        }
    }
}

struct HowView_Previews: PreviewProvider {
    
    struct HowViewDemo: View {
        @State private var isGameover = false
        @State private var ShowMenu = false
        var body: some View {
            ZStack{
                Image("background")
                    .resizable()
                    .rotationEffect(.degrees(90))
                    .frame(width: 910, height: 420, alignment: .center)
                    .fixedSize()
                    .frame(width: 420, height: 910, alignment: .center)
            HStack{
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
                Text("特殊規則：\n當最後分配的一顆棋子落在己方計分洞時，該玩家必須選擇任一己方小洞中再進行分配動作。\n當最後分配的一顆棋子落在己方原本無棋子的小洞裡時，且對方正對面洞剛好有棋子時，此兩條件都符合的話，就將分配的最後一顆棋子與正對面的棋子都放取得。")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 650, height: 150, alignment: .center)
                    .rotationEffect(.degrees(90))
                    .fixedSize()
                    .frame(width: 120, height:650, alignment: .center)
                Text("基本進行方式：是雙方輪流從己方任一有棋子的小洞取出該洞的所有棋子，以逆時針方向分配到其他小洞中，一洞分配一顆，直到分配完，分配棋子時也要經過己方的計分洞，並且分配一顆。\n當一方獲得超過總棋子數量一半時得勝。")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 650, height: 100, alignment: .center)
                    .rotationEffect(.degrees(90))
                    .fixedSize()
                    .frame(width: 90, height:650, alignment: .center)
                }
            }
        }
    }

    static var previews: some View {
        HowViewDemo()
    }
}

