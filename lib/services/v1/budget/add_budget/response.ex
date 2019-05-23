defmodule AdWords.Services.V1.Budget.Add.Response do
  @moduledoc """
  TODO: Add documentation + response msg data structure
  """

  require AdWords.Types.BudgetMessage

  alias AdWords.Types.BudgetMessage, as: BM
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> BM.mutate_response(:rval)
      |> BM.budget_return_value(:value)
      |> build_budget_list()

    Shared.add_resp_to_conn(conn, data, 201, "add_budget")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp build_budget_list(values) do
    value = hd(values)

    %{
      "budget_id" => BM.budget(value, :budgetId) |> parse(),
      "name" => BM.budget(value, :name) |> parse(),
      "delivery_method" => BM.budget(value, :deliveryMethod) |> parse(),
      "reference_count" => BM.budget(value, :referenceCount) |> parse(),
      "is_explicitly_shared" =>
      BM.budget(value, :isExplicitlyShared) |> parse(),
      "status" => BM.budget(value, :status) |> parse(),
      "amount" => value |> BM.budget(:amount) |> money()
    }
  end

  defp money(amount) do
    %{
      "micro_amount" => BM.money(amount, :microAmount) |> parse()
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
