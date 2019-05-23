defmodule AdWords.Services.V1.Campaign.Add.Args do
  @moduledoc false

  @spec build(list()) :: map()
  def build(data) do
    name = data["name"]
    budget_id = data["budget"]["budget_id"]
    advertising_channel_type = data["advertising_channel_type"]

    bidding_strategy_type =
      data["bidding_strategy_configuration"]["bidding_strategy_type"]

    %{
      "operations" => [
        %{
          "operator" => "ADD",
          "operand" => %{
            "name" => name,
            "budget" => %{
              "budget_id" => budget_id
            },
            "advertising_channel_type" => advertising_channel_type,
            "bidding_strategy_configuration" => %{
              "bidding_strategy_type" => bidding_strategy_type
            }
          }
        }
      ]
    }
  end
end
