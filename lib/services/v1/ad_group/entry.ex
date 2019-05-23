defmodule AdWords.Services.V1.AdGroup.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  Add a new ad_group
  ## Example data:
  %{
    "name" => "AdGroupName01",
    "campaign_id" => "1614670930",
    "status" => "ENABLED"
  }
  """
  @spec add(map()) :: list()
  def add(conn) do
    Controller.request(
      @base.AdGroup.Add,
      :mutate,
      :ad_group_service_client,
      conn
    )
  end
end
