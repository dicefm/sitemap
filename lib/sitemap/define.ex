defmodule Sitemap.Define do
  defmacro define(key, value) do
    quote do
      Module.put_attribute(__MODULE__, unquote(key), unquote(value))
      def unquote(key)(), do: Module.get_attribute(__MODULE__, unquote(key))
    end
  end
end
