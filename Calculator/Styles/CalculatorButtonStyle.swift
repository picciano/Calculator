//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/19/21.
//

import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {

    var button: CalculatorButton
    var buttonRadius: CGFloat

    public func makeBody(configuration: CalculatorButtonStyle.Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize))
            .frame(width: width,
                   height: height)
            .foregroundColor(button.foregroundColor)
            .background(button.backgroundColor)
            .cornerRadius(cornerRadius)
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

    var fontSize: CGFloat {
        switch button {
        case .add, .subtract, .divide, .equals:
            return buttonRadius / 2
        default:
            return buttonRadius / 3
        }
    }
}
