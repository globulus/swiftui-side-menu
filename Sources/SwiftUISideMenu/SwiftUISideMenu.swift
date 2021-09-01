import SwiftUI

public struct SideMenu<MenuContent: View>: ViewModifier {
    @Binding var isShowing: Bool
    var disableDragGesture: Bool?
    private let menuContent: () -> MenuContent
    
    public init(isShowing: Binding<Bool>, disableDragGesture: Bool?=nil,
         @ViewBuilder menuContent: @escaping () -> MenuContent) {
        _isShowing = isShowing
        self.disableDragGesture = disableDragGesture
        self.menuContent = menuContent
    }
    
    public func body(content: Content) -> some View {
        let drag = DragGesture().onEnded { event in
            if (disableDragGesture == nil || disableDragGesture == false){
                if event.location.x < 200 && abs(event.translation.height) < 50 && abs(event.translation.width) > 50 {
                withAnimation {
                  self.isShowing = event.translation.width > 0
                }
              }
            }
        }
        return GeometryReader { geometry in
          ZStack(alignment: .leading) {
            content
                .disabled(isShowing)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: self.isShowing ? geometry.size.width / 2 : 0)
            
              menuContent()
                .frame(width: geometry.size.width / 2)
                .transition(.move(edge: .leading))
                .offset(x: self.isShowing ? 0 : -geometry.size.width / 2)
           }
          .gesture(drag)
          .onTapGesture {
              if self.isShowing && disableDragGesture == true {
                  self.isShowing.toggle()
              }
          }
        }
    }
}

public extension View {
    func sideMenu<MenuContent: View>(
        isShowing: Binding<Bool>,
        disableDragGesture: Bool?=nil,
        @ViewBuilder menuContent: @escaping () -> MenuContent
    ) -> some View {
        self.modifier(SideMenu(isShowing: isShowing, disableDragGesture: disableDragGesture,menuContent: menuContent))
    }
}

private struct SideMenuTest: View {
    @State private var showSideMenu = false
    
    var body: some View {
        NavigationView {
            List(1..<6) { index in
                Text("Item \(index)")
            }
            .navigationBarTitle("Dashboard", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showSideMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }.sideMenu(isShowing: $showSideMenu) { //.sideMenu(isShowing: $showSideMenu, disableDragGesture: true)
            VStack(alignment: .leading) {
              Button(action: {
                withAnimation {
                  self.showSideMenu = false
                }
              }) {
                HStack {
                  Image(systemName: "xmark")
                    .foregroundColor(.white)
                  Text("close menu")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .padding(.leading, 15.0)
                }
              }.padding(.top, 20)
                Divider()
                    .frame(height: 20)
                Text("Sample item 1")
                    .foregroundColor(.white)
                Text("Sample item 2")
                    .foregroundColor(.white)
               Spacer()
             }.padding()
             .frame(maxWidth: .infinity, alignment: .leading)
             .background(Color.black)
             .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuTest()
    }
}
