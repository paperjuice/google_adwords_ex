defmodule AdWords.Services.V1.AdGroupAd.Ad.MultiAssetAd.Add.Response do
  @moduledoc """
  TODO: Add documentation and function and everything
  """

  require AdWords.Types.AdGroupAdMessage

  alias AdWords.Types.AdGroupAdMessage, as: AGA
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> AGA.mutate_response(:rval)
      |> AGA.ad_group_ad_return_value(:value)
      |> multi_ad_list()
      |> get_ad_id()

    Shared.add_resp_to_conn(conn, data, 201, "add_multi_asset_ad")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp multi_ad_list(list) do
    for ad <- list do
      AGA.ad_group_ad(ad, :ad)
    end
  end

  defp get_ad_id(list) do
    for multi_ad <- list do
      %{
        "id" =>
          multi_ad
          |> AGA.multi_asset_responsive_display_ad(:id)
          |> List.to_integer()
      }
    end
  end
end
