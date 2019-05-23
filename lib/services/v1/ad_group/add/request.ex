defmodule AdWords.Services.V1.AdGroup.Add.Request do
  @moduledoc """
  Module for extracting Erlang records.
  It is used specifically for building
  body and headers for ad_group request.

  TODO: Look into bids and contentBidCriterionTypeGroup
  """

  require AdWords.Types.AdGroupMessage

  alias AdWords.Types.AdGroupMessage, as: AG

  @spec request_message_record(map()) :: any()
  def request_message_record(params) do
    AG.mutate(operations: params |> get_value("operations") |> group_operation())
  end

  defp group_operation(operations) do
    Enum.map(operations, fn operation ->
      AG.ad_group_operation(
        operator: get_value(operation, "operator"),
        operand: operation |> get_value("operand") |> group()
      )
    end)
  end

  defp group(operand) do
    AG.ad_group(
      campaignId: get_value(operand, "campaign_id"),
      name: get_value(operand, "name"),
      status: get_value(operand, "status")
    )
  end

  def header(params) do
    AG.soap_header(
      clientCustomerId: Map.get(params, "client_customer_id", :undefined),
      developerToken: Map.get(params, "developer_token", :undefined),
      userAgent: Map.get(params, "user_agent", :undefined),
      validateOnly: Map.get(params, "validate_only", :undefined),
      partialFailure: Map.get(params, "partial_failure", :undefined)
    )
  end

  defp get_value(map, key),
    do: Map.get(map, key, :undefined)
end
