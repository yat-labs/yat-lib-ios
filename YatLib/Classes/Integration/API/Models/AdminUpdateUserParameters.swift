//  AdminUpdateUserParameters.swift
	
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

public struct AdminUpdateUserParameters: Codable {
    /// Optional: Source of activation
    public let activationSource: String?
    /// Optional: Current password, must be provided if one exists
    public let currentPassword: String?
    /// Optional: Email
    public let email: String?
    /// Optional: First name
    public let firstName: String?
    /// Optional: Free limit for how many yats the user may purchase
    public let freeLimit: Int?
    /// Optional: Last name
    public let lastName: String?
    /// Optional: User password
    public let password: String?
    /// Optional: Update the user role
    public let role: String?

    public init(activationSource: String?, currentPassword: String?, email: String?, firstName: String?, freeLimit: Int?, lastName: String?, password: String?, role: String?) {
        self.activationSource = activationSource
        self.currentPassword = currentPassword
        self.email = email
        self.firstName = firstName
        self.freeLimit = freeLimit
        self.lastName = lastName
        self.password = password
        self.role = role
    }
}
