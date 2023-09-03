defmodule FunEvents.TokenEngine do
  alias FunEvents.Guests.Guest

  @key "ju7nHQeQCEIGe7W7vhHLm2YkhyiNil2Fo3fW4TaslkwBTytzzzNmphz9uocma/n0"
  def config(:secret_key_base) do
    "ju7nHQeQCEIGe7W7vhHLm2YkhyiNil2Fo3fW4TaslkwBTytzzzNmphz9uocma/n0"
  end
  def generate_token(module,  guest) do
    module.sign(__MODULE__, @key, %{id: guest.id}, max_age: 86400 * 80)
  end
  def validate(module, token) do
    module.verify(__MODULE__, @key, token, max_age: 86400 * 8000)
  end
end
