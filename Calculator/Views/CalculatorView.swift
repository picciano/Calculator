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

    var body: some View {

        ZStack(alignment: .bottom) {

            Color(UIColor.tertiarySystemBackground).ignoresSafeArea(.all)

            let config = model.createConfiguration()

            VStack(alignment: config.horizontalAlignment, spacing: CalculatorView.Properties.spacing) {

                HStack {
                    Spacer()
                    Text(model.displayText)
                        .foregroundColor(Color(UIColor.label))
                        .font(.system(size: config.displayTextFontSize))
                        .multilineTextAlignment(.trailing)
                }

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
                            .buttonStyle(CalculatorButtonStyle(button: button, buttonRadius: config.buttonRadius))
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
