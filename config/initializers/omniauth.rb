
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1097221353655855', '4f1d87e1a0f077e64b9f96ab1b3665dd', scope: "email,publish_actions, user_friends, user_likes, user_posts"
end

