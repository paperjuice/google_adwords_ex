defmodule AdWords.Support.Factories.Services.AddBudget do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def add_budget_params_factory do
        %{
          "operations" => [
            %{
              "operator" => "ADD",
              "operand" => %{
                "name" => "BudgetName01",
                "delivery_method" => "STANDARD",
                "amount" => %{
                  "micro_amount" => "1000000"
                }
              }
            }
          ]
        }
      end

      def add_budget_google_response_factory do
        %{
          "record" =>
            {:mutateResponse,
             {:BudgetReturnValue, 'BudgetReturnValue',
              [
                {:Budget, '1664061346', 'BudgetName04',
                 {:Money, 'Money', '1000000'}, 'STANDARD', :undefined, true,
                 'ENABLED'}
              ], :undefined}}
        }
      end

      def add_budget_response_factory do
        [
          %{
            "amount" => %{"micro_amount" => "1000000"},
            "budget_id" => "1664061346",
            "delivery_method" => "STANDARD",
            "is_explicitly_shared" => true,
            "name" => "BudgetName04",
            "reference_count" => nil,
            "status" => "ENABLED"
          }
        ]
      end
    end
  end
end
