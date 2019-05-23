# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :oauth2,
  serializers: %{
    "application/json" => Poison,
    "text/html" => AdWords.Utils.Authenticate.TextHtmlSerializer
  },
  debug: true

if Mix.env() == :test,
  do: import_config("#{Mix.env()}.exs"),
  else: import_config("authenticate.exs")
