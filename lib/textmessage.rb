# frozen_string_literal: true

##
module TextMessage
  @client = nil

  def self.initialize_client
    @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
    @client
  end

  def self.client
    @client ||= initialize_client
  end
end
