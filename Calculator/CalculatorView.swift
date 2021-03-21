//
//  ContentView.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/19/21.
//

import SwiftUI

struct CalculatorView: View {

    struct Properties {
        static let spacing: CGFloat = 12.0
    }

    @EnvironmentObject
    var env: CalculatorEnvironment

    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {

        ZStack(alignment: .bottom) {

            Color.black.ignoresSafeArea(.all)

            VStack(alignment: horizontalSizeClass == .regular ? .trailing : .center, spacing: CalculatorView.Properties.spacing) {

                HStack {
                    Spacer()
                    Text(env.displayText)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }

                let metrics = buttonMetrics

                ForEach(metrics.buttons, id: \.self) { row in
                    HStack(spacing: CalculatorView.Properties.spacing) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button, buttonRadius: metrics.buttonRadius)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CalculatorView().environmentObject(CalculatorEnvironment())
        }
    }
}
