defmodule AdWords.Api.V1 do
  @moduledoc """
  TODO: Add doc
  """
  use Plug.Router

  @base_module AdWords.Services
  @version V1
  @sufix Entry

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*", "application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  # ----------------------------------------------------------------------
  #                              ROUTES
  # ----------------------------------------------------------------------
  # add options
  get("/report/:report", to: AdWords.Reporting.Plug)
  post(_, do: handle_request(conn))
  get(_, do: handle_request(conn))

  # ----------------------------------------------------------------------
  #                               PRIVATE
  # ----------------------------------------------------------------------
  defp handle_request(conn) do
    [main_module | func_name_list] = conn.path_params["glob"]

    module = build_module_name(main_module)
    function = build_function_name(func_name_list, conn.method)

    conn = apply(module, function, [conn])

    json_resp = Poison.encode!(conn.private.map_resp)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(201, json_resp)
  end

  defp build_module_name(main_module) do
    up_case = Macro.camelize(main_module)

    Module.concat([@base_module, @version, up_case, @sufix])
  end

  defp build_function_name(func_name_list, http_method) do
    method = translate_http_method(http_method)

    func_name_list
    |> Enum.reduce(method, fn item, acc ->
      acc <> "_#{item}"
    end)
    |> String.to_atom()
  end

  defp translate_http_method(http_method) do
    case http_method do
      "GET" -> "get"
      "POST" -> "add"
      "DELETE" -> "remove"
      "UPDATE" -> "set"
    end
  end
end
