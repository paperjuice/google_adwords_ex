defmodule AdWords.Services.V1.AdGroupAd.Ad.MultiAssetAd.Add.Args do
  @moduledoc """
  TODO: Add doc
  """

  @spec build(map()) :: map()
  def build(data) do
    %{
      "operations" => [
        %{
          "operator" => "ADD",
          "operand" => %{
            "ad_group_id" => get(data, "ad_group_id"),
            "ad" => %{
              "multi_asset_ad" => %{
                "accent_color" => get(data, "accent_color"),
                "ad_type" => "MultiAssetResponsiveDisplayAd",
                "allow_flexible_color" => get(data, "allow_flexible_color"),
                "business_name" => get(data, "business_name"),
                "call_to_action_text" => get(data, "call_to_action_text"),
                "descriptions" => data |> get("descriptions") |> text_assets(),
                "final_urls" => get(data, "final_urls"),
                "display_url" => get(data, "display_url"),
                "format_setting" => get(data, "format_setting"),
                "headlines" => data |> get("headlines") |> text_assets(),
                "logo_images" => data |> get("logo_images") |> image_assets(),
                "long_headline" => data |> get("long_headline") |> text_asset(),
                "main_color" => get(data, "main_color"),
                "marketing_images" =>
                  data
                  |> get("marketing_images")
                  |> image_assets(),
                "square_marketing_images" =>
                  data
                  |> get("square_marketing_images")
                  |> image_assets()
              }
            }
          }
        }
      ]
    }
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp text_assets(:undefined), do: :undefined

  defp text_assets(list) do
    Enum.map(list, fn text ->
      %{
        "asset" => %{
          "text_asset" => %{
            "asset_text" => text
          }
        }
      }
    end)
  end

  defp image_assets(:undefined), do: :undefined

  defp image_assets(list) do
    Enum.map(list, fn id ->
      %{
        "asset" => %{
          "image_asset" => %{
            "asset_id" => id
          }
        }
      }
    end)
  end

  defp text_asset(:undefined), do: :undefined

  defp text_asset(text) do
    %{
      "asset" => %{
        "text_asset" => %{
          "asset_text" => text
        }
      }
    }
  end

  def get(data, key),
    do: Map.get(data, key, :undefined)
end
