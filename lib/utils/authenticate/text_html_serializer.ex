defmodule AdWords.Utils.Authenticate.TextHtmlSerializer do
  @moduledoc """
  This is the serializer that will handle the response/request data
  format based on the MIME type
  If you need to handle different MIME types,
  you can configure it under config.ex
  """

  def encode!(data), do: data
  def decode!(binary), do: binary
end
