//
//  ContentView.swift
//  CalculadoraPesoSUI
//
//  Created by Joaquin Martinez on 19/02/24.
//

import SwiftUI

struct ContentView: View {
    @State var indiceGrasa: String = "_____"
    @State var porcentajeGrasaTxt:String = "%0.0"
    @State var peso: String = ""
    @State var altura: String = ""
    
    func calcularIndice(peso: Float, altura: Float) {
        let porcentaje = peso / altura
        porcentajeGrasaTxt = "%\(porcentaje)"
        if porcentaje > 25 {
            indiceGrasa = "Alto"
        } else {
            indiceGrasa = "Normal"
        }
    }
    
    func resetAll(){
        indiceGrasa = "_____"
        porcentajeGrasaTxt = "%0.0"
        peso = ""
        altura = ""
    }
    
    var body: some View {
        
        VStack (alignment: .center, spacing: 12
        ) {
            Text("Porcentaje de grasa:").font(.body)
            Text(porcentajeGrasaTxt).font(.largeTitle)
            Text("Tu índice de grasa es:").font(.body)
            Text(indiceGrasa).font(.largeTitle)
            
            HStack(alignment: .center) {
                Text("Peso: ").font(.body)
                TextField("0", text: $peso).border(.black)
                Text("Altura: ").font(.body)
                TextField("0", text: $altura).border(.black)
            }.padding()
            Spacer()
            Button(action: {
                if let pesoFloat = Float(peso), let alturaFloat = Float(altura) {
                    calcularIndice(peso: pesoFloat, altura: alturaFloat)
                }
            }){
                Text("Calcular")
            }.buttonStyle(CalculatingButtonStyle())
            Button(action: {
                resetAll()
            }){
                Text("Limpiar")
            }.buttonStyle(ClearingButtonStyle())
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Estilo del botón Calcular
struct CalculatingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// Estilo del botón Limpiar
struct ClearingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
