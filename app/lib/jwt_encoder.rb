module JwtEncoder
  extend self

  HMAC_SECRET = AppSetting.secret_key_base.freeze

  def encode(payload)
    JWT.encode(payload, HMAC_SECRET)
  end

  def decode(token)
    JWT.decode(token, HMAC_SECRET).first
  end
end
