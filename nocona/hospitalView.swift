//
//  hospitalView.swift
//  nocona
//
//  Created by judongseok on 2021/05/22.
//

import SwiftUI

struct hospitalView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenheight = UIScreen.main.bounds.height
    
    let hospitalinfo = FetchData()
    var body: some View {
        ZStack{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
                Text("선별 진료소 확인")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(width: screenWidth * 0.9, height: 50, alignment: .leading)
                    .font(.system(size: 30))
                    .padding(.leading, 20)
                ForEach(hospitalinfo.hospitals, id: \.self) { hospital in
                    VStack(alignment: .leading){
                        Text(hospital.yadmNm!)
                            .font(.system(size: 20))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.29))
                            
                            Text(hospital.sgguNm!)
                                .padding(.trailing, 20)
                                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.29))
                            
                            Image(systemName: "phone")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.29))
                            
                            Text(hospital.telno!)
                                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.29))
                        }
                    }
                    .frame(width: 300, alignment: .leading)
                    .padding(.init(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.vertical, 10)
                }
            })
            .padding(.top, 60)
            .padding(.bottom, 20)
            .navigationBarBackButtonHidden(true)
        }
        .frame(width: screenWidth, height: screenheight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(hue: 0.562, saturation: 0.138, brightness: 1.0))
        .ignoresSafeArea(.all)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct hospitalView_Previews: PreviewProvider {
    static var previews: some View {
        hospitalView()
    }
}
