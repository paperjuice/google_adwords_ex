defmodule AdWords.Utils.GenerateHrlSpec do
  @moduledoc false

  use ESpec

  import AdWords.Support.Factories

  alias AdWords.Utils.GenerateHrl

  context "Happy path for generate .hrl files" do
    it "returns :ok when valid data is passed" do
      allow(
        :soap
        |> to(
          accept(
            :wsdl2erlang,
            fn _wsdl_file, _opts -> :ok end
          )
        )
      )

      allow(
        File
        |> to(
          accept(
            :rename,
            fn _item, _path -> :ok end
          )
        )
      )

      opts = build(:generate_hrl_opts)
      wsdl_file = "path/of/wsdl/file.wsdl"
      actual = GenerateHrl.wsdl_to_erlang(wsdl_file, opts)

      expect(actual) |> to(eq(:ok))
    end
  end
end
