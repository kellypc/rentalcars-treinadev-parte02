require 'rails_helper'

RSpec.describe ClientMailer, type: :mailer do
  describe '#welcome' do
    it 'should send to individual client email' do
      client = create(:individual_client, email: 'code@example.com')
      mail = ClientMailer.welcome(client.id)

      expect(mail.to).to include(client.email)
    end
  end
end