defmodule AdWords.Services.Shared do
  @moduledoc """
  TODO: Add description
  """

  import Plug.Conn

  def add_resp_to_conn(conn, data, code, type) do
    resp = %{
      "success" => true,
      "code" => code,
      "data" => %{
        "type" => type,
        "attributes" => data
      }
    }

   put_private(conn, :map_resp, resp)
  end
end
