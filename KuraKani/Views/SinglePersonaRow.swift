//
//  SinglePersonaRow.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-09.
//

import SwiftUI

struct SinglePersonaRow: View {
    let persona: SinglePersona

    var body: some View {
        HStack {
            persona.icon
                .resizable()
                .scaledToFit()
                .frame(width: 72)
            VStack(alignment: .leading) {
                Text(persona.name)
                    .font(.title3)
                    .bold()
                Text(persona.description)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            persona.icon
                .resizable()
                .blur(radius: 48)
                .saturation(2.0)
                .clipped()
        )
        .background(.thinMaterial, in: .rect(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.ultraThinMaterial, lineWidth: 2)
        )
    }
}

#Preview {
    SinglePersonaRow(persona: .examplePersonas.first!)
        .preferredColorScheme(.dark)
        .padding()
}
