require 'rails_helper'

RSpec.describe AuthenticationMailer, type: :mailer do
  it 'builds an outgoing message for passwordless auth' do
    fake_uuid = 'abc-123'
    allow(SecureRandom).to receive(:uuid) { fake_uuid }
    Campaign.create!(name: 'Turing West Marches', status: 'active')
    user = User.create!(
      username: 'funbucket13',
      password: 'test',
      email: 'bucket@example.com',
    )

    email = AuthenticationMailer.with(user: user).send_login_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['no-reply@turingwestmarches.com'], email.from
    assert_equal ['bucket@example.com'], email.to
    assert_equal "Action Required: #{user.username}, Turing West Marches awaits your return!", email.subject

    plaintext_body = email.text_part.body.to_s
    html_body = email.html_part.body.to_s

    expect(plaintext_body).to have_content("Hail, #{user.username}. Turing West Marches awaits your return.")
    expect(plaintext_body).to have_content("http://turingwestmarches.com/auth/#{fake_uuid}")
    expect(plaintext_body).to have_content('This link expires in 10 minutes.')

    expect(html_body).to have_content("Hail, #{user.username}. Turing West Marches awaits your return.")
    expect(html_body).to have_content('Click here to log in to Turing West Marches.')
    expect(html_body).to have_selector(:css, "a[href=\"http://turingwestmarches.com/auth/#{fake_uuid}\"]")
    expect(html_body).to have_content('This link expires in 10 minutes.')

    # how many actual emails were caught by Rails 6 test environment?
    assert_equal ActionMailer::Base.deliveries.count, 1
  end
end
