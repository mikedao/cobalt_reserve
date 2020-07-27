require "rails_helper"

RSpec.describe AuthenticationMailer, type: :mailer do
  it 'builds an outgoing message for passwordless auth' do
    fake_uuid = 'abc-123'
    allow(SecureRandom).to receive(:uuid) { fake_uuid }
    campaign = Campaign.create!(name: 'Turing West Marches', status: 'active')
    user = User.create!(username: 'funbucket13',
                         password: 'test',
                         email: 'bucket@example.com')
    character = Character.create!(user: user, campaign: campaign, name: 'Cormyn')

    email = AuthenticationMailer.with(character: character).send_login_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['no-reply@cobalt-reserve.com'], email.from
    assert_equal ['bucket@example.com'], email.to
    assert_equal "Action Required: The Cobalt Reserve is waiting for the return of #{character.name}", email.subject

    plaintext_body = email.text_part.body.to_s
    html_body = email.html_part.body.to_s

    expect(plaintext_body).to have_content("Hail, #{character.name}. The Cobalt Reserve awaits your presence.")
    expect(plaintext_body).to have_content("http://cobalt-reserve.com/auth/#{fake_uuid}")
    expect(plaintext_body).to have_content("This link expires in 10 minutes.")

    expect(html_body).to have_content("Hail, #{character.name}. The Cobalt Reserve awaits your presence.")
    expect(html_body).to have_content("Click here to return to the Cobalt Reserve.")
    expect(html_body).to have_selector(:css, "a[href=\"http://cobalt-reserve.com/auth/#{fake_uuid}\"]")
    expect(html_body).to have_content("This link expires in 10 minutes.")

    # how many actual emails were caught by Rails 6 test environment?
    assert_equal ActionMailer::Base.deliveries.count, 1
  end
end
