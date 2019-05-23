defmodule AdWords.Services.V1.AdGroup.Add.Response do
  @moduledoc """
  TODO: Add documentation + response msg data structure
  """

  require AdWords.Types.AdGroupMessage

  alias AdWords.Types.AdGroupMessage, as: AG
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> AG.mutate_response(:rval)
      |> AG.ad_group_return_value(:value)
      |> ad_group()

    Shared.add_resp_to_conn(conn, data, 201, "add_ad_group")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp ad_group(values) do
    value = hd(values)

    %{
      "id" => AG.ad_group(value, :id) |> parse(),
      "campaign_id" => AG.ad_group(value, :campaignId) |> parse(),
      "campaign_name" => AG.ad_group(value, :campaignName) |> parse(),
      "name" => AG.ad_group(value, :name) |> parse(),
      "status" => AG.ad_group(value, :status) |> parse(),
      "content_bid_criterion_type_group" =>
      AG.ad_group(value, :contentBidCriterionTypeGroup) |> parse(),
      "base_campaign_id" => AG.ad_group(value, :baseCampaignId) |> parse(),
      "base_ad_group_id" => AG.ad_group(value, :baseAdGroupId) |> parse(),
      "tracking_url_template" =>
      AG.ad_group(value, :trackingUrlTemplate) |> parse()
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
