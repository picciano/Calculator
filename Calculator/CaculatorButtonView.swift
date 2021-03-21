//
//  CaculatorButtonView.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/19/21.
//

import SwiftUI

struct CalculatorButtonView: View {

    @EnvironmentObject
    var env: CalculatorEnvironment

    var button: CalculatorButton
    var buttonRadius: CGFloat

    var body: some View {
        Button(action: {
            env.process(button)
        }, label: {
            Text(button.title)
                .font(.system(size: button.fontSize))
                .frame(width: width,
                       height: height)
                .foregroundColor(button.foregroundColor)
                .background(button.backgroundColor)
                .cornerRadius(cornerRadius)
        })
    }

    var width: CGFloat {
        switch button {
        case .zero:
            return buttonRadius * 2 + CalculatorView.Properties.spacing
        default:
            return buttonRadius
        }
    }

    var height: CGFloat {
        return buttonRadius
    }

    var cornerRadius: CGFloat {
        return buttonRadius / 2
    }
}
