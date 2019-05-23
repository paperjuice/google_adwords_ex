use Mix.Config

config :ad_words,
  GOOGLE: %{
    GOOGLE_CLIENT_ID: System.get_env("GOOGLE_CLIENT_ID"),
    GOOGLE_SECRET: System.get_env("GOOGLE_SECRET"),
    CUSTOMER_ID: System.get_env("CUSTOMER_ID"),
    SITE: System.get_env("SITE"),
    AUTHORIZE_URL: System.get_env("AUTHORIZE_URL"),
    REDIRECT_URI: System.get_env("REDIRECT_URI"),
    TOKEN_URL: System.get_env("TOKEN_URL"),
    DEVELOPER_TOKEN: System.get_env("DEVELOPER_TOKEN"),
    USER_AGENT: System.get_env("USER_AGENT"),
    SCOPE: System.get_env("SCOPE")
  }
