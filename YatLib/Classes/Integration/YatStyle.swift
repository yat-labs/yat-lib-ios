//  YatStyle.swift
	
/*
    Copyright 2021 The Tari Project

    Redistribution and use in source and binary forms, with or
    without modification, are permitted provided that the
    following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above
    copyright notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of
    its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
    OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit

/// UI style configuration. It's used by the UI in onboarding flow to modify colors, fonts, etc.
public struct YatStyle {
    
    /// Yat logo tint color.
    public let yatLogoTintColor: UIColor
    /// Background color.
    public let backgroundColor: UIColor
    /// Title text style.
    public let titleStyle: TextStyle
    /// Description text style.
    public let descriptionStyle: TextStyle
    /// Primary button style.
    public let primaryButtonStyle: ButtonStyle
    /// Secondary button style.
    public let secondaryButtonStyle: ButtonStyle
    /// Pager primary tint color.
    public let pagerPrimaryColor: UIColor
    /// Pager secondary tint color.
    public let pagerSecondaryColor: UIColor
    /// Close button color.
    public let closeButtonBackgroundColor: UIColor
    
    /// UI style configuration. It's used by the UI in onboarding flow to modify colors, fonts, etc.
    /// - Parameters:
    ///   - yatLogoTintColor: Yat logo tint color.
    ///   - backgroundColor: Background color.
    ///   - titleStyle: Title text style.
    ///   - descriptionStyle: Description text style.
    ///   - primaryButtonStyle: Primary button style.
    ///   - secondaryButtonStyle: Secondary button style.
    ///   - pagerPrimaryColor: Pager primary tint color.
    ///   - pagerSecondaryColor: Pager secondary tint color.
    ///   - closeButtonBackgroundColor: Close button color.
    init(yatLogoTintColor: UIColor, backgroundColor: UIColor, titleStyle: TextStyle, descriptionStyle: TextStyle, primaryButtonStyle: ButtonStyle, secondaryButtonStyle: ButtonStyle, pagerPrimaryColor: UIColor, pagerSecondaryColor: UIColor, closeButtonBackgroundColor: UIColor) {
        self.yatLogoTintColor = yatLogoTintColor
        self.backgroundColor = backgroundColor
        self.titleStyle = titleStyle
        self.descriptionStyle = descriptionStyle
        self.primaryButtonStyle = primaryButtonStyle
        self.secondaryButtonStyle = secondaryButtonStyle
        self.pagerPrimaryColor = pagerPrimaryColor
        self.pagerSecondaryColor = pagerSecondaryColor
        self.closeButtonBackgroundColor = closeButtonBackgroundColor
    }
}

/// The style used to define UI aspects of the text label.
public struct TextStyle {
    /// Text color.
    public let color: UIColor
    /// Text font.
    public let font: UIFont
}

/// The style used to define UI aspects of the button.
public struct ButtonStyle {
    /// Text style.
    public let textStyle: TextStyle
    /// Background color.
    public let backgroundColor: UIColor
}

extension YatStyle {
    
    /// Predefined light theme.
    public static var light: Self {
        Self(
            yatLogoTintColor: .black,
            backgroundColor: .white,
            titleStyle: TextStyle(color: .black, font: .boldSystemFont(ofSize: 24.0)),
            descriptionStyle: TextStyle(color: .textGrey, font: .systemFont(ofSize: 16.0)),
            primaryButtonStyle: ButtonStyle(textStyle: TextStyle(color: .white, font: .boldSystemFont(ofSize: 16.0)), backgroundColor: .primaryBlue),
            secondaryButtonStyle: ButtonStyle(textStyle: TextStyle(color: .buttonTextBlack, font: .boldSystemFont(ofSize: 16.0)), backgroundColor: .secondaryGrey),
            pagerPrimaryColor: .pagerBlue,
            pagerSecondaryColor: .pagerGrey,
            closeButtonBackgroundColor: .closeButtonGrey
        )
    }
    
    /// Predefined dark theme.
    public static var dark: Self {
        Self(
            yatLogoTintColor: .white,
            backgroundColor: .backgroundDark,
            titleStyle: TextStyle(color: .white, font: .boldSystemFont(ofSize: 24.0)),
            descriptionStyle: TextStyle(color: .textLightGrey, font: .systemFont(ofSize: 16.0)),
            primaryButtonStyle: ButtonStyle(textStyle: TextStyle(color: .white, font: .boldSystemFont(ofSize: 16.0)), backgroundColor: .primaryLightBlue),
            secondaryButtonStyle: ButtonStyle(textStyle: TextStyle(color: .textLightGrey, font: .boldSystemFont(ofSize: 16.0)), backgroundColor: .secondaryDark),
            pagerPrimaryColor: .primaryLightBlue,
            pagerSecondaryColor: .pagerSolidGrey,
            closeButtonBackgroundColor: .white
        )
    }
}
