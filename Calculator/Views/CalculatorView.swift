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
    var model: CalculatorViewModel

    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass

    @Environment(\.verticalSizeClass)
    var verticalSizeClass

    var body: some View {

        ZStack(alignment: .bottom) {

            Color(UIColor.tertiarySystemBackground).ignoresSafeArea(.all)

            let config = Configuration(with: horizontalSizeClass ?? .regular,
                                       verticalSizeClass ?? .regular)

            VStack(alignment: horizontalSizeClass == .regular ? .trailing : .center,
                   spacing: CalculatorView.Properties.spacing) {

                HStack(alignment: .top) {
                    if model.memory.hasValue {
                        Text("M")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 18, weight: .black))
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Text(model.displayText)
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: config.displayFontSize))
                        .multilineTextAlignment(.trailing)
                }

                GeometryReader { (metrics) in
                    let buttonRadius = config.buttonRadius(using: metrics)
                    VStack(alignment: metrics.size.width > metrics.size.height ? .trailing : .center,
                           spacing: CalculatorView.Properties.spacing) {

                        Color(UIColor.tertiarySystemBackground).ignoresSafeArea(.all)

                        ForEach(config.buttons, id: \.self) { row in
                            HStack(spacing: CalculatorView.Properties.spacing) {
                                ForEach(row, id: \.self) { button in
                                    Button {
                                        model.process(button)
                                    } label: {
                                        if let systemImageName = button.systemImageName {
                                            Image(systemName: systemImageName)
                                        } else {
                                            Text(model.isDefaultDisplay ? button.altTitle : button.title)
                                        }
                                    }
                                    .buttonStyle(CalculatorButtonStyle(button: button, buttonRadius: buttonRadius))
                                }
                            }
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
            CalculatorView().environmentObject(CalculatorViewModel())
        }
    }
}
