defmodule AdWords.Support.Factories.Utils.GenerateHrl do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def generate_hrl_opts_factory do
        %{
          service: "AssetService",
          port: "AssetServiceInterfacePort",
          generate: :client,
          generate_tests: :none,
          namespaces_url: "https://adwords.google.com/api/adwords/cm/v201806",
          namespace_prefix: :undefined,
          http_server: :soap_server_cowboy_2,
          server_name: :undefined,
          http_client: :soap_client_inets,
          client_name: "asset_client",
          strict: true
        }
      end
    end
  end
end
