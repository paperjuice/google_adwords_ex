defmodule AdWords.Services.V1.Budget.Add.Request do
  @moduledoc """
  Module for extracting Erlang records.
  It is used specifically for building
  body and headers for budget request.
  """

  require AdWords.Types.BudgetMessage

  alias AdWords.Types.BudgetMessage, as: BM

  @spec request_message_record(map()) :: any()
  def request_message_record(params) do
    BM.mutate(operations: params |> get_value("operations") |> budget_operation())
  end

  defp budget_operation(operations) do
    Enum.map(operations, fn operation ->
      BM.budget_operation(
        operator: get_value(operation, "operator"),
        operand: operation |> get_value("operand") |> budget()
      )
    end)
  end

  defp budget(operand) do
    BM.budget(
      name: get_value(operand, "name"),
      deliveryMethod: get_value(operand, "delivery_method"),
      amount: operand |> get_value("amount") |> amount()
    )
  end

  defp amount(amount) do
    BM.money(microAmount: get_value(amount, "micro_amount"))
  end

  def header(params) do
    BM.soap_header(
      clientCustomerId: Map.get(params, "client_customer_id", :undefined),
      developerToken: Map.get(params, "developer_token", :undefined),
      userAgent: Map.get(params, "user_agent", :undefined),
      validateOnly: Map.get(params, "validate_only", :undefined),
      partialFailure: Map.get(params, "partial_failure", :undefined)
    )
  end

  defp get_value(map, key),
    do: Map.get(map, key, :undefined)
end
