defmodule AdWords.Services.V1.ManagedCustomer.Add.Request do
  @moduledoc """
  TODO: Add documentation
  """

  require AdWords.Types.ManagedCustomerMessage

  alias AdWords.Types.ManagedCustomerMessage, as: MCM

  # TODO: Add comprehensive spec attribute
  @spec request_message_record(map()) :: tuple()
  def request_message_record(params) do
    MCM.mutate(operations: params |> get_value("operations") |> operations())
  end

  defp operations(operations) do
    Enum.map(operations, fn operation ->
      MCM.managed_customer_operation(
        operator: get_value(operation, "operator"),
        operand: operation |> get_value("operand") |> managed_customer()
      )
    end)
  end

  defp managed_customer(operand) do
    MCM.managed_customer(
      name: get_value(operand, "name"),
      currencyCode: get_value(operand, "currency_code"),
      dateTimeZone: get_value(operand, "date_time_zone")
    )
  end

  defp get_value(map, key),
    do: Map.get(map, key, :undefined)

  def header(params) do
    MCM.soap_header(
      clientCustomerId: Map.get(params, "client_customer_id", :undefined),
      developerToken: Map.get(params, "developer_token", :undefined),
      userAgent: Map.get(params, "user_agent", :undefined),
      validateOnly: Map.get(params, "validate_only", :undefined),
      partialFailure: Map.get(params, "partial_failure", :undefined)
    )
  end
end
