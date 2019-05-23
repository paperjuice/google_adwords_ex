defmodule AdWords.Authenticate.OAuthTokensSpec do
  @moduledoc false

  use ESpec

  import AdWords.Support.Factories

  alias AdWords.Utils.Authenticate.{
    OAuthTokens,
    ManageTokens
  }

  let(:oauth_tokens_get_token_resp, do: build(:oauth_tokens_get_token_resp))

  let(:oauth_tokens_refresh_token_resp,
    do: build(:oauth_tokens_refresh_token_resp)
  )

  before do
    allow(
      System
      |> to(
        accept(:cmd, fn _command, _list ->
          :ok
        end)
      )
    )

    allow(
      OAuth2.Client
      |> to(
        accept(:get_token!, fn _client, _scope ->
          oauth_tokens_get_token_resp()
        end)
      )
    )

    allow(
      OAuth2.Client
      |> to(
        accept(:authorize_url!, fn _client, _params ->
          "http://test.url/somerandomcode"
        end)
      )
    )

    allow(
      OAuth2.Client
      |> to(
        accept(:get_token!, fn _, _client ->
          :ok
        end)
      )
    )

    allow(
      OAuth2.Strategy.AuthCode
      |> to(
        accept(:get_token, fn _client, _params, _headers ->
          build(:oauth_client)
        end)
      )
    )

    allow(
      OAuth2.Strategy.AuthCode
      |> to(
        accept(:authorize_url, fn _client, _params ->
          build(:authorize_url_response)
        end)
      )
    )

    allow(
      OAuth2.Client
      |> to(
        accept(:new, fn _s, _ci, _cs, _si, _au, _tu, _p ->
          oauth_tokens_refresh_token_resp()
        end)
      )
    )

    allow(
      ManageTokens
      |> to(
        accept(:store_token, fn _test_token, _resp ->
          passthrough([:test_token, "refresh_token_string"])
        end)
      )
    )
  end

  context "Happy path for handle tokens" do
    it "returns url when requesting authorization" do
      actual = OAuthTokens.generate_token()

      expect(actual) |> to(eq("http://test.url/somerandomcode"))
    end

    it "returns access token" do
      Application.put_env(:ad_words, :CODE, "some_random_string")
      actual = OAuthTokens.get_token!()

      expect(actual) |> to(eq(:ok))
    end
  end
end
