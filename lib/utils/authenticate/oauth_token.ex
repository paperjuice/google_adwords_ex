defmodule AdWords.Utils.Authenticate.OAuthTokens do
  @moduledoc """
  TODO: Add doc
  """

  use OAuth2.Strategy

  @google_data Application.get_env(:ad_words, :GOOGLE)

  def generate_token do
    OAuth2.Client.authorize_url!(client_code(), scope: @google_data[:SCOPE])
  end

  def get_token! do
    OAuth2.Client.get_token!(client_token(), scope: @google_data[:SCOPE])
  end

  # ----------------
  # CALLBACKS
  # ---------------
  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client \\ [], params \\ [], headers \\ []) do
    code = Application.get_env(:ad_words, :CODE)

    client
    |> put_param(:client_secret, @google_data[:GOOGLE_SECRET])
    |> put_param(:grant_type, "authorization_code")
    |> put_param(:code, code)
    |> put_header("Content-Type", "application/x-www-form-urlencoded")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  # ----------------
  # PRIVATE
  # ----------------
  defp client_token() do
    OAuth2.Client.new(
      token_url: @google_data[:TOKEN_URL],
      client_id: @google_data[:GOOGLE_CLIENT_ID],
      site: @google_data[:SITE],
      strategy: __MODULE__,
      redirect_uri: @google_data[:REDIRECT_URI]
    )
  end

  defp client_code() do
    OAuth2.Client.new(
      strategy: __MODULE__,
      redirect_uri: @google_data[:REDIRECT_URI],
      client_id: @google_data[:GOOGLE_CLIENT_ID],
      authorize_url: @google_data[:AUTHORIZE_URL],
      params: %{
        # prompt: "consent",
        access_type: "offline"
      }
    )
  end
end

      #client_secret: @google_data[:GOOGLE_SECRET],
      #site: @google_data[:SITE],
      #token_url: @google_data[:TOKEN_URL],
