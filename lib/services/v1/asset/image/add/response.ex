defmodule AdWords.Services.V1.Asset.Image.Add.Response do
  @moduledoc """
  TODO: Add documentation + response msg data structure
  """

  require AdWords.Types.AssetMessage

  alias AdWords.Services.Shared
  alias AdWords.Types.AssetMessage

  def handle_successful_response(record, conn) do
    data =
      record
      |> AssetMessage.mutate_response(:rval)
      |> AssetMessage.asset_return_value(:value)
      |> build_id_list()

    Shared.add_resp_to_conn(conn, data, 201, "add_image")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp build_id_list(asset_return_value) do
    for asset <- asset_return_value do
      %{
        "id" =>
          asset
          |> AssetMessage.image_asset(:assetId)
          |> List.to_integer()
      }
    end
  end
end
