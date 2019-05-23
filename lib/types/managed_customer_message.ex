defmodule AdWords.Types.ManagedCustomerMessage do
  @moduledoc false
  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/managed_customer.hrl"

  defrecord(
    :mutate,
    :mutate,
    extract(:mutate, from: @path)
  )

  defrecord(
    :managed_customer_operation,
    :ManagedCustomerOperation,
    extract(:ManagedCustomerOperation, from: @path)
  )

  defrecord(
    :managed_customer,
    :ManagedCustomer,
    extract(:ManagedCustomer, from: @path)
  )

  defrecord(
    :account_label,
    :AccountLabel,
    extract(:AccountLabel, from: @path)
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
    :managed_customer_return_value,
    :ManagedCustomerReturnValue,
    extract(:ManagedCustomerReturnValue, from: @path)
  )
end
