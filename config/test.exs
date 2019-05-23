use Mix.Config

config :oauth2,
  debug: true

config :ad_words,
  GOOGLE_CLIENT_ID: "client_id",
  GOOGLE_SECRET: "secret",
  CUSTOMER_ID: "customer_id",
  SITE: "https://some.site.com",
  AUTHORIZE_URL: "https://authorize.url/oauth",
  REDIRECT_URI: "urn:redirect.url",
  TOKEN_URL: "https://token.url/token",
  DEVELOPER_TOKEN: "dev_token",
  USER_AGENT: "user_agent",
  SCOPE: "https://www.scope/auth/"
