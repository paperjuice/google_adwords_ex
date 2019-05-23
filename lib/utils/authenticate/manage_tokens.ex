defmodule AdWords.Utils.Authenticate.ManageTokens do
  @moduledoc """
  Module for storing access token and refresh token on disk using DETS
  """

  @table_name :token

  alias :dets, as: DETS
  alias AdWords.Utils.Logging

  @type name :: atom() | String.t()
  @type token :: String

  @spec store_tokens(map()) :: :ok
  def store_tokens(oauth2) do
    token = Map.get(oauth2, :token)
    access_token = Map.get(token, :access_token)
    refresh_token = Map.get(token, :refresh_token)

    # TODO: Handle unhappy path
    if access_token != nil,
      do: store_token(:access_token, access_token)

    if refresh_token != nil,
      do: store_token(:refresh_token, refresh_token)

    # TODO: Create a logging module
    Logging.info("Access and refresh token stored successfully")
  end

  def get_token(name) do
    response = handle_table(:lookup, [@table_name, name])

    case response do
      # TODO use logger
      [] -> {:error, "#{name} key doesn't exist"}
      _ -> Keyword.get(response, name)
    end
  end

  # ----------------
  # PRIVATE
  # ----------------
  defp handle_table(operation, args) do
    DETS.open_file(@table_name, file: :token_file)
    response = apply(DETS, operation, args)
    DETS.close(@table_name)

    response
  end

  defp store_token(name, token) do
    handle_table(:insert, [@table_name, {name, token}])
  end
end
