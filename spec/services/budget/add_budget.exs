defmodule AdWords.Services.Budget.AddBudget do
  @moduledoc false

  use ESpec

  import AdWords.Support.Factories

  let(:add_budget_response) do
    build(:add_budget_response)["record"]
  end

  let(:add_budget_google_response) do
    build(:add_budget_google_response)["record"]
  end

  context "Happy path for add budget" do
    before do
      allow(
        :budget_service_client
        |> to(
          accept(
            :mutate,
            fn _body, _header, _opts ->
              {:ok, 200, [], [], add_budget_google_response(), [], "xml"}
            end
          )
        )
      )
    end

    it "returns successful response when valid data is used" do
      params = build(:add_budget_params)
      actual = AdWords.add_budget(params)

      expect(actual) |> to(eq(add_budget_response()))
    end
  end
end
