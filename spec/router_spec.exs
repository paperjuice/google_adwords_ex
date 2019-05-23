defmodule AdWords.RouterSpec do
  @moduledoc false

  import AdWords.Support.Factories

  alias AdWords.Router
  alias AdWords.Utils.Authenticate.OAuthTokens
  alias AdWords.Utils.Authenticate.ManageTokens

  use Plug.Test
  use ESpec

  @opts Router.init([])
  @code_url "https://server.url"
  @client_redirect "http://localhost:9999/successfully_allow"

  before do
    allow(OAuthTokens |> to(accept(:generate_token, fn -> @code_url end)))
  end

  context "routing works as expected" do
    it "routs to /auth" do
      conn =
        conn(:get, "/auth")
        |> AdWords.Router.call(@opts)

      {"location", url} =
        Enum.find(conn.resp_headers, fn tuple ->
          tuple
          |> Tuple.to_list()
          |> Enum.any?(fn item -> item == "location" end)
        end)

      expect(conn.status) |> to(eq(302))
      expect(url) |> to(eq(@code_url))
    end

    it "routs to /successfully_allow" do
      conn =
        conn(:get, "/successfully_allow")
        |> AdWords.Router.call(@opts)

      expect(conn.status) |> to(eq(200))
      expect(conn.resp_body) |> to(eq("Ad successfully accepted!"))
    end

    it "routs to /handle_code" do
      allow(
        OAuthTokens
        |> to(
          accept(:get_token!, fn ->
            :ok
          end)
        )
      )

      allow(
        ManageTokens
        |> to(
          accept(:store_tokens, fn _ ->
            :ok
          end)
        )
      )

      allow(
        ManageTokens
        |> to(
          accept(:get_token, fn _ ->
            "accesstoken"
          end)
        )
      )

      conn =
        :get
        |> conn("/handle_code")
        |> Map.put(:query_string, "code=somerandomcodelasdjf23es")
        |> AdWords.Router.call(@opts)

      {"location", url} =
        Enum.find(conn.resp_headers, fn tuple ->
          tuple
          |> Tuple.to_list()
          |> Enum.any?(fn item -> item == "location" end)
        end)

      expect(conn.status) |> to(eq(302))
      expect(url) |> to(eq(@client_redirect))
    end

    it "routs successfully to /create_image, resp 200" do
      response =
        :create_image_json_response
        |> build()
        |> Poison.encode!()

      allow(
        AdWords
        |> to(
          accept(:create_image, fn _ ->
            [11_111_111]
          end)
        )
      )

      conn =
        conn(:post, "/create_image")
        |> AdWords.Router.call(@opts)

      expect(conn.status) |> to(eq(200))
      expect(conn.resp_body) |> to(eq(response))
    end
  end

  # ---------------- UNHAPPY PATH ----------------#

  context "unhappy path" do
    it "founds no resource when no route match" do
      conn =
        conn(:get, "/peanutbutter")
        |> AdWords.Router.call(@opts)

      expect(conn.status) |> to(eq(404))
    end
  end
end
