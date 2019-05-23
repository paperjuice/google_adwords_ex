defmodule AdWords.Services.V1.Campaign.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  Add a new campaign
  ## Example data:
    %{
      "name" => "CampaignName01",
      "advertising_channel_type" => "DISPLAY",
      "budget" => {
        "budget_id" => "1664061346"
      },
      "bidding_strategy_configuration" => {
        "bidding_strategy_type" => "MANUAL_CPC"
      }
    }
  """
  @spec add(map()) :: list()
  def add(conn) do
    Controller.request(
      @base.Campaign.Add,
      :mutate,
      :campaign_service_client,
      conn
    )
  end
end
