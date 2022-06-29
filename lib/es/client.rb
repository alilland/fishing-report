# frozen_string_literal: true

##
module ES
  @client = nil
  @headers = {
    'Content-Type': 'application/json'
  }

  def self.initialize_client
    @client = ::Elasticsearch::Client.new(url: ENV['ELASTICSEARCH_URL']) do |conn|
      conn.response :raise_error
      conn.adapter Faraday.default_adapter
    end
    @client
  end

  def self.client
    @client ||= initialize_client
  end
end
