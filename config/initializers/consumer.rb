# frozen_string_literal: true

require 'json'

channel = RabbitMq.consumer_channel
queue = channel.queue('authorization', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, _properties, payload|
  payload = JSON(payload)
  decode = JwtEncoder.decode(payload['jwt']) rescue nil

  if decode.present?
    client = AdsService::Rmq::Client.fetch
    client.authorization(decode['uuid'])
  end

  channel.ack(delivery_info.delivery_tag)
end
