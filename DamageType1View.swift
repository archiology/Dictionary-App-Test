import SwiftUI

struct DamageType1View: View {
    // Use strongly-typed destination views
    let cardItems: [CardItem<Definition1View>] = [
        CardItem(title: "Atmospheric Soiling", imageName: "Definition1View1", destination: Definition1View())
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(cardItems) { cardItem in
                    NavigationLink(destination: cardItem.destination) {
                        DamageTypeView(cardItem: cardItem)
                    }
                }
            }
            .padding()
            .padding(.top, -20)
        }
    }
}

// Updated DamageTypeView to accept a generic CardItem
struct DamageTypeView<Destination: View>: View {
    var cardItem: CardItem<Destination>

    var body: some View {
        VStack {
            Image(cardItem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 130)
                .cornerRadius(15)
            Text(cardItem.title)
                .foregroundColor(.black)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .lineLimit(1) // Prevents text from overflowing
                .frame(maxWidth: 170, alignment: .leading)
                .padding(.leading, 0)
        }
        .padding(10)
    }
}


#Preview {
    DamageType1View()
}
