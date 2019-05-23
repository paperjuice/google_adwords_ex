defmodule AdWords.Services.V1.Budget.Get.Request do
  @moduledoc """
  Module for extracting Erlang records.
  It is used specifically for building
  body and headers for budget request.
  """

  require AdWords.Types.BudgetMessage

  alias AdWords.Types.BudgetMessage, as: BM

  @spec request_message_record(map()) :: any()
  def request_message_record(params) do
    BM.get(selector: params |> Map.get("selector") |> selector())
  end

  defp selector(selector) do
    BM.selector(
      fields: get_value(selector, "fields"),
      predicates: selector |> get_value("predicates") |> predicate(),
      dateRange: selector |> get_value("date_range") |> date_range(),
      ordering: selector |> get_value("ordering") |> order_by()
    )
  end

  defp predicate(predicates) do
    Enum.map(predicates, fn predicate ->
      BM.predicate(
        field: get_value(predicate, "field"),
        operator: get_value(predicate, "operator"),
        values: get_value(predicate, "values")
      )
    end)
  end

  defp date_range(date) do
    BM.date_range(
      min: get_value(date, "min"),
      max: get_value(date, "max")
    )
  end

  defp order_by(orderings) do
    Enum.map(orderings, fn ordering ->
      BM.order_by(
        field: get_value(ordering, "field"),
        sortOrder: get_value(ordering, "sort_order")
      )
    end)
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

  defp get_value(map, key) do
    Map.get(map, key, :undefined)
  end
end
