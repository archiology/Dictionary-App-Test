import SwiftUI

// Define the Card struct
struct Card: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    var isExpanded: Bool = false
}

struct CardStackView: View {
    @State private var cards: [Card] = [
        Card(title: "Brick", content: "This is the content of Card 1"),
        Card(title: "Ceramic", content: "This is the content of Card 2"),
        Card(title: "Concrete", content: "This is the content of Card 3"),
        Card(title: "Glass", content: "This is the content of Card 4"),
        Card(title: "Metal", content: "This is the content of Card 5"),
        Card(title: "Mortar", content: "This is the content of Card 6"),
        Card(title: "Render", content: "This is the content of Card 7"),
        Card(title: "Stone", content: "This is the content of Card 8"),
        Card(title: "Timber", content: "This is the content of Card 9")
    ]
    @State private var selectedCard: UUID? = nil
    @State private var isBlueBoxExpanded: Bool = false // Track the expanded state of the blue box

    var body: some View {
        ZStack {
            Color.black.zIndex(0) // Set the background to black
                .ignoresSafeArea() // Extend the black background to cover the entire screen
            
            VStack(spacing: 0) {
                // Blue box at the top of the screen
                BlueBoxView(isExpanded: $isBlueBoxExpanded)

                // Card stack view with dynamic top padding
                ZStack {
                    ForEach(cards.indices.reversed(), id: \.self) { index in
                        CardView(
                            card: $cards[index],
                            isSelected: selectedCard == cards[index].id,
                            content: getCardContent(index: index),
                            onClose: {
                                withAnimation(.spring()) {
                                    selectedCard = nil // Clear the selected card
                                }
                            }
                        )
                        .offset(y: selectedCard == nil ? CGFloat(index) * 58 : 0) // Stacked effect
                        .zIndex(selectedCard == cards[index].id ? 1 : Double(index) / Double(cards.count))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                if selectedCard == nil { // Allow only selection, no deselection
                                    selectedCard = cards[index].id
                                }
                            }
                        }
                    }
                }
                .padding(.top, isBlueBoxExpanded ? 120 : 10) // Adjust padding based on expansion state
                .animation(.spring(), value: isBlueBoxExpanded) // Animate changes
                .ignoresSafeArea()
            }
        }
    }

    /// Returns the appropriate content view for a given index
    @ViewBuilder
    private func getCardContent(index: Int) -> some View {
        switch index {
        case 0: Card1View()
        case 1: Card2View()
        case 2: Card3View()
        case 3: Card4View()
        case 4: Card5View()
        case 5: Card6View()
        case 6: Card7View()
        case 7: Card8View()
        case 8: Card9View()
        default: EmptyView()
        }
    }
}

struct BlueBoxView: View {
    @Binding var isExpanded: Bool // Bind the expansion state to the parent view

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]), // Gradient background
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .clipShape(
                RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]) // Rounded corners
            )
            
            VStack {
                Spacer() // Push content towards the bottom
                
                ZStack(alignment: .bottom) {
                    Text("Damage \nDiagnostic \nDictionary")
                        .foregroundColor(.white)
                        .font(.system(size: 36, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .offset(y: isExpanded ? 390 : 0) // Adjust vertical movement

                    Text("i")
                        .foregroundColor(.white)
                        .font(.system(size: 36, design: .serif))
                        .italic()
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .opacity(0.5)
                        .padding(.trailing, 40)
                        .padding(.top, 5) // Adjust bottom padding for minimum distance
                        .offset(y: isExpanded ? 390 : 0) // Adjust vertical movement
                }
                .padding(.bottom, 5) // Ensures the minimum distance from the bottom edge

                if isExpanded {
                    VStack {
                        Text("Made by Tom")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        Text("tom.com")
                            .foregroundColor(.white)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.bottom, 70)


                        Text("In partnership with")
                            .foregroundColor(.white)
                            .font(.title3)
                            .italic()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .opacity(0.7)
                            .padding(.bottom, 5)

                        Text("Archiology Australia \nThe University of Melbourne")
                            .foregroundColor(.white)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)

                        Rectangle()
                            .fill(Color.white)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 1)
                            .padding(.top, 10)
                            .opacity(0.7)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 150) // Adjust vertical position
                }
            }
            .padding(.bottom, 5) // Padding at the bottom
        }
        .frame(height: isExpanded ? 1200 : 200)
        .onTapGesture {
            withAnimation(.spring()) {
                isExpanded.toggle() // Toggle expansion state
            }
        }
        .ignoresSafeArea() // Extend to the top edge
    
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CardView<Content: View>: View {
    @Binding var card: Card
    var isSelected: Bool
    var content: Content
    var onClose: () -> Void // Callback for closing the card

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Display the title at the top of the card, even when expanded
                Text(card.title)
                .font(.title)
                .fontWeight(.medium) // Adjust font size
                .padding(.horizontal, 20) // Horizontal padding
                .padding(.top, 20) // Vertical padding
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 45) // Set a specific height for the title area

                Spacer() // Push the content below the title

                if isSelected {
                    content // Embed the content
                        .zIndex(3) // Ensure content is above the card
                }
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height * 0.78)            .background(Color.white)
            .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
            .shadow(radius: 5)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height > 100 { // Detect a downward swipe
                            withAnimation(.spring()) {
                                onClose() // Trigger the close callback
                            }
                        }
                    }
            )

                }
            }
        }

#Preview {
    CardStackView()
}
