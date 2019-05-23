defmodule AdWords.Types.AssetMessage do
  @moduledoc false

  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/asset.hrl"

  defrecord(
    :mutate,
    :mutate,
    extract(:mutate, from: @path)
  )

  defrecord(
    :asset_operation,
    :AssetOperation,
    extract(:AssetOperation, from: @path)
  )

  defrecord(
    :asset,
    :Asset,
    extract(:Asset, from: @path)
  )

  defrecord(
    :image_asset,
    :ImageAsset,
    extract(:ImageAsset, from: @path)
  )

  defrecord(
    :image_dimension_info,
    :ImageDimensionInfo,
    extract(:ImageDimensionInfo, from: @path)
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
    :asset_return_value,
    :AssetReturnValue,
    extract(:AssetReturnValue, from: @path)
  )
end
