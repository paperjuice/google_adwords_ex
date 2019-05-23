defmodule AdWords.Services.V1.ManagedCustomer.Add.Args do
  @moduledoc false

  @spec build(list()) :: map()
  def build(data) do
    name = data["name"]
    currency_code = data["currency_code"]
    date_time_zone = data["date_time_zone"]

    %{
      "operations" => [
        %{
          "operator" => "ADD",
          "operand" => %{
            "name" => name,
            "currency_code" => currency_code,
            "date_time_zone" => date_time_zone
          }
        }
      ]
    }
  end
end
