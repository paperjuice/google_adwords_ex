defmodule AdWords.Support.Factories do
  use ExMachina
  use AdWords.Support.Factories.Router

  use AdWords.Support.Factories.Services.{
    CreateMultiAssetAd,
    CreateImage,
    GetCustomers,
    AddBudget
  }

  use AdWords.Support.Factories.Utils.GenerateHrl
  use AdWords.Support.Factories.Utils.OAuthTokens
end
