defmodule AdWords.Authenticate.TextHtmlSerializerSpec do
  @moduledoc false

  use ESpec

  alias AdWords.Utils.Authenticate.TextHtmlSerializer

  context "Serizalizer happy path" do
    it "returns expected result when valid data is encoded!" do
      data = "some_data"
      actual = TextHtmlSerializer.encode!(data)

      expect(actual) |> to(eq("some_data"))
    end

    it "returns expected result when valid data is decoded!" do
      data = "some_data"
      actual = TextHtmlSerializer.decode!(data)

      expect(actual) |> to(eq("some_data"))
    end
  end
end
