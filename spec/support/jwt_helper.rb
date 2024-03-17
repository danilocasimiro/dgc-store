module JwtHelper
  def generate_fake_jwt(
    payload = {},
    secret = Figaro.env.jwt_secret,
    algorithm = 'HS256'
  )
    Faker::UniqueGenerator.clear

    payload = {
      user_id: Faker::Number.unique.number(digits: 6),
      username: Faker::Internet.unique.username,
      email: Faker::Internet.unique.email
    }.merge(payload)

    JWT.encode(payload, secret, algorithm)
  end
end
