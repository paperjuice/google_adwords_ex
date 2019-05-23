defmodule AdWords.Reporting.Plug do
  @moduledoc """
  E.g: __rdquery=SELECT CampaignId, Clicks FROM ADGROUP_PERFORMANCE_REPORT DURING TODAY&__fmt=CSV
  TODO: add doc
  """
  alias AdWords.Services.Shared
  alias NimbleCSV.RFC4180, as: CSV
  import Plug.Conn

  @time_opts ~r/[today|yesterday|last_7_days]/i
  @url "https://adwords.google.com/api/adwords/reportdownload/v201802"

  def init(opts),
    do: opts

  def call(conn, _opts) do
    conn =
      conn
      |> fetch_query_params()
      |> build_query()
      |> build_headers()

    resp =
      HTTPoison.post!(
        @url,
        conn.private.query,
        conn.private.headers
      ).body
      |> CSV.parse_string()
      |> build_resp()

    conn = Shared.add_resp_to_conn(conn, resp, 200, "report")
    json_resp = Poison.encode!(conn.private.map_resp)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_resp)
  end


  # ----------------------------------------------------------------------
  #                               PRIVATE
  # ----------------------------------------------------------------------
  # %{"attributes" => ["campaign_id", "clicks"], "time" => "20180101-20190101"}
  def build_query(conn) do
    params = conn.query_params
    attributes = build_attribute_string(params["attributes"])
    report = build_report(conn.path_params["report"])
    time = build_time(params["date"])

    query = "__rdquery=SELECT #{attributes} FROM #{report} DURING #{time}&__fmt=CSV"
    put_private(conn, :query, query)
  end


  #TODO: find out if regex is too slow
  #TODO: handle error
  defp build_attribute_string(attributes) do
    attributes
    |> String.split(",")
    |> Enum.map(fn item ->
      Macro.camelize(item)
    end)
    |> do_build_attribute_string("")
  end

  defp do_build_attribute_string([item], acc),
    do: acc <> "#{item}"

  defp do_build_attribute_string([hd|tl], acc) do
    new_string = acc <>"#{hd}, "
    do_build_attribute_string(tl, new_string)
  end

  defp build_report(report) do
    report
    |> String.upcase()
    |> Kernel.<>("_REPORT")
  end

  defp build_time(time) do
    cond do
      Regex.match?(~r/[0-9]*,[0-9]*/, time) -> time
      Regex.match?(@time_opts, time) -> String.upcase(time)
      true -> "ERROR"
    end
  end

  defp build_headers(conn) do
    token = AdWords.Utils.Authenticate.ManageTokens.get_token(:access_token)

    headers =
      [
        {"Authorization", "Bearer #{token}"},
        {"developerToken", "iPzR1KwdWAd8h8o2l31zow"},
        {"clientCustomerId", "583-421-8976"},
        {"Content-Type", "application/x-www-form-urlencoded"}
      ]

    put_private(conn, :headers, headers)
  end
  defp build_resp(list) do
    keys = hd(list)
    values = tl(list)

    Enum.reduce(values, %{"data" => [], "total" => %{}}, fn item, acc ->
      if "Total" in item do
        Map.put(acc, "total", build_total(item, keys, %{}))
      else
        list = Map.get(acc, "data")
        new_list = list ++ [build_map(item, keys, %{})]
        Map.put(acc, "data", new_list)
      end
    end)
  end

  defp build_map([], _keys, map), do: map
  defp build_map(item, keys, map) do
    key = hd(keys)
    value = hd(item)
    map = Map.put(map, key, value)

    build_map(tl(item), tl(keys), map)
  end

  #THIS: asta e ok e.g. %{"Clicks" => "0", "Conversions" => "0.00", "Cost" => "0"}
  defp build_total([], _, map), do: map
  defp build_total([item_hd|items], [key_hd|keys], map) do
    case Integer.parse(item_hd) do
      :error ->
        build_total(items, keys, map)
      _ ->
        map = Map.put(map, key_hd, item_hd)
        build_total(items, keys, map)
    end
  end
end
