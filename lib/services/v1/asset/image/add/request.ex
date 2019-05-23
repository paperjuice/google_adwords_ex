defmodule AdWords.Services.V1.Asset.Image.Add.Request do
  @moduledoc """
  Module for extracting Erlang records.
  It is used specifically for building
  body and headers for image creation request.
  """

  require AdWords.Types.AssetMessage

  alias AdWords.Types.AssetMessage

  @type operator :: String.t()
  @type operation_type :: String.t()
  @type operand :: String.t()
  @type asset_id :: Stirng.t()
  @type asset_name :: Stirng.t()
  @type asset_subtype :: Stirng.t()
  @type asset_status :: Stirng.t()
  @type asset_type :: Stirng.t()
  @type image_data :: Stirng.t()
  @type image_file_size :: Stirng.t()
  @type image_mime_type :: Stirng.t()
  @type full_size_info :: String.t()
  @type image_height :: String.t()
  @type image_width :: String.t()
  @type image_url :: String.t()

  @type parameters :: %{
          operator => String.t() | atom(),
          operation_type => String.t() | atom(),
          operand => image_asset() | atom()
        }

  @type image_asset :: %{
          asset_id => String.t() | atom(),
          asset_name => String.t() | atom(),
          asset_subtype => String.t() | atom(),
          asset_status => String.t() | atom(),
          asset_type => String.t() | atom(),
          image_data => String.t() | atom(),
          image_file_size => String.t() | atom(),
          image_mime_type => String.t() | atom(),
          full_size_info => full_size_info_data() | atom()
        }

  @type full_size_info_data :: %{
          image_height => integer() | atom(),
          image_width => integer() | atom(),
          image_url => String.t() | atom()
        }

  @spec request_message_record(parameters()) :: any()
  def request_message_record(params) do
    parameters = add_image_data(params)

    AssetMessage.mutate(
      operations:
        parameters |> Map.get("operations", :undefined) |> asset_operation()
    )
  end

  def asset_operation(:undefined), do: :undefined

  def asset_operation(operations) do
    Enum.map(operations, fn map ->
      AssetMessage.asset_operation(
        operator: Map.get(map, "operator", :undefined),
        "Operation.Type": Map.get(map, "operation_type", :undefined),
        operand: map |> Map.get("operand", :undefined) |> image_asset()
      )
    end)
  end

  def image_asset(:undefined), do: :undefined

  def image_asset(image_asset) do
    AssetMessage.image_asset(
      assetId: Map.get(image_asset, "asset_id", :undefined),
      assetName: Map.get(image_asset, "asset_name", :undefined),
      assetSubtype: Map.get(image_asset, "asset_subtype", :undefined),
      assetStatus: Map.get(image_asset, "asset_status", :undefined),
      "Asset.Type": Map.get(image_asset, "asset_type", :undefined),
      imageData: Map.get(image_asset, "image_data", :undefined),
      imageFileSize: Map.get(image_asset, "image_file_size", :undefined),
      imageMimeType: Map.get(image_asset, "image_mime_type", :undefined),
      fullSizeInfo:
        image_asset |> Map.get("full_size_info", :undefined) |> full_size_info()
    )
  end

  def full_size_info(:undefined), do: :undefined

  def full_size_info(full_size_info) do
    AssetMessage.image_dimension_info(
      imageHeight: Map.get(full_size_info, "image_height", :undefined),
      imageWidth: Map.get(full_size_info, "image_width", :undefined),
      imageUrl: Map.get(full_size_info, "image_url", :undefined)
    )
  end

  def header(params) do
    AssetMessage.soap_header(
      clientCustomerId: Map.get(params, "client_customer_id", :undefined),
      developerToken: Map.get(params, "developer_token", :undefined),
      userAgent: Map.get(params, "user_agent", :undefined),
      validateOnly: Map.get(params, "validate_only", :undefined),
      partialFailure: Map.get(params, "partial_failure", :undefined)
    )
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp add_image_data(parameters) do
    operations = Map.get(parameters, "operations", :undefined)

    # TODO: Handle unhappy path
    list =
      Enum.map(operations, fn map ->
        image_data =
          map
          |> get_in(["operand", "image_url"])
          |> HTTPoison.get!()
          |> picture_data_to_base64()

        Kernel.put_in(map, ["operand", "image_data"], image_data)
      end)

    Map.put(parameters, "operations", list)
  end

  defp picture_data_to_base64(response),
    do: Base.encode64(response.body)
end
