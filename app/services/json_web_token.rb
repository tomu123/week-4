# frozen_string_literal: true

# JWT Class
class JsonWebToken
  # The secret must be a string. A JWT::DecodeError will be raised if it isn't provided.
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 8.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, SECRET_KEY, 'HS256'
  end

  def self.decode(token)
    leeway = 30 # seconds
    begin
      # Array
      # [
      #   {"data"=>"test"}, # payload
      #   {"alg"=>"HS256"} # header
      # ]
      decoded = JWT.decode token, SECRET_KEY, true, { exp_leeway: leeway, algorithm: 'HS256' }
      HashWithIndifferentAccess.new decoded.first
    rescue JWT::ExpiredSignature
      # Handle expired token, e.g. logout user or deny access
      raise CustomError.new(error: 'Invalid Token', message: 'Token Expired', status: :unauthorized)
    rescue JWT::VerificationError
      raise CustomError.new(error: 'Invalid Token', message: 'Token can not be verified', status: :unauthorized)
    end
  end
end
