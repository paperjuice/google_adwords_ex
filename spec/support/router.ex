defmodule AdWords.Support.Factories.Router do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def create_image_json_response_factory do
        %{
          "success" => true,
          "image_ids" => [11_111_111]
        }
      end
    end
  end
end
