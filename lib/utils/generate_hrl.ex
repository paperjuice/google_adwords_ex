defmodule AdWords.Utils.GenerateHrl do
  @moduledoc """
  TODO: Add documentation on what the options are doing
  """

  alias :soap, as: Soap

  @type options :: %{
          service: String.t(),
          port: String.t(),
          generate: atom(),
          generate_tests: atom(),
          namespaces_url: String.t(),
          namespace_prefix: atom(),
          http_server: atom(),
          server_name: String.t(),
          http_client: atom(),
          client_name: String.t(),
          strict: atom()
        }

  @wsdl_file "priv/ad_group.wsdl"
  @default %{
    service: "AdGroupService",
    port: "AdGroupServiceInterfacePort",
    generate: :client,
    generate_tests: :none,
    namespaces_url: "https://adwords.google.com/api/adwords/cm/v201809",
    namespace_prefix: :undefined,
    http_server: :soap_server_cowboy_2,
    server_name: :undefined,
    http_client: :soap_client_inets,
    client_name: "ad_group_service_client",
    strict: true
  }

  @spec wsdl_to_erlang(String.t(), options()) :: :ok | {:error, any()}
  def wsdl_to_erlang(wsdl_file \\ @wsdl_file, opts \\ @default) do
    options = [
      {:service, opts.service |> String.to_charlist()},
      {:port, opts.port |> String.to_charlist()},
      {:generate, opts.generate},
      {:generate_tests, opts.generate_tests},
      {:namespaces,
       [
         {opts.namespaces_url |> String.to_charlist(), opts.namespace_prefix}
       ]},
      {:http_server, opts.http_server},
      {:server_name, opts.server_name},
      {:http_client, opts.http_client},
      {:client_name, opts.client_name |> String.to_charlist()},
      {:strict, opts.strict}
    ]

    wsdl_file = String.to_charlist(wsdl_file)
    Soap.wsdl2erlang(wsdl_file, options)

    move_files("hrl", "include")
    move_files("erl", "src")
  end

  defp move_files(extension, dest) do
    {ls, _} = System.cmd("ls", [])
    list = Regex.run(~r/[a-z\_]*.#{extension}/, ls)

    if list != nil do
      for item <- list do
        File.rename(item, "#{dest}/#{item}")
      end
    else
      IO.puts(
        "No files in the directory root found with the #{extension} extension."
      )
    end
  end
end
