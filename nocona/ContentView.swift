//
//  ContentView.swift
//  nocona
//
//  Created by judongseok on 2021/05/22.
//

import SwiftUI

struct ContentView: View {
    // 학교 홈페이지 URL
    let homepageURL = "http://www.skhu.ac.kr/main.aspx"
    
    let screenWidth = UIScreen.main.bounds.width
    let screenheight = UIScreen.main.bounds.height
    
    let CountInfo = FetchCount()
    
    var body: some View {
        NavigationView {
            VStack{
                // Thumb nail, hamburger button
                HStack{
                    Image(systemName: "list.dash")
                        .resizable()
                        .frame(width: 30, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(
                            Circle()
                                .stroke()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        )
                }
                .padding(.init(top: 60, leading: 20, bottom: 110, trailing: 20))
                // 일일 확진자
                ZStack{
                    Rectangle()
                        .frame(width: screenWidth * 0.7, height: screenWidth * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    // 텍스트
                    VStack{
                        Text("\(Int(CountInfo.countInfo[0].total!)! - Int(CountInfo.countInfo[1].total!)!)")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                        Text("Today virus cases")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(.top, 5)
                    }
                }
                .padding(.bottom, 30)
                // 총 확진자
                ZStack{
                    Rectangle()
                        .frame(width: screenWidth * 0.7, height: screenWidth * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.green)
                        .cornerRadius(10)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    // 텍스트
                    VStack{
                        Text("\(CountInfo.countInfo[0].total!)+")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                        Text("Total virus cases")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(.top, 5)
                    }
                }
                .padding(.bottom, 100)
                
                HStack{
                    ZStack{
                        Rectangle()
                            .frame(width: screenWidth * 0.4, height: screenWidth * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        // 텍스트
                        NavigationLink(
                            destination: hospitalView(),
                            label: {
                                VStack(alignment: .leading){
                                    Image("oldman")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    Text("선별 진료소 안내")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20))
                                        .padding(.top, 5)
                                }
                            })
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: screenWidth * 0.4, height: screenWidth * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        // 텍스트
                        Link(destination: URL(string: "\(homepageURL)")!, label: {
                            VStack(alignment: .leading){
                                Image("global")
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                                Text("오늘의 성공회대")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                                    .padding(.top, 5)
                            }
                        })
                    }
                }
                Spacer()
            }
            .frame(width: screenWidth, height: screenheight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color(hue: 0.562, saturation: 0.138, brightness: 1.0))
            .ignoresSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
