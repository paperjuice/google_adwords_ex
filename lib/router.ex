defmodule AdWords.Router do
  @moduledoc false

  use Plug.Router

  alias AdWords.Utils.Authenticate.ManageTokens
  alias AdWords.Utils.Authenticate.OAuthTokens

  @client_redirect "http://localhost:9999/successfully_allow"

  plug(:match)
  plug(:dispatch)

  forward(
    "/swagger",
    to: PhoenixSwagger.Plug.SwaggerUI,
    init_opts: [otp_app: :ad_words, swagger_file: "swagger.yml"]
  )

  # ----------------------------------------------------------------------
  #                               AUTHORIZE
  # ----------------------------------------------------------------------
  # The client can use this route to redirect the
  # user to a OAauth generated link where it is
  # promped to allow GoogleMulti app to manage
  # their campaign.
  get "/auth" do
    url = OAuthTokens.generate_token()

    conn
    |> put_resp_header("location", url)
    |> send_resp(302, "Google Allow page")
  end

  # Once the permission is granted, Google API
  # redirects the response to this route where
  # we handle the received code.
  # TODO: move this in its own module
  get "/handle_code" do
    code = get_code(conn)
    Application.put_env(:ad_words, :CODE, code)

    OAuthTokens.get_token!()
    |> ManageTokens.store_tokens()

    token = ManageTokens.get_token(:access_token)

    conn
    |> put_resp_header("location", @client_redirect)
    |> send_resp(302, "Access token: #{token}")
  end

  # After the response code is handled and tokens
  # generated, we direct the user to the client
  # page.
  # TODO: more this in its own module
  get "/successfully_allow" do
    #send_resp(conn, 200, "Ad successfully accepted!")
    conn
    |> put_resp_header("location", "http://hello.me")
    |> send_resp(302, "Google Allow page")
  end

  # ----------------------------------------------------------------------
  #                               FORWARD
  # ----------------------------------------------------------------------
  forward("/v1", to: AdWords.Api.V1)
  forward("/", to: AdWords.Api.V1)

  # ----------------------------------------------------------------------
  #                               PRIVATE
  # ----------------------------------------------------------------------
  defp get_code(conn), do: String.replace(conn.query_string, "code=", "")
end
