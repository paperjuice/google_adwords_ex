defmodule AdWords.Services.V1.Budget.Add.Args do
  @moduledoc false

  @spec build(list()) :: map()
  def build(data) do
    name = data["name"]
    micro_amount = data["micro_amount"]

    %{
      "operations" => [
        %{
          "operator" => "ADD",
          "operand" => %{
            "name" => name,
            "amount" => %{
              "micro_amount" => micro_amount
            }
          }
        }
      ]
    }
  end
end
