defmodule AdWords.Types.AdGroupMessage do
  @moduledoc false
  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/ad_group.hrl"

  defrecord(
    :mutate,
    :mutate,
    extract(:mutate, from: @path)
  )

  defrecord(
    :ad_group_operation,
    :AdGroupOperation,
    extract(:AdGroupOperation, from: @path)
  )

  defrecord(
    :ad_group,
    :AdGroup,
    extract(:AdGroup, from: @path)
  )

  defrecord(
    :ad_group_ad_rotation_mode,
    :AdGroupAdRotationMode,
    extract(:AdGroupAdRotationMode, from: @path)
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
    :ad_group_return_value,
    :AdGroupReturnValue,
    extract(:AdGroupReturnValue, from: @path)
  )
end
