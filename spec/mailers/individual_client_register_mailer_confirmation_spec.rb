RSpec.describe ClientMailer, type: :mailer do
  describe '#welcome' do
    it 'should send to individual client email' do
      client = create(:individual_client)

      mail = ClientMailer.welcome(client.id)
    end
  end
end