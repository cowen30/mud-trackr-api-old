# frozen_string_literal: true

require 'mail'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'securerandom'

module EmailHelper

	ADMIN_USER_ACCOUNT = 'admin@mudtrackr.com'

	def send_email(to_email, subject, body)
		m = Mail.new(
			to: to_email,
			from: 'MudTrackr <noreply@mudtrackr.com>',
			subject: subject,
			body: body,
			content_type: 'text/html; charset=UTF-8'
		)

		message = Google::Apis::GmailV1::Message.new(raw: m.to_s)
		gmail = Google::Apis::GmailV1::GmailService.new

		authorizer = Google::Auth::ServiceAccountCredentials.make_creds(scope: 'https://mail.google.com/')

		authorizer.sub = ADMIN_USER_ACCOUNT
		authorizer.fetch_access_token!

		gmail.authorization = authorizer

		begin
			result = gmail.send_user_message ADMIN_USER_ACCOUNT, message
			puts "Email sent successfully to #{to_email}"
		rescue Google::Apis::Error => e
			puts "Error sending message to #{to_email}"
			puts "Stack trace: #{e}"
		end
	end

	def send_welcome_email(user)
		generate_verification_code(user)
		to_email = user.email
		subject = 'Welcome to MudTrackr!'
		body = "Welcome #{user.first_name}! Thank you for registering for an account on MudTrackr.<br/><br/>Please click the link below to verify your email.<br/><br/><a href=\"#{ENV['UI_BASE_URL']}/verify-account?userId=#{user.id}&verificationCode=#{user.verification_code}\">Verify email</a>"
		send_email(to_email, subject, body)
	end

	private

	def generate_verification_code(user)
		verification_code = SecureRandom.hex(16)
		user.verification_code = verification_code
		user.save
	end

end
