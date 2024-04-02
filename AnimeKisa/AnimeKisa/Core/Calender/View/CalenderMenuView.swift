//
//  CalenderMenuView.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//

import SwiftUI

struct CalenderMenuView: View {
    @State var tools: [Tool] = [
        .init(icon: "m.square", name: "Monday", color: .purple, showText: false),
        .init(icon: "t.square", name: "Tuesday", color: .green, showText: false),
        .init(icon: "w.square", name: "Wednesday", color: .blue, showText: false),
        .init(icon: "t.square", name: "Thursday", color: .orange, showText: false),
        .init(icon: "f.square", name: "Friday", color: .pink, showText: false),
        .init(icon: "s.square", name: "Saturday", color: .indigo, showText: false),
        .init(icon: "s.square", name: "Sunday", color: .yellow, showText: false)
    ]
    var calenderViewModel: CalenderViewModel
    // @State var activeTool:Tool?
    // @State var startedToolPosition:CGRect = .zero
    // @Binding var selectedDay:String
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                ForEach($tools) { $tool in
                    ToolView(tool: $tool)
                        .onTapGesture {
                            tool.showText.toggle()
                            calenderViewModel.selectedDay = tool.name.lowercased()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.smooth) {
                                    tool.showText = false
                                }
                            }
                        }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white.shadow(
                        .drop(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    ).shadow(
                        .drop(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
                    ))
                    .frame(width: 65)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // .coordinateSpace(name:"AREA")
//            .gesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged({ value in
//                        guard let firstTool = tools.first else{return}
//                        if startedToolPosition == .zero{
//                            startedToolPosition = firstTool.toolPostion
//                        }
//
//                        let location = CGPoint(x: startedToolPosition.midX, y: value.location.y)
//
//                        if let index = tools.firstIndex(where: { tool in
//                            tool.toolPostion.contains(location)
//                        }),activeTool?.id != tools[index].id{
//                            withAnimation(.interpolatingSpring(stiffness: 230, damping: 22)) {
//                                activeTool = tools[index]
//                            }
//                        }
//                        calenderViewModel.selectedDay = activeTool?.name.lowercased() ?? ""
//                    })
//                    .onEnded({ _ in
//                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
//                            activeTool = nil
//                            startedToolPosition = .zero
//                        }
//                    })
//            )
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder
    func ToolView(tool: Binding<Tool>) -> some View {
        HStack(spacing: 5) {
            Image(systemName: tool.wrappedValue.icon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
            if tool.wrappedValue.showText == true {
                Text(tool.wrappedValue.name)
                    .foregroundStyle(.white)
                    .padding(.trailing, 5)
            }
            // .padding(.leading,activeTool?.id == tool.id ? 5 : 0)
//                .background{
//                    GeometryReader{proxy in
//                        let frame = proxy.frame(in: .named("AREA"))
//                        Color.clear
//                            .preference(key: RectKey.self, value: frame)
//                            .onPreferenceChange(RectKey.self){ rect in
//                                tool.wrappedValue.toolPostion = rect
//                            }
//                    }
//                }
            
//            if activeTool?.id == tool.id{
//                Text(tool.wrappedValue.name)
//                    .padding(.trailing,15)
//                    .foregroundStyle(.white)
//            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(tool.wrappedValue.color.gradient)
        }
        // .offset(x:activeTool?.id == tool.wrappedValue.id ? 60 : 0)
    }
}

#Preview {
    CalenderMenuView(calenderViewModel: CalenderViewModel())
}

// struct RectKey:PreferenceKey{
//    static var defaultValue: CGRect = .zero
//    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
//        value = nextValue()
//    }
// }
