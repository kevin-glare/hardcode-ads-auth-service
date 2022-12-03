# frozen_string_literal: true

require 'json'

channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('authorization', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  decode = JwtEncoder.decode(payload['token']) rescue {}

  if decode.present?
    result = Auth::FetchUserService.call(decode['uuid'])
    data = result.success? ? { user_id: result.user.id }.to_json : ''

    exchange.publish(
      data,
      routing_key: properties.reply_to,
      correlation_id: properties.correlation_id
    )
  end
end
