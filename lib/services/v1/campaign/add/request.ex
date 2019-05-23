defmodule AdWords.Services.V1.Campaign.Add.Request do
  @moduledoc """
  Module for extracting Erlang records.
  It is used specifically for building
  body and headers for campaign creation request.
  """
  require AdWords.Types.CampaignMessage

  alias AdWords.Types.CampaignMessage, as: CM

  @spec request_message_record(map()) :: any()
  def request_message_record(params) do
    CM.mutate(
      operations: params |> get_value("operations") |> campaign_operation()
    )
  end

  defp campaign_operation(operations) do
    Enum.map(operations, fn operation ->
      CM.campaign_operation(
        operator: get_value(operation, "operator"),
        operand: get_value(operation, "operand") |> campaign()
      )
    end)
  end

  defp campaign(operand) do
    CM.campaign(
      name: get_value(operand, "name"),
      budget: operand |> get_value("budget") |> budget(),
      advertisingChannelType: get_value(operand, "advertising_channel_type"),
      biddingStrategyConfiguration:
        get_value(operand, "bidding_strategy_configuration")
        |> bidding_strategy_configuration()
    )
  end

  defp budget(budget) do
    CM.budget(budgetId: get_value(budget, "budget_id"))
  end

  defp bidding_strategy_configuration(bidding) do
    CM.bidding_strategy_configuration(
      biddingStrategyType: get_value(bidding, "bidding_strategy_type")
    )
  end

  # TODO: Add this as a common element
  def header(params) do
    CM.soap_header(
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
