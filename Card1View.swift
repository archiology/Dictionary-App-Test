import SwiftUI

struct Card1View: View {
    let cardItems: [CardItem<DamageType1View>] = [
        CardItem(title: "Surface Change", imageName: "brick_item1_image", destination: DamageType1View())
    ]
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: UIScreen.main.bounds.width > 300 ? 2 : 1)
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(cardItems) { cardItem in
                            NavigationLink(destination: cardItem.destination) {
                                CardItemView(cardItem: cardItem)
                            }
                        }
                    }
                    .padding([.horizontal])
                    .padding(.top, 40)
                }
            }
            .navigationBarHidden(true)
                }
            }
        }

struct CardItem<Destination: View>: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
    var destination: Destination
}

struct CardItemView<Destination: View>: View {
    var cardItem: CardItem<Destination> // Explicit generic type for cardItem

    var body: some View {
        VStack {
            Image(cardItem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 130)
                .cornerRadius(15)
                .accessibilityLabel(Text(cardItem.title))
            Text(cardItem.title)
                .foregroundColor(.black)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .lineLimit(1)
                .frame(maxWidth: 170, alignment: .leading)
        }
        .padding(5)
    }
}


#Preview {
    Card1View()
}
