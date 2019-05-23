defmodule AdWords.Services.V1.Campaign.Add.Response do
  @moduledoc """
  TODO: Add documentation + response msg data structure
  """

  require AdWords.Types.CampaignMessage

  alias AdWords.Types.CampaignMessage, as: CM
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> CM.mutate_response(:rval)
      |> CM.campaign_return_value(:value)
      |> campaign()

    Shared.add_resp_to_conn(conn, data, 201, "add_campaign")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp campaign(values) do
    value = hd(values)

    %{
      "id" => CM.campaign(value, :id) |> parse(),
      "campaign_group_id" => CM.campaign(value, :campaignGroupId) |> parse(),
      "name" => CM.campaign(value, :name) |> parse(),
      "start_date" => CM.campaign(value, :startDate) |> parse(),
      "status" => CM.campaign(value, :status) |> parse()
    }
  end

  defp parse(value) do
    cond do
      is_list(value) -> List.to_string(value)
      value == :undefined -> nil
      true -> value
    end
  end
end
