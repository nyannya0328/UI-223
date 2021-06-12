//
//  Home.swift
//  UI-233
//
//  Created by にゃんにゃん丸 on 2021/06/12.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    @State var lastoffset : CGFloat = 0
    @GestureState var gesturestate : CGFloat = 0
    
    @State var txt = ""
    var body: some View {
        
        ZStack{
            
            GeometryReader{proxy in
                
                let frame = proxy.frame(in:.global)
                
                
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
                    
            }
            .blur(radius: gestrueRadius())
            .ignoresSafeArea()
            
            GeometryReader{proxy ->AnyView in
                let height = proxy.frame(in:.global).height
                
                return AnyView(
                
                    ZStack{
                        BlurView(style: .systemThinMaterialDark)
                            .clipShape(CustomShape(radi: 35, corner: [.topLeft,.topRight]))
                          
                        
                        
                        VStack{
                            
                            VStack{
                                
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width : 60,height: 4)
                                    .padding(.top)
                                
                                
                                
                                TextField("Enter", text: $txt)
                                    .padding(.vertical,15)
                                    .padding(.horizontal)
                                    .background(BlurView(style: .dark))
                                   
                                    .cornerRadius(10)
                                    .colorScheme(.dark)
                                    .padding(.top,10)
                                
                            }
                            .frame(height: 100)
                            
                            ScrollView(.vertical, showsIndicators: false, content: {
                                ButtomContent()
                                    .padding(.bottom)
                                    .padding(.bottom,offset == -((height - 100) / 3) ? ((height - 100) / 1.5) : 0)
                            })
                            
                            
                            
                            
                            
                            
                        }
                        .padding()
                        .frame(maxHeight: .infinity, alignment: .top)
                        
                    }
                    .offset(y: height - 100)
                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                    .gesture(
                    
                        DragGesture().updating($gesturestate, body: { value, out, _ in
                            
                            out = value.translation.height
                            onChaged()
                            
                        }).onEnded({ value in
                            
                            let maxHegith = height - 100
                            
                            
                            withAnimation{
                                
                                if -offset > 100 && -offset < maxHegith / 2{
                                    
                                    offset = -(maxHegith / 3)
                                    
                                }
                                
                                else if -offset > maxHegith / 2 {
                                    
                                    
                                    offset = -maxHegith
                                    
                                }
                                else{
                                    
                                    offset = 0
                                }
                                
                                
                            }
                            
                            lastoffset = offset
                            
                            
                            
                            
                            
                        })
                    
                    )
                
                )
            }
          
        }
        
    }
    
    func gestrueRadius()->CGFloat{
        
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        
        return progress * 30 <= 30 ? progress * 30 : 30
        
        
    }
    
    func onChaged(){
        
        DispatchQueue.main.async {
            self.offset = gesturestate + lastoffset
        }
        
        
    }
}

struct ButtomContent : View {
    var body: some View{
        
        VStack{
            
            
            
            HStack{
                Text("Favorites")
                    .font(.title.italic())
                    .foregroundColor(.white)
                
                
                Spacer(minLength: 0)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("See All")
                        .font(.footnote.italic())
                })
                
                
            }
            .padding(.top,20)
            
            
            Divider()
                .background(Color.white)
            
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                
                
                HStack(spacing:15){
                    
                    VStack(spacing:13){
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "house.fill")
                                .font(.title.italic())
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        
                        Text("Home")
                            .font(.title2.smallCaps())
                            .foregroundColor(.white)
                            .padding(15)
                            .background(
                          RoundedRectangle(cornerRadius: 20)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                
                            
                            )
                            
                        
                        
                    }
                    
                    VStack(spacing:13){
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "gear")
                                .font(.title.italic())
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        
                        Text("Settings")
                            .font(.title2.italic())
                            .foregroundColor(.white)
                            .padding(15)
                            .background(
                          RoundedRectangle(cornerRadius: 20)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                
                            
                            )
                            
                        
                        
                    }

                    
                }
                .padding([.top,.bottom])
                
            })
            
            Divider()
                .background(Color.white)
            
            
            ForEach(1...6,id:\.self){index in
                
                
                Image("p\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                    .cornerRadius(10)
                    .padding(.top,15)
                
            }
            
            
            
        }
        
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CustomShape : Shape {
    
    var radi : CGFloat
    var corner : UIRectCorner
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii:CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
        
    }
}
