defmodule AdWords.Services.V1.Budget.Get.Response do
  @moduledoc """
  TODO: Add documentation + response msg data structure
  """

  require AdWords.Types.BudgetMessage

  alias AdWords.Types.BudgetMessage, as: BM
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> BM.get_response(:rval)
      |> budget_page()

    Shared.add_resp_to_conn(conn, data, 200, "get_budget")
  end

  defp budget_page(record) do
    %{
      "total_num_entries" => BM.budget_page(record, :totalNumEntries) |> parse(),
      "page_type" => BM.budget_page(record, :"Page.Type") |> parse(),
      "entries" => record |> BM.budget_page(:entries) |> entries()
    }
  end

  defp entries(list) do
    Enum.map(list, fn budget ->
      %{
        "budget_id" => BM.budget(budget, :budgetId) |> parse(),
        "name" => BM.budget(budget, :name) |> parse(),
        "delivery_method" => BM.budget(budget, :deliveryMethod) |> parse(),
        "reference_count" => BM.budget(budget, :referenceCount) |> parse(),
        "is_explicitly_shared" =>
          BM.budget(budget, :isExplicitlyShared) |> parse(),
        "status" => BM.budget(budget, :status) |> parse(),
        "amount" => budget |> BM.budget(:amount) |> amount()
      }
    end)
  end

  defp amount(:undefined), do: nil

  defp amount(record) do
    %{
      "micro_amount" => BM.money(record, :microAmount) |> parse()
    }
  end

  defp parse(value) do
    cond do
      is_list(value) -> List.to_string(value)
      value == :undefined -> nil
      true -> value
    end
  end
end
