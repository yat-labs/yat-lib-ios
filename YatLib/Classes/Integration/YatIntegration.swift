//  YatIntegration.swift
	
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
import TariCommon

/// Yat's integration manager. Provides all methods needed to guild users through the onboarding/connection flow and handle responses related to that flow.
public final class YatIntegration {
    
    // MARK: - Properties
    
    /// A callback with information about the recently connected Yat. It's called at the end of the successful onboarding flow.
    public var onYatConnected: ((String) -> Void)?
    
    private weak var hostController: UIViewController?
    
    // MARK: - Initialisers
    
    init() {
        CommonSettings.localBundle = .local
    }
    
    // MARK: - Public Actions
    
    /// Shows onboarding flow on the host view controller. It will attach provided records to the Yat selected by the user.
    /// - Parameters:
    ///   - hostController: View controller used as a host for a modally presented onboarding view controller.
    ///   - records: Records that will be attached to the user's Yat.
    public func showOnboarding(onViewController hostController: UIViewController, records: [YatRecordInput]) {
        
        let onboardingController = OnboardingViewController(records: records)
        onboardingController.isModalInPresentation = true
        self.hostController = hostController
        
        hostController.present(onboardingController, animated: true)
    }
    
    /// Deeplink handler. Handle feedback URLs from the onboarding flow.
    ///
    /// To use it please add it to the method responsible for handling incoming deeplinks in the `SceneDelegate.swift`:
    /// ```
    /// func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    ///     guard let url = URLContexts.first?.url else { return }
    ///     Yat.integration.handle(deeplink: url)
    /// }
    /// ```
    /// - Parameter deeplink: Deeplink URL which need to be handled.
    public func handle(deeplink: URL) {
        guard let emojiID = emojiID(fromDeeplink: deeplink) else { return }
        onYatConnected?(emojiID)
        showSuccessDialog(emojiID: emojiID)
    }
    
    // MARK: - Internal Actions
    
    func openCreateYatFlow(records: [YatRecordInput]) throws {
        try openOnboardingWebpage(path: "/partner/\(Yat.configuration.organizationKey)", records: records)
    }
    
    func connectExistingYat(records: [YatRecordInput]) throws {
        try openOnboardingWebpage(path: "/partner/\(Yat.configuration.organizationKey)/link-email", records: records)
    }
    
    // MARK: - Private Actions
    
    private func showSuccessDialog(emojiID: String) {
        hostController?.dismiss(animated: true, completion: {})
        let successController = ConnectionSuccessViewController()
        successController.yatID = emojiID
        
        hostController?.present(successController, animated: true)
    }
    
    private func openOnboardingWebpage(path: String, records: [YatRecordInput]) throws {
        
        guard var components = URLComponents(url: Yat.urls.webServiceURL, resolvingAgainstBaseURL: true) else { throw OnboardingError.internalError }
        
        let recordsValue = records
            .map { "\($0.tag.rawValue)=\($0.value)"}
            .joined(separator: "|")
        
        components.path = path
        components.queryItems = [URLQueryItem(name: "addresses", value: recordsValue)]
        
        guard let url = components.url else { throw OnboardingError.invalidQuery }
        
        guard UIApplication.shared.canOpenURL(url) else { throw OnboardingError.unableToOpenURL }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Helpers
    
    private func emojiID(fromDeeplink deeplink: URL) -> String? {
        guard let validationURL = URL(string: Yat.configuration.appReturnLink), validationURL.scheme == deeplink.scheme, validationURL.host == deeplink.host else { return nil }
        return deeplink.queryParameters["eid"]
    }
}
