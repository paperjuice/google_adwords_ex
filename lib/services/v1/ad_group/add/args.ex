defmodule AdWords.Services.V1.AdGroup.Add.Args do
  @moduledoc false

  @spec build(list()) :: map()
  def build(data) do
    campaign_id = data["campaign_id"]
    name = data["name"]
    status = data["status"]

    %{
      "operations" => [
        %{
          "operator" => "ADD",
          "operand" => %{
            "campaign_id" => campaign_id,
            "name" => name,
            "status" => status
          }
        }
      ]
    }
  end
end
