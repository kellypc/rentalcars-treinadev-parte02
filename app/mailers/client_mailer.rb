class ClientMailer < ApplicationMailer
  def welcome(client)
    @client = IndividualClient.find(client)
    mail(to: @client.email)
  end
end