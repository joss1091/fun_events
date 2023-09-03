defmodule FunEvents.ShortUrl do
  @url "https://api.short.io/links"
  @api_key "sk_zt9XtRcPCkTsxSWW"
  @headers ["Content-Type": "application/json"]


  def create_short_url(guest) do
    with {:ok , data} <- build_data_from_guest(guest) do
      HTTPoison.post(@url, Jason.encode!(data), build_headers())
      |> handle_response()
      |> get_short_url()
    end
  end

  defp build_headers() do
    @headers ++ ["Authorization": @api_key]

  end

  defp get_short_url({:ok, response}) do
    {:ok, response["shortURL"]}
  end

  defp build_data_from_guest(guest) do
    if !is_nil(guest.token) or true do
      {:ok, %{
        domain: "l.bodasconamor.com.mx",
        originalURL: "josskaren.bodasconamor.com.mx?token=#{guest.token}",
        title: guest.name
      }}
    else
      {:error, "no se puede generar la url por que el invitado no tiene un token generado"}
    end
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 200..299 ->
        {:ok, Jason.decode!(response.body)}

      {:ok, %HTTPoison.Response{status_code: status_code} = response} when status_code in 400..599 ->
        {:error, Jason.decode!(response.body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}

      {:error, _error} ->
        {:error, "Api client error"}
    end
  end
end
