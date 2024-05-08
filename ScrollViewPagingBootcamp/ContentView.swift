//
//  ContentView.swift
//  ScrollViewPagingBootcamp
//
//  Created by Alejandra on 01/04/2024.
//

import SwiftUI
import SwiftUISnappingScrollView


struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
//    TransparentBlurView(removeAllFilters: false)
//                    //.blur(radius: 3)
//                    .frame(width: 400, height: 25)
//                    .border(Color.red)
//                    .offset(y: 100)
//                    .zIndex(1000)

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    //Removing All
                    backdropLayer.filters?.removeAll(where: {filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    }
}

struct ClearView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .opacity(0.8)
        }
        //.background(Color.red)
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            if #available(iOS 17.0, *) {
                TransparentBlurView(removeAllFilters: false)
                    //.blur(radius: 3)
                    .frame(width: 340, height: 50)
                    .border(Color.red)
                    .offset(y: 100)
                    .zIndex(1000)
                    //.visualEffect { content, geometryProxy in
                    //    content.offset(y: 100)
                    //}
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach (0..<10) { index in
                            AsyncImage(url: URL(string :"https://picsum.photos/300"))
                                .frame(width: 300, height: 300)
                                .overlay(
                                    Text ("\(index+1)" )
                                        .padding(8)
                                        .font(.title.bold())
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .frame(maxWidth: .infinity)
                                    //.containerRelativeFrame(.horizontal, alignment: .center)
                                )
                        }
                    }
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
                .scrollBounceBehavior(.basedOnSize)
                .frame(width: 300)
                .offset(y: -20)
            } else {
                TransparentBlurView(removeAllFilters: false)
                //ClearView()
                    //.blur(radius: 10)
                    .frame(width: 340, height: 50)
                    .offset(y: 100)
                    .zIndex(1000)
                SnappingScrollView(.vertical, decelerationRate: .normal, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach (0..<10) { index in
                            AsyncImage(url: URL(string :"https://picsum.photos/300"))
                                .frame(width: 300, height: 300)
                                .overlay(
                                    Text ("\(index+1)" )
                                        .padding(8)
                                        .font(.title.bold())
                                        .foregroundColor(.yellow)
                                        .background(Color.black)
                                        .frame(maxWidth: .infinity)
                                    //.containerRelativeFrame(.horizontal, alignment: .center)
                                )
                        }
                    }
                }
                .offset(y: -100)
               .frame(width: 300)
            }
        }
    }
}

#Preview {
    ContentView()
}
