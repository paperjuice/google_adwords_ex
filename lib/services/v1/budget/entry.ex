defmodule AdWords.Services.V1.Budget.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  Add a new budget
  ## Example data:
  %{
    "name" => "BudgetName01",
    "micro_amount" => "1000000"
  }
  """
  @spec add(map()) :: list()
  def add(conn) do
    Controller.request(
      @base.Budget.Add,
      :mutate,
      :budget_service_client,
      conn
    )
  end

  # TODO: Still in progress!
  @doc """
  Get budgets
  ## Example data:
    %{
      "selector" =>
      %{
        "fields" => ["BudgetName"],
        "data_range" => %{
          "min" => "19700101",
          "max" => "20380101"
        },
        "predicates" => [
          %{
            "field" => "name",
            "operator" => "NOT_EQUALS",
            "values" => "McDonaldsBudget"
          }
        ],
        "ordering" => [
          %{
            "fields" => ["name"],
            "sord_order" => "DESCENDING"
          }
        ]
      }
    }
  """
  @spec get(map()) :: list()
  def get(conn) do
    Controller.request(
      @base.Budget.Get,
      :get,
      :budget_service_client,
      conn
    )
  end
end
