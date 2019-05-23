defmodule AdWords.Support.Factories.Utils.OAuthTokens do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def oauth_tokens_get_token_resp_factory do
        %{
          token: %{
            :access_token => "access_token_string",
            :refresh_token => "refresh_token_string",
            :issued_at => "2018-08-18 23:58:29 +0200",
            :expires_in => 3600,
            :id_token => nil
          }
        }
      end

      def oauth_tokens_refresh_token_resp_factory do
        %{
          token: %{
            :access_token => "access_token_string",
            :issued_at => "2018-08-18 23:58:29 +0200",
            :expires_in => 3600,
            :id_token => nil
          }
        }
      end

      def oauth_client_factory do
        %OAuth2.Client{
          authorize_url: nil,
          client_id: nil,
          client_secret: nil,
          headers: [{"content-type", "application/x-www-form-urlencoded"}],
          params: %{
            "client_id" => nil,
            "client_secret" => nil,
            "code" => "some_random_string",
            "grant_type" => "authorization_code",
            "redirect_uri" => nil,
            "scope" => nil
          },
          redirect_uri: nil,
          ref: nil,
          request_opts: [],
          site: nil,
          strategy: AdWords.Utils.Authenticate.OAuthTokens,
          token: nil,
          token_method: :post,
          token_url: nil
        }
      end

      def authorize_url_response_factory do
        %OAuth2.Client{
          authorize_url: "https://accounts.google.com/o/oauth2/auth",
          client_id: "some_random_string",
          client_secret: "client_super_secret",
          headers: [],
          params: %{
            "client_id" => "bunch_of_numbers",
            "redirect_uri" => "http://redirect.uri",
            "response_type" => "code",
            "scope" => "https://www.googleapis.com/auth/adwords"
          },
          redirect_uri: "http://redirect.me",
          ref: nil,
          request_opts: [],
          site: "https://accounts.google.com",
          strategy: AdWords.Utils.Authenticate.OAuthTokens,
          token: nil,
          token_method: :post,
          token_url: "https://www.googleapis.com/oauth2/v3/token"
        }
      end
    end
  end
end
