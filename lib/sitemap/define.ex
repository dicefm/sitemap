defmodule Sitemap.Define do
  defmacro define(key, value) do
    quote bind_quoted: [key: key, value: value] do
      Module.put_attribute(__MODULE__, key, value)
      def unquote(key)(), do: unquote(Macro.escape(value))
    end
  end
end
