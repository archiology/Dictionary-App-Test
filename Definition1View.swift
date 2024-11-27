import SwiftUI

struct Definition: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
    var destination: AnyView
}

struct DefinitionView: View {
    var definition: Definition

    var body: some View {
        VStack {
            Image(definition.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 130)
                .cornerRadius(20)
            Text(definition.title)
                .foregroundColor(.black)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .lineLimit(1)
                .frame(maxWidth: 170, alignment: .leading)
        }
        .padding(10)
    }
}

struct GreyBox: View {
    let heading: String
    let bodyText: String?
    let causes: [String]?
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            // Heading with icon
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 20)) // Set the icon size
                Text(heading)
                    .font(.system(size: 17, weight: .semibold))

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let bodyText = bodyText {
                Text(bodyText)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding(.leading, 31)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let causes = causes {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(causes.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .top) {
                                // Number with hanging indentation
                                Text("\(index + 1)")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color.black.opacity(0.9))
                                    .frame(width: 16, alignment: .leading)
                                    .padding(.top, 2)
                                    .padding(.leading, 8)
                                Text(causes[index])
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Color.black.opacity(0.9))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            if index < causes.count - 1 {
                                // Divider between points
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color.gray.opacity(0.3))
                                    .padding(.leading, 28) // Align divider with text
                                    .padding(.bottom, 8)
                                    .padding(.top, 15)
                            }
                        }
                    }
                }
                .padding(.leading, 0)
            }
        }
        .padding()
        .background(Color(red: 251 / 255.0, green: 251 / 255.0, blue: 253 / 255.0))
        .cornerRadius(20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Definition1View: View {
    static let title = "Atmospheric Soiling"
    
    let items = [
        ("Description", "A black discolouration that appears on the surface of the brick and mortar, more typically in areas not exposed to driving rain.", "eye.circle.fill"),
        ("Causes", nil, "magnifyingglass.circle.fill"),
        ("Types", "Can affect all material types.", "circle.hexagongrid.circle.fill"),
        ("Concern", "Potential health concern. \nPotential material concern.", "exclamationmark.circle.fill"),
        ("Tests", nil, "checkmark.circle.fill"),
        ("Repair", nil, "cross.circle.fill")
    ]
    
    let causes = [
        "A result of environmental pollution (engine exhausts, construction dust, soot) depositing on the surface of the brick."
    ]
    
    let tests = [
        "Can be dissolved by water.",
        "Can be dry brushed or scraped off."
    ]
    
    let repair = [
        "Soiled areas can be cleaned with distilled water or dry brushing."
    ]
    
    let images = ["Definition1View1", "Definition1View2", "Definition1View3"]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 23) {
                    // Title in its own container
                    HStack {
                        Text("Atmospheric Soiling")
                            .font(.system(size: 28, weight: .medium))
                        Spacer() // Push the title to the leading side
                    }
                    .padding(.horizontal, 20) //
                    
                    // Image carousel
                    TabView {
                        ForEach(images, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 0.9, height: 250)
                                .cornerRadius(20)
                                .clipped()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 250)

                    VStack(spacing: 16) {
                        ForEach(items, id: \.0) { heading, bodyText, icon in
                            if heading == "Causes" {
                                GreyBox(
                                    heading: heading,
                                    bodyText: nil,
                                    causes: causes,
                                    icon: icon
                                )
                                .padding(.horizontal, 16)
                            } else if heading == "Tests" {
                                GreyBox(
                                    heading: heading,
                                    bodyText: nil,
                                    causes: tests,
                                    icon: icon
                                )
                                .padding(.horizontal, 16)
                            } else if heading == "Repair" {
                                GreyBox(
                                    heading: heading,
                                    bodyText: nil,
                                    causes: repair,
                                    icon: icon
                                )
                                .padding(.horizontal, 16)
                            } else {
                                GreyBox(
                                    heading: heading,
                                    bodyText: bodyText,
                                    causes: nil,
                                    icon: icon
                                )
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("")
                }
            }
        }
    }
}

#Preview {
    Definition1View()
}

