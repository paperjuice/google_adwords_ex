defmodule AdWords.Controller do
  @moduledoc """
  Common entry module for every service available
  """
  require IEx

  alias AdWords.Utils.Authenticate.ManageTokens

  @no_customer_id_list [
    AdWords.Services.V1.Customer.Get
  ]

  @google_data Application.get_env(:ad_words, :GOOGLE)

  # TODO: handle unhappy path
  @spec request(atom(), atom(), atom(), struct()) :: atom()
  def request(module, action, client, conn) do
    {request_module, response_module} = build_modules(module)

    user_data = build_user_data(conn)

    body = build_body(request_module, module, user_data)
    header = build_header(request_module, module)
    options = build_options()

    conn = Map.put(conn, :private, %{body: body, header: header, options: options})

    client
    |> apply(action, [ [body], [header], [options] ])
    |> handle_response(response_module, conn)
  end

  # ----------------
  # PRIVATE
  # ----------------
  defp build_modules(module) do
    request_module = Module.concat(module, Request)
    response_module = Module.concat(module, Response)

    {request_module, response_module}
  end

  defp build_user_data(conn) do
    cond do
      conn.params != %{} -> conn.params
      conn.query_params != %{} -> conn.query_params
      true -> %{}
    end
  end

  defp build_body(request_module, _module, user_data) when user_data == %{},
    do: request_module.request_message_record()

  defp build_body(request_module, module, user_data) do
    action_module = Module.concat(module, Args)

    user_data
    |> action_module.build()
    |> request_module.request_message_record()
  end

  defp build_header(request_module, module) do
    %{
      "developer_token" => @google_data[:DEVELOPER_TOKEN],
      "user_agent" => @google_data[:USER_AGENT],
      "validate_only" => false,
      "partial_failure" => false
    }
    |> add_customer_id(module)
    |> request_module.header()
  end

  defp add_customer_id(map, module) do
    if module in @no_customer_id_list,
      do: map,
      else: Map.put(map, "client_customer_id", @google_data[:CUSTOMER_ID])
  end

  defp build_options() do
    access_token = ManageTokens.get_token(:access_token)
    {:http_headers, [{'Authorization', 'Bearer #{access_token}'}]}
  end

  # ----------------
  # HANDLE RESPONSE
  # ----------------
  defp handle_response({:ok, _, _, _, record, _, _xml}, response_module, conn) do
    response_module.handle_successful_response(record, conn)
  end

  defp handle_response({:error, _, _, _, record, _, _}, response_module, conn) do
    response_module.handle_failed_response(record, conn)
  end

  defp handle_response(response, module, conn) do
    IO.puts("XML Unsuccessful response for #{module}: #{inspect(response)}")

    conn
  end
end
