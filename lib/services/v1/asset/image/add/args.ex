defmodule AdWords.Services.V1.Asset.Image.Add.Args do
  @moduledoc false

  @spec build(list()) :: map()
  def build(data) do
    %{
      "operations" => build_operations(data["assets"])
    }
  end

  # ----------------------------------------------------------------------
  #                               PRIVATE
  # ----------------------------------------------------------------------
  defp build_operations(operations) do
    Enum.map(operations, fn operation ->
      %{
        "operator" => "ADD",
        "operation_type" => "ImageAsset",
        "operand" => %{
          "asset_subtype" => "IMAGE",
          "asset_name" => Map.get(operation, "asset_name", :undefined),
          "asset_status" => "ENABLED",
          "image_url" => Map.get(operation, "image_url", :undefined)
        }
      }
      end)
  end
end
