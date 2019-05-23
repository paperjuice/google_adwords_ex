defmodule AdWords.Types.CustomerMessage do
  @moduledoc false
  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/customer.hrl"

  defrecord(
    :get_customers,
    :getCustomers,
    extract(:getCustomers, from: @path)
  )

  defrecord(
    :soap_header,
    :SoapHeader,
    extract(:SoapHeader, from: @path)
  )

  defrecord(
    :get_customers_response,
    :getCustomersResponse,
    extract(:getCustomersResponse, from: @path)
  )

  defrecord(
    :customer,
    :Customer,
    extract(:Customer, from: @path)
  )
end
