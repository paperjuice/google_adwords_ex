defmodule AdWords.Authenticate.ManageTokensSpec do
  @moduledoc false

  use ESpec

  alias AdWords.Utils.Authenticate.ManageTokens

  import AdWords.Support.Factories

  let :oauth_token do
    build(:oauth_tokens_get_token_resp)
  end

  context "Happy path for manage tokens" do
    it "store_token works as intended" do
      ManageTokens.store_tokens(oauth_token())

      actual = ManageTokens.get_token(:refresh_token)

      expect(actual) |> to(eq("refresh_token_string"))
    end
  end

  context "Unhappy path for manage tokens :(" do
    it "getting unexistent token name returns error" do
      name = "unexistent_name"
      actual = ManageTokens.get_token(name)

      expect(actual) |> to(eq({:error, "unexistent_name key doesn't exist"}))
    end
  end
end
