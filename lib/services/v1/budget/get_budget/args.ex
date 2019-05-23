defmodule AdWords.Services.V1.Budget.Get.Args do
  @moduledoc false

  @spec build(list()) :: map()
  def build(_data) do
    %{
      "selector" => %{
        "fields" => ["BudgetName", "BudgetId", "Amount"],
        "date_range" => %{
          "min" => "20180101",
          "max" => "20181201"
        },
        "predicates" => [
          %{
            "field" => "BudgetName",
            "operator" => "EQUALS",
            "values" => ["BudgetName05"]
          }
        ],
        "ordering" => [
          %{
            "field" => "BudgetId",
            "sord_order" => "ASCENDING"
          }
        ]
      }
    }
  end
end
