//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var count = 0
}

struct ContentView: View {
  @ObservedObject var state: AppState
  var body: some View {
    NavigationView {
        List {
            NavigationLink(destination: CounterView(state: AppState())
            ) {
                Text("Counter Demo")
            }
            NavigationLink(destination: EmptyView()) {
                Text("Favorite Primes")
            }
        }
        .navigationBarTitle("State Management")
    }
  }
}

private func ordinal(_ n:Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter.string(for: n) ?? ""
}
struct CounterView: View {
    // Property Wrapper
//    @State var count: Int = 0
    @ObservedObject var state: AppState
    
    var body: some View {
//        self.$count // Binding<Int>
        
        VStack {
            HStack {
                Button(action: { self.state.count -= 1}) {
                    Text("-")
                }
                Text("\(self.state.count)")
                Button(action: { self.state.count += 1 }) {
                    Text("+")
                }
            }
            Button(action: {}) {
                Text("Is this prime?")
            }
            Button(action: {}) {
                Text("What is the \(ordinal(self.state.count)) prime?")
            }
        }
        .font(.title)
        .navigationBarTitle("Counter Demo")
    }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = UIHostingController(
    rootView: ContentView(state: AppState())
)
