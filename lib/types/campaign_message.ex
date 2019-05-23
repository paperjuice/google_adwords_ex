defmodule AdWords.Types.CampaignMessage do
  @moduledoc false
  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/campaign.hrl"

  defrecord(
    :mutate,
    :mutate,
    extract(:mutate, from: @path)
  )

  defrecord(
    :campaign_operation,
    :CampaignOperation,
    extract(:CampaignOperation, from: @path)
  )

  defrecord(
    :campaign,
    :Campaign,
    extract(:Campaign, from: @path)
  )

  defrecord(
    :bidding_strategy_configuration,
    :BiddingStrategyConfiguration,
    extract(:BiddingStrategyConfiguration, from: @path)
  )

  defrecord(
    :budget,
    :Budget,
    extract(:Budget, from: @path)
  )

  defrecord(
    :soap_header,
    :SoapHeader,
    extract(:SoapHeader, from: @path)
  )

  defrecord(
    :mutate_response,
    :mutateResponse,
    extract(:mutateResponse, from: @path)
  )

  defrecord(
    :campaign_return_value,
    :CampaignReturnValue,
    extract(:CampaignReturnValue, from: @path)
  )
end
