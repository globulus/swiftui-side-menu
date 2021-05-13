# SwiftUISideMenu

Add a **Side Menu / Navigation Drawer** to your SwiftUI view! The side menu is animated, responds to user swipes and can be manually shown or hidden.

The end result looks like this:

![in action](https://swiftuirecipes.com/user/pages/01.blog/side-menu-in-swiftui/gif-test.gif)

### Recipe

Check out [this recipe](https://swiftuirecipes.com/blog/side-menu-in-swiftui) for in-depth description of the component and its code. Check out [SwiftUIRecipes.com](https://swiftuirecipes.com) for more **SwiftUI recipes**!

### Sample usage

```swift
struct SideMenuTest: View {
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
        }.sideMenu(isShowing: $showSideMenu) {
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
```

### Installation

This component is distrubuted as a **Swift package**. 

