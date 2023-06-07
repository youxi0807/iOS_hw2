//
//  test.swift
//  mancala
//
//  Created by User03 on 2023/6/8.
//

import SwiftUI

//let isakiHeight: CGFloat = 25 //isakiRatio = 8/9
let bachiraHeight: CGFloat = 25 //bachiraRatio = 7/4
struct test: View {
    
    
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(Color(red: 1.0, green: 0.039, blue: 0.902),lineWidth: 3)
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            Image("bachira")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: bachiraHeight*7/4, height:bachiraHeight , alignment: .center)
                .fixedSize()
                .frame(width: bachiraHeight, height: bachiraHeight, alignment: .center)
                .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
            Image("barou")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: bachiraHeight*7/4, height:bachiraHeight , alignment: .center)
                .fixedSize()
                .frame(width: bachiraHeight, height: bachiraHeight, alignment: .center)
                .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
            Image("kunigami")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: bachiraHeight, height:bachiraHeight, alignment: .center)
                .offset(x: CGFloat.random(in: -15...15), y: CGFloat.random(in: -15...15))
        }
        
    }
}
struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
